*** Settings ***
Library    SeleniumLibrary
Resource   browser_manager.robot
Resource   common_helpers.robot

*** Variables ***
${COOKIE_CONSENT_CONTAINER}    xpath=//div[@data-cky-tag='notice' or contains(@class, 'cky-consent-container')]
${COOKIE_ACCEPT_BUTTON}        xpath=//button[@data-cky-tag='accept-button']

${USERNAME_FIELD}       id=input-login-email
${PASSWORD_FIELD}       id=input-login-password
${LOGIN_BUTTON}         id=btn-log-in
${PASSWORD_TOGGLE}      xpath=//button[@class='toggle-password']

${PAGE_HEADING}         xpath=//h1[contains(text(), 'Razer ID Login')]
${SOCIAL_LOGIN_TEXT}    xpath=//*[contains(text(), 'or log in with')]

${FORGOT_PASSWORD_LINK}     xpath=//div[@class="forgot-password"]//a[@href='/recovery']
${CREATE_ACCOUNT_LINK}      xpath=//div[@class="buttons-login"]//div//a[@href='/new']

${APPLE_LOGIN_BTN}      xpath=//div[@class="ssi"]//div//button[contains(@class, 'apple')]
${FACEBOOK_LOGIN_BTN}   xpath=//div[@class="ssi"]//div//button[contains(@class, 'fb')]
${GOOGLE_LOGIN_BTN}     xpath=//div[@class="ssi"]//div//button[contains(@class, 'gplus')]
${TWITCH_LOGIN_BTN}     xpath=//div[@class="ssi"]//div//button[contains(@class, 'twitch')]
${WECHAT_LOGIN_BTN}     xpath=//div[@class="ssi"]//div//button[contains(@class, 'wechat')]

${ERROR_MESSAGE}        id=main-alert
${ERROR_MESSAGE_TEXT}   xpath=//div[@id='main-alert']//div[@class='dialog']

*** Keywords ***
Wait For Page To Load After Login
    [Documentation]    Waits for page to complete loading after login submission
    ${status}=    Run Keyword And Return Status
    ...    Wait Until Element Is Not Visible    ${LOGIN_BUTTON}    timeout=3s
    IF    not ${status}
        Log    Login button still visible, waiting for page change    level=INFO
    END

Handle Cookie Consent
    [Documentation]    Waits for cookie popup and accepts it
    ${consent_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${COOKIE_CONSENT_CONTAINER}    timeout=5s
    Log    Cookie consent container visible: ${consent_visible}    level=INFO
    IF    ${consent_visible}
        Accept Cookie Consent
    END

Accept Cookie Consent
    [Documentation]    Clicks Accept All button on cookie popup and waits for it to disappear
    Click Element Wrapper    ${COOKIE_ACCEPT_BUTTON}    cookie accept button
    Wait Until Element Is Not Visible    ${COOKIE_CONSENT_CONTAINER}    timeout=5s

Login With Credentials
    [Arguments]    ${username}    ${password}
    [Documentation]    Enters credentials and submits login
    Log    Starting login with username: ${username}    level=INFO
    Click Element Wrapper    ${USERNAME_FIELD}    username field
    Input Text Wrapper    ${USERNAME_FIELD}    ${username}    username field
    Click Element Wrapper    ${PASSWORD_FIELD}    password field
    Input Text Wrapper    ${PASSWORD_FIELD}    ${password}    password field
    Click Element Wrapper    ${LOGIN_BUTTON}    login button
    Wait For Page To Load After Login
