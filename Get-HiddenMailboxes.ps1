# This will dump a CSV of all Office 365 mailboxes that
# are hidden from the GAL.
#
# Requires active Exchange Online Powershell sessions
#
# nathan@diverse.services 06092019
#

$AllMailboxes = Get-Mailbox
$HiddenMailboxes = $AllMailboxes | where-object {$_.HiddenFromAddressListsEnabled -eq $true}

$HiddenMailboxes | Select-Object DisplayName,PrimarySmtpAddress,UserPrincipalName,HiddenFromAddressListsEnabled | Export-Csv -Path C:\Temp\HiddenUsers.csv -NoTypeInformation