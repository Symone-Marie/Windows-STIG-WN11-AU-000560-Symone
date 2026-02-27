<#
.SYNOPSIS
    This PowerShell script configures auditing for Other Logon/Logoff Events Successes.
.NOTES
    Author          : Symone-Marie Priester
    LinkedIn        : linkedin.com/in/symone-mariepriester
    GitHub          : github.com/Symone-Marie
    Date Created    : 2026-02-26
    Last Modified   : 2026-02-26
    Version         : Microsoft Windows [Version 10.0.26200.7623]
    CVEs            : N/A
    Vuln-ID         : V-253345
    STIG-ID         : WN11-AU-000560
.TESTED ON
    Date(s) Tested  : 2026-02-26
    Tested By       : Symone-Marie Priester
    Systems Tested  : Windows 11 Pro OS
    PowerShell Ver. : 5.1
    Manual Test     : Yes, remediated via Local Group Policy Editor (gpedit.msc) with screenshot documentation
.USAGE
    Enables Success auditing for Other Logon/Logoff Events.
    Example syntax:
    PS C:\> .\remediation_WN11-AU-000560.ps1
#>

Write-Host "Configuring Audit Other Logon/Logoff Events - Success..."

# Apply audit policy
auditpol /set /subcategory:"Other Logon/Logoff Events" /success:enable

# Verify the change
Write-Host "`nVerifying configuration..."
$result = auditpol /get /subcategory:"Other Logon/Logoff Events"

if ($result -match "Success") {
    Write-Host "SUCCESS: WN11-AU-000560 remediated - Other Logon/Logoff Events Success auditing is enabled" -ForegroundColor Green
    Write-Host "`nCurrent audit policy:"
    auditpol /get /subcategory:"Other Logon/Logoff Events"
} else {
    Write-Host "ERROR: Failed to configure audit policy" -ForegroundColor Red
}

# Apply Group Policy changes immediately
Write-Host "`nApplying Group Policy update..."
gpupdate /force
