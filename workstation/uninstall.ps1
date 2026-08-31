[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Destination = (Join-Path $HOME ".engineering-focus")
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Destination)) {
    Write-Host "Engineering Focus is not installed at: $Destination"
    exit 0
}

if ($PSCmdlet.ShouldProcess($Destination, "Remove Engineering Focus workstation files")) {
    Remove-Item -LiteralPath $Destination -Recurse -Force
    Write-Host "Removed Engineering Focus from: $Destination"
}
