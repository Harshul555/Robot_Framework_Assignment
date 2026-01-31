*** Settings ***
Documentation    Login Test Suite
Resource         ../resources/login_page.robot
Resource         ../resources/verifications.robot
Resource         ../resources/browser_manager.robot
Resource         ../resources/common_helpers.robot
Library          String
Library          ../resources/CSVReader.py

Suite Setup      Load CSV Data
Test Setup       Setup Test With Data
Test Teardown    Close Browser Session

*** Variables ***
${CSV_FILE_PATH}        ${CURDIR}/../data/login_data.csv
${CSV_DATA}             ${EMPTY}
${CURRENT_TEST_DATA}    ${EMPTY}

*** Test Cases ***
TC001: Verify Login Page Elements
    [Documentation]    Verify all login page elements are visible
    [Tags]    smoke    ui
    Verify Complete Login Page

TC002: Login With Valid Credentials
    [Documentation]    Test successful login with valid credentials
    [Tags]    smoke    positive
    ${username}=    Get Test Data Value    username
    ${password}=    Get Test Data Value    password
    Login With Credentials    ${username}    ${password}
    Verify Successful Login

TC003: Login With Invalid Credentials
    [Documentation]    Test failed login with invalid credentials
    [Tags]    negative
    ${username}=    Get Test Data Value    username
    ${password}=    Get Test Data Value    password
    ${expected_message}=    Get Test Data Value    expected_message
    Login With Credentials    ${username}    ${password}
    Verify Failed Login    ${expected_message}

*** Keywords ***
Load CSV Data
    [Documentation]    Loads test data from CSV file
    Log    Loading CSV data from: ${CSV_FILE_PATH}    level=INFO
    ${csv_data}=    Read CSV File    ${CSV_FILE_PATH}
    Set Suite Variable    ${CSV_DATA}    ${csv_data}

Get Test Data For Current Test
    [Documentation]    Gets test data for current test case
    ${test_name}=    Get Test Case Name
    ${test_data}=    Get Test Data By Test Case    ${CSV_DATA}    ${test_name}
    RETURN    ${test_data}

Setup Test With Data
    [Documentation]    Sets up test with data for current test case
    ${test_name}=    Get Test Case Name
    Log    Starting setup for test: ${test_name}    level=INFO
    ${test_data}=    Get Test Data For Current Test
    Set Test Variable    ${CURRENT_TEST_DATA}    ${test_data}
    ${login_url}=    Get Test Param    ${test_data}    login_url
    Open Browser And Navigate To URL    ${login_url}
    Handle Cookie Consent
    Click Element Wrapper    ${USERNAME_FIELD}    username field

Get Test Case Name
    [Documentation]    Extracts test case ID from test name
    ${full_name}=    Set Variable    ${TEST_NAME}
    ${parts}=    Split String    ${full_name}    :
    ${test_id}=    Strip String    ${parts}[0]
    RETURN    ${test_id}

Get Test Data Value
    [Arguments]    ${param_name}    ${default_value}=${EMPTY}
    [Documentation]    Gets parameter value from test data
    ${value}=    Get Test Param    ${CURRENT_TEST_DATA}    ${param_name}    ${default_value}
    RETURN    ${value}
