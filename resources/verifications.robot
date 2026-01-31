*** Settings ***
Documentation    Verification keywords for login testing
Resource         login_page.robot
Resource         common_helpers.robot
Library          String

*** Keywords ***
Verify Successful Login
    [Documentation]    Verifies login was successful by checking form is no longer visible
    ${login_form_gone}=    Run Keyword And Return Status
    ...    Wait Until Element Is Not Visible    ${USERNAME_FIELD}    timeout=10s
    IF    not ${login_form_gone}
        Fail    Login failed - form still visible after 10s, user not redirected
    END
    ${current_url}=    Get Current URL Wrapper
    Should Not Contain    ${current_url}    razerid.razer.com

Verify Failed Login
    [Arguments]    ${expected_error_message}=${EMPTY}
    [Documentation]    Verifies login failed with error message
    ${error_visible}=    Wait For Element Wrapper    ${ERROR_MESSAGE}    error message    10s
    IF    not ${error_visible}
        Fail    Error message did not appear after failed login attempt
    END
    IF    $expected_error_message != ""
        Verify Error Message Text    ${expected_error_message}
    END
    ${current_url}=    Get Current URL Wrapper
    Should Contain    ${current_url}    razerid.razer.com
    Verify Element Visible    ${USERNAME_FIELD}    username field

Verify Error Message Text
    [Arguments]    ${expected_text}
    [Documentation]    Verifies error message contains expected text
    Wait Until Element Is Visible    ${ERROR_MESSAGE_TEXT}    timeout=5s
    ${error_text}=    Get Element Text Wrapper    ${ERROR_MESSAGE_TEXT}    Error message
    ${matches}=    Run Keyword And Return Status
    ...    Should Contain    ${error_text}    ${expected_text}    ignore_case=True
    IF    not ${matches}
        Fail    Expected: '${expected_text}', Got: '${error_text}'
    END

Verify Login Form Elements Are Visible
    [Documentation]    Verifies main login form elements are visible
    Verify Element Visible    ${USERNAME_FIELD}    username field
    Verify Element Visible    ${PASSWORD_FIELD}    password field
    Verify Element Visible    ${LOGIN_BUTTON}    login button

Verify Forgot Password Link Is Visible
    [Documentation]    Verifies forgot password link is visible
    Verify Element Visible    ${FORGOT_PASSWORD_LINK}    forgot password link

Verify All Social Login Buttons Are Visible
    [Documentation]    Verifies all 5 social login buttons are visible
    Verify Element Visible    ${APPLE_LOGIN_BTN}    Apple login button
    Verify Element Visible    ${FACEBOOK_LOGIN_BTN}    Facebook login button
    Verify Element Visible    ${GOOGLE_LOGIN_BTN}    Google login button
    Verify Element Visible    ${TWITCH_LOGIN_BTN}    Twitch login button
    Verify Element Visible    ${WECHAT_LOGIN_BTN}    WeChat login button

Verify Login Page Heading
    [Documentation]    Verifies page heading is visible
    Verify Element Visible    ${PAGE_HEADING}    page heading

Verify Social Login Text
    [Documentation]    Verifies social login text is visible
    Verify Element Visible    ${SOCIAL_LOGIN_TEXT}    social login text

Verify Complete Login Page
    [Documentation]    Verifies all major elements of login page
    Verify Login Page Heading
    Verify Login Form Elements Are Visible
    Verify Forgot Password Link Is Visible
    Verify All Social Login Buttons Are Visible
    Verify Social Login Text
