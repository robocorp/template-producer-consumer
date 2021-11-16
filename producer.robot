*** Settings ***
Library           Collections
Library           RPA.Robocorp.WorkItems
Library           RPA.Excel.Files
Library           RPA.Tables

*** Variables ***
${ORDER_FILE_NAME}=    orders.xlsx

*** Tasks ***
Produce Items
    [Documentation]    Read rows from Excel and splits into output work items
    &{dict} =	Create Dictionary	key=value	foo=bar	
    Get Work Item File    ${ORDER_FILE_NAME}
    Open Workbook    ${ORDER_FILE_NAME}
    ${table}=    Read Worksheet As Table    header=True
    ${groups}=    Group Table By Column    ${table}    Name
    FOR    ${products}    IN    @{groups}
        Create Output Work Item
        ${rows}=    Export Table    ${products}
        @{items}=    Create List
        FOR    ${row}    IN    @{rows}
            Set Work Item Variable    Name    ${row}[Name]
            Set Work Item Variable    Zip     ${row}[Zip]
            Set Work Item Variable    Items   ${row}[Item]
        END
        Save Work Item
    END
