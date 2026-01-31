# Login Test Framework

Automated testing framework for Razer ID login functionality using Robot Framework and Selenium.

## Table of Contents
- [Setup Instructions](#setup-instructions)
- [How to Execute Tests](#how-to-execute-tests)
- [Test Design](#test-design)
- [Project Structure](#project-structure)
- [AI Tool Usage](#ai-tool-usage)

---

## Setup Instructions

### Prerequisites
- Python 3.10+
- Chrome browser

### Installation

1. **Create and activate virtual environment**
   ```bash
   python3 -m venv venv
   source venv/bin/activate    # macOS/Linux
   venv\Scripts\activate       # Windows
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

---

## How to Execute Tests

### Quick Start
```bash
./run_tests.sh
```
Automatically executes tests, retries failures, captures screenshots, and opens the HTML report.

### Execution Options

**Headless mode:**
```bash
HEADLESS=True ./run_tests.sh
```

**Run by tag:**
```bash
robot --outputdir results --include smoke tests/login.robot
robot --outputdir results --include positive tests/login.robot
```

**Run specific test:**
```bash
robot --outputdir results --test "TC001*" tests/login.robot
```

### View Results
Results are in the `results/` directory:
- `report.html` - Test summary (auto-opens)
- `log.html` - Detailed execution log with screenshots
- `output.xml` - Machine-readable data

---

## Test Design

### Architecture
Layered architecture with clear separation:

```
Tests → Verifications → Page Objects → Common Helpers → Browser Management
```

### Key Design Decisions

**1. Data-Driven Testing (CSV)**
- Test data in `login_data.csv` for easy maintenance without code changes
- Non-technical users can update test cases

**2. Wrapper Method Pattern**
- Centralized logging and waits
- Consistent element interactions across all tests

**3. Automatic Screenshot Capture**
- Python listener captures screenshots on any failure
- Embedded in HTML reports automatically

**4. Automatic Retry Logic**
- Uses Robot Framework's `--rerunfailed` feature
- One retry for failed tests to handle flaky scenarios

**5. Implicit Waits + Wrapper Waits**
- 5-second implicit wait + explicit waits in wrappers
- Eliminates scattered `Sleep` statements

**6. Headless Mode Support**
- Optional via environment variable for CI/CD compatibility

### Test Coverage

**TC001: Verify Login Page Elements** (smoke, ui)
- Validates all UI elements are present and visible

**TC002: Login With Valid Credentials** (smoke, positive)
- Tests successful authentication and redirect

**TC003: Login With Invalid Credentials** (negative)
- Tests error handling and message display

---

## Project Structure

```
login_test_framework/
├── data/
│   └── login_data.csv              # Test data
├── resources/
│   ├── browser_manager.robot       # Browser operations
│   ├── common_helpers.robot        # Wrapper methods
│   ├── login_page.robot            # Page objects
│   ├── verifications.robot         # Verification keywords
│   ├── CSVReader.py                # CSV reader
│   └── ScreenshotListener.py       # Screenshot listener
├── tests/
│   └── login.robot                 # Test cases
├── results/                        # Auto-generated reports
├── requirements.txt                # Dependencies
└── run_tests.sh                    # Execution script
```

---

## AI Tool Usage

### AI-Assisted Development

This framework was developed using **Cursor AI with Claude Sonnet 4.5** to accelerate the development process. The AI assisted in:

- Generating initial test scripts and framework structure
- Implementing the layered architecture and wrapper pattern
- Creating the CSV-based data-driven testing approach
- Setting up automatic screenshot capture and retry logic
- Writing resource files and helper methods

**Human Review & Validation:**

All AI-generated code was thoroughly reviewed, modified, and verified to ensure:
- Compliance with project requirements and specifications
- Proper functionality through hands-on testing
- Code quality and maintainability standards
- Best practices for Robot Framework test automation
- Accurate implementation of test scenarios

The final framework represents a collaborative effort where AI provided rapid prototyping and boilerplate code, while human oversight ensured quality, accuracy, and alignment with specific testing needs.

---

## Key Features

- Data-Driven Testing (CSV)
- Automatic Retries
- Screenshot on Failure
- Headless Mode Support
- Layered Architecture
- Implicit Waits
