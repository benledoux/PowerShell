Import-Module -Name $PSScriptRoot\Get-FileName.ps1

Connect-ExchangeOnline

Write-Host 'Connected to Exchange Online'

Write-Host 'Getting mailbox information for all users in environment (This may take some time)'

$tmp = Get-Mailbox -ResultSize Unlimited | select UserPrincipalName,ForwardingSmtpAddress,ForwardingAddress,DeliverToMailboxAndForward

Write-Host 'Mailbox information received'

Write-Host 'Opening Windows Save As Dialog'

$fileName = Get-FileName

$input = "n"

while($input -eq "n"){
    $input = Read-Host "Save location is " $fileName " is this correct? Type 'n' to re-input"
    if($input -eq "n") {
        $fileName = Get-FileName
    }
    else {
        input = $null
    }
}

Write-Host 'Saving file'

$tmp | Export-Csv $fileName -NoTypeInformation