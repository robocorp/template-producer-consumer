*** Settings ***
Library           Collections
Library           RPA.Excel.Files
Library           RPA.Robocorp.WorkItems
Library           RPA.Tables

*** Tasks ***
Produce Items
    [Documentation]
    ...    Get source Excel file from work item.
    ...    Read rows from Excel.
    ...    Creates output work items per row.
    ${path}=    Get Work Item File    orders.xlsx    %{ROBOT_ARTIFACTS}${/}orders.xlsx
    Open Workbook    ${path}
    ${table}=    Read Worksheet As Table    header=True
    FOR    ${row}    IN    @{table}
        Create Output Work Item
        Set Work Item Variable    Name    ${row}[Name]
        Set Work Item Variable    Zip    ${row}[Zip]
        Set Work Item Variable    Item    ${row}[Item]
        Save Work Item
    END
