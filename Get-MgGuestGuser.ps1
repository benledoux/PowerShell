# Connect to Microsoft Graph
Connect-MgGraph -Scopes 'User.Read.All'

# Get all users
Get-MgUser -Filter "userType eq 'Guest'" -All -Property Mail,UserPrincipalName,userType,accountEnable | Select-Object Mail,UserPrincipalName,userType,accountEnable
