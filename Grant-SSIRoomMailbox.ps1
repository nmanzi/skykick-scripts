# This will grant the specified account FullAccess rights on all
# Room Mailboxes.
#
# Requires active Exchange Online Powershell sessions
#
# nathan@diverse.services 06092019
#

$MailboxList = Get-Mailbox -RecipientTypeDetails RoomMailbox
$SSIUserPN = "administrator@mydomain.com"

foreach ($mailbox in $MailboxList) {
    Add-MailboxPermission -Identity $mailbox.Identity -User $SSIUserPN -AccessRights FullAccess -InheritanceType All
}