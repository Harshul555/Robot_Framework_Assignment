*** Settings ***
Documentation    Browser management keywords
Library          SeleniumLibrary

*** Variables ***
${BROWSER}              Chrome
${HEADLESS}             False
${TIMEOUT}              10s
${IMPLICIT_WAIT}        5s

*** Keywords ***
Configure Browser
    [Documentation]    Configures browser settings
    Log    Setting implicit wait to ${IMPLICIT_WAIT}    level=INFO
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Log    Setting timeout to ${TIMEOUT}    level=INFO
    Set Selenium Timeout    ${TIMEOUT}

Open Browser And Navigate To URL
    [Arguments]    ${url}
    [Documentation]    Opens browser and navigates to URL
    Log    Opening browser for URL: ${url}    level=INFO
    IF    '${HEADLESS}' == 'True'
        Log    Running in headless mode    level=INFO
        ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
        Call Method    ${chrome_options}    add_argument    --headless
        Call Method    ${chrome_options}    add_argument    --no-sandbox
        Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
        Call Method    ${chrome_options}    add_argument    --disable-gpu
        Call Method    ${chrome_options}    add_argument    --window-size=1920,1080
        Open Browser    ${url}    ${BROWSER}    options=${chrome_options}
    ELSE
        Open Browser    ${url}    ${BROWSER}
        Log    Maximizing browser window    level=INFO
        Maximize Browser Window
    END
    Configure Browser

Close Browser Session
    [Documentation]    Closes the browser session
    Log    Closing browser    level=INFO
    Close Browser
