*** Settings ***
Documentation    Common helper keywords used across the framework
Library          SeleniumLibrary
Library          String

*** Keywords ***
Click Element Wrapper
    [Arguments]    ${locator}    ${element_name}
    [Documentation]    Waits for element, clicks it and logs the action
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Log    Clicking on ${element_name}    level=INFO
    Click Element    ${locator}

Input Text Wrapper
    [Arguments]    ${locator}    ${text}    ${element_name}
    [Documentation]    Enters text in element and logs the action
    Log    Entering text in ${element_name}: ${text}    level=INFO
    Input Text    ${locator}    ${text}

Get Element Text Wrapper
    [Arguments]    ${locator}    ${element_name}
    [Documentation]    Gets text from element and logs it
    ${text}=    Get Text    ${locator}
    ${trimmed_text}=    Strip String    ${text}
    Log    ${element_name} text: ${trimmed_text}    level=INFO
    RETURN    ${trimmed_text}

Check Element Visibility Wrapper
    [Arguments]    ${locator}    ${element_name}
    [Documentation]    Checks if element is visible and logs result
    ${is_visible}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${locator}
    Log    ${element_name} visible: ${is_visible}    level=INFO
    RETURN    ${is_visible}

Verify Element Visible
    [Arguments]    ${locator}    ${element_name}
    [Documentation]    Verifies element is visible with logging
    Log    Verifying ${element_name} is visible    level=INFO
    Element Should Be Visible    ${locator}

Wait For Element Wrapper
    [Arguments]    ${locator}    ${element_name}    ${timeout}=5s
    [Documentation]    Waits for element to be visible and logs the action
    Log    Waiting for ${element_name} to be visible    level=INFO
    ${is_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    RETURN    ${is_visible}

Get Current URL Wrapper
    [Documentation]    Gets current URL with logging
    ${url}=    Get Location
    Log    Current URL: ${url}    level=INFO
    RETURN    ${url}
