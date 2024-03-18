#Imports
Import-Module -Name $PSScriptRoot\Get-FileName.ps1

Write-Host "Connecting to Microsoft Graph API"

# Connect to Microsoft Graph
Connect-MgGraph -Scopes 'User.Read.All'

$inputDecision = Read-Host "Type 1 for Guest User output to console or 2 for Guest User output to CSV"

if($inputDecision -eq "1") {
    Get-MgUser -Filter "userType eq 'Guest'" -All -Property Mail,UserPrincipalName,userType,accountEnable | Select-Object Mail,UserPrincipalName,userType,accountEnable
} elseif ($inputDecision -eq "2") {
    # Get all users
    Write-Host "Getting all Microsoft Guest accounts in Azure Tenant"
    $guestUsers = Get-MgUser -Filter "userType eq 'Guest'" -All -Property Mail,UserPrincipalName,userType,accountEnable | Select-Object Mail,UserPrincipalName,userType,accountEnable

    # File Save information
    $fileName = Get-FileName

    $fileNameInput = "n"

    while($fileNameInput -eq "n") {
        $fileNameInput = Read-Host "Save location is " $fileName " is this correct? Type 'n' to re-input or <enter> to continue"
        if($fileNameInput -eq "n"){
            $fileName = Get-FileName
        }
        else {
            $fileNameInput = $null
        }
    }

    Write-Host 'Saving File'

    # Outputting to CSV file
    $guestUsers | Export-Csv $fileName -NoTypeInformation
}