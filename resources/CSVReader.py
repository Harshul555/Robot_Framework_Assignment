"""
CSV Reader Library for Robot Framework
Reads CSV files and returns data as a list of dictionaries
"""

import csv
import os


class CSVReader:
    """
    Library for reading CSV files in Robot Framework tests.
    """

    def read_csv_file(self, file_path):
        """
        Reads a CSV file and returns a list of dictionaries.
        
        Args:
            file_path: Path to the CSV file
            
        Returns:
            List of dictionaries where each dictionary represents a row
            
        Example:
            | ${data}= | Read CSV File | path/to/file.csv |
        """
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"CSV file not found: {file_path}")
        
        data = []
        with open(file_path, 'r', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                data.append(row)
        
        return data
    
    def get_row_by_index(self, csv_data, index):
        """
        Gets a specific row from CSV data by index.
        
        Args:
            csv_data: List of dictionaries from Read CSV File
            index: Zero-based index of the row to retrieve
            
        Returns:
            Dictionary containing the row data
            
        Example:
            | ${row}= | Get Row By Index | ${csv_data} | 0 |
        """
        if not csv_data:
            raise ValueError("CSV data is empty")
        
        if index < 0 or index >= len(csv_data):
            raise IndexError(f"Index {index} out of range. CSV has {len(csv_data)} rows.")
        
        return csv_data[index]
    
    def get_row_by_field_value(self, csv_data, field_name, field_value):
        """
        Gets the first row that matches a field value.
        
        Args:
            csv_data: List of dictionaries from Read CSV File
            field_name: Name of the field to search
            field_value: Value to search for
            
        Returns:
            Dictionary containing the matching row data
            
        Example:
            | ${row}= | Get Row By Field Value | ${csv_data} | expected_result | success |
        """
        for row in csv_data:
            if row.get(field_name) == field_value:
                return row
        
        raise ValueError(f"No row found with {field_name}={field_value}")
    
    def get_all_rows_by_field_value(self, csv_data, field_name, field_value):
        """
        Gets all rows that match a field value.
        
        Args:
            csv_data: List of dictionaries from Read CSV File
            field_name: Name of the field to search
            field_value: Value to search for
            
        Returns:
            List of dictionaries containing all matching rows
            
        Example:
            | ${rows}= | Get All Rows By Field Value | ${csv_data} | expected_result | failure |
        """
        matching_rows = [row for row in csv_data if row.get(field_name) == field_value]
        
        if not matching_rows:
            raise ValueError(f"No rows found with {field_name}={field_value}")
        
        return matching_rows
    
    def get_csv_row_count(self, csv_data):
        """
        Returns the number of rows in the CSV data.
        
        Args:
            csv_data: List of dictionaries from Read CSV File
            
        Returns:
            Integer count of rows
            
        Example:
            | ${count}= | Get CSV Row Count | ${csv_data} |
        """
        return len(csv_data)
    
    def get_test_data_by_test_case(self, csv_data, test_case_name):
        """
        Gets test data for a specific test case name.
        
        Args:
            csv_data: List of dictionaries from Read CSV File
            test_case_name: Name of the test case (e.g., 'TC001')
            
        Returns:
            Dictionary containing the test data for that test case
            
        Example:
            | ${data}= | Get Test Data By Test Case | ${csv_data} | TC001 |
            | Log | ${data}[login_url] |
        """
        for row in csv_data:
            if row.get('test_case') == test_case_name:
                return row
        
        raise ValueError(f"No test data found for test case: {test_case_name}")
    
    def get_test_param(self, test_data, param_name, default_value=''):
        """
        Gets a parameter value from test data, returns default if empty or missing.
        
        Args:
            test_data: Dictionary containing test data
            param_name: Name of the parameter to retrieve
            default_value: Default value if parameter is empty or missing (default: '')
            
        Returns:
            Parameter value or default value
            
        Example:
            | ${username}= | Get Test Param | ${test_data} | username | default@example.com |
        """
        value = test_data.get(param_name, default_value)
        # Return default if value is None or empty string
        return value if value else default_value
