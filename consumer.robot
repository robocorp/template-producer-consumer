*** Settings ***
Library           RPA.Robocorp.WorkItems
Library           RPA.Tables
Library    Collections
Library    RPA.Browser.Selenium

*** Keywords ***
Login
    [Documentation]    
    ...    Simulating a login that fails to highlight exception handling.
    ...    In this example login is performed only once for all work items.

    ${random}=    Evaluate    random.randint(1, 2) 
    IF    ${random} == 1 
        Log     Logged in as Bond
    ELSE    
        Fail    Login failed    
    END


*** Keywords ***
Action For One Item
    [Documentation]    Simulating a handling of item that fails to highlight exception handling.
    [Arguments]    ${payload}

    ${random}=    Evaluate    random.randint(1, 2) 
    IF    ${random} == 1 
        Log    Order for: ${payload}[Name] zip: ${payload}[Zip] items: ${payload}[Items]
    ELSE    
        Fail   Order handling failed.
    END
    

*** Keywords ***
Handle One Item
    [Documentation]    Process one work item
    ${payload}=    Get Work Item Payload
    ${passed}=    Run Keyword And Return Status
    ...    Action For One Item    ${payload} 
    IF    ${passed}
        Release Input Work Item    DONE    
    ELSE
        Log    Order Item failed for: ${payload}[Name]    level=ERROR
        Release Input Work Item
        ...    state=FAILED
        ...    exception_type=BUSINESS
        ...    message=Order prosessing failed for: ${payload}[Name]. Please check the work item data for errors.
    END


*** Tasks ***
Consume Items
    [Documentation]    Login and then cycle through work items

    ${passed}=    Run Keyword And Return Status
    ...    Login
    IF    ${passed}
        For Each Input Work Item    Handle One Item
    ELSE
        Log    Login to system X failed!
        Release Input Work Item
        ...    state=FAILED
        ...    exception_type=APPLICATION
        ...    message=Unable to login to X. Please check that the site/application is available.
    END
