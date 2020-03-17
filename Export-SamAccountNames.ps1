# This script will export a list of SAMAccountNames and their
# respective email addresses for import into a SkyKick project.
# This will assist in silent deployment of the Outlook Assistant.
#
# nathan@diverse.services 10092019
#
# Usage:
# .\Export-SamAccountNames.ps1 -CSVPath C:\Temp\UserList.csv
# This will dump the list of entries to C:\Temp\UserList.csv

#region Script Parameters
# -----------------------

[CmdletBinding(SupportsShouldProcess=$True)]
Param (
    [parameter(
                Mandatory=$true,
                HelpMessage='Path to where the CSV should be exported')]
                [string]$CSVPath
)

Import-Module ActiveDirectory

#endregion

#region Variables
#----------------

$a=@{Expression={$_.EmailAddress};Label="SourceEmailAddress"}, `
@{Expression={$_.SamAccountName};Label="SourceSAMAccountName"}

#endregion

#region Program
#--------------

$AllUsers = get-aduser –filter * -properties *
$AllUsers | where-object {$_.EmailAddress -ne $null -and $_.EmailAddress -NotLike "*.local" -and $_.Enabled -eq $True} | Select-Object $a | export-csv -path $CSVPath –notypeinformation

#endregion