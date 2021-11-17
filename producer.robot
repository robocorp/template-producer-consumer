*** Settings ***
Library           Collections
Library           RPA.Robocorp.WorkItems
Library           RPA.Excel.Files
Library           RPA.Tables

*** Tasks ***
Produce Items
    [Documentation]    
    ...    Get source Excel file from work item.
    ...    Read rows from Excel.
    ...    Create output work items.

    ${path}=     Get Work Item File      orders.xlsx     %{ROBOT_ARTIFACTS}${/}orders.xlsx
    Open Workbook           ${path}

    ${table}=    Read Worksheet As Table    header=True
    ${groups}=    Group Table By Column    ${table}    Name
    
    FOR    ${products}    IN    @{groups}
        Create Output Work Item
        ${rows}=    Export Table    ${products}
        FOR    ${row}    IN    @{rows}
            Set Work Item Variable    Name    ${row}[Name]
            Set Work Item Variable    Zip     ${row}[Zip]
            Set Work Item Variable    Items   ${row}[Item]
        END
        Save Work Item
    END
