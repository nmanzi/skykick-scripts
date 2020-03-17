# This script will enable or disable the msExchHideFromAddressLists
# AD user parameter, effectively hiding or unhiding the user
# from the GAL.
#
# Accepts a CSV file containing a list of UserPrincipalNames with 
# a header of UserPrincipalName.
#
# nathan@diverse.services 06092019
#
# Usage:
# To hide users from GAL - .\Set-UserHiddenFromGal.ps1 -Enabled $true -CSVPath C:\Temp\UserList.csv
# To unhide users from GAL - .\Set-UserHiddenFromGal.ps1 -Enabled $false -CSVPath C:\Temp\UserList.csv

#region Script Parameters
# -----------------------

[CmdletBinding(SupportsShouldProcess=$True)]
Param (   
    [parameter(
                Mandatory=$true,
                HelpMessage='Enable or disable msExchHideFromAddressLists parameter')]
                [bool]$Enabled,
    [parameter(
                Mandatory=$true,
                HelpMessage='Path to list of users')]
                [string]$CSVPath
)

Import-Module ActiveDirectory

#endregion

#region Variables
#----------------

$HiddenUsers = Import-Csv -Path $CSVPath

#endregion

#region Program
#--------------

foreach ($User in $HiddenUsers) {

    # Set the msExchHideFromAddressLists parameter based on input.
    $upn = $User.UserPrincipalName
    if ($Enabled) {Write-Host "Hiding user $upn"} else {Write-Host "Unhiding user $upn"}
    Set-ADUser $upn -Replace @{msExchHideFromAddressLists=$Enabled}
}

#endregion