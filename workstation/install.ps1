[CmdletBinding()]
param(
    [string]$Destination = (Join-Path $HOME ".engineering-focus"),
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Required = @(
    "skills\engineering-focus\SKILL.md",
    "core\policy.yaml",
    "core\modes.yaml",
    "core\handoff-schema.json",
    "core\telemetry-schema.json"
)

foreach ($relative in $Required) {
    $source = Join-Path $RepoRoot $relative
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
        throw "Required Engineering Focus file is missing: $source"
    }
}

if (Test-Path -LiteralPath $Destination) {
    if (-not $Force) {
        throw "Destination already exists: $Destination. Re-run with -Force to replace it."
    }
    Remove-Item -LiteralPath $Destination -Recurse -Force
}

New-Item -ItemType Directory -Path $Destination -Force | Out-Null

$Directories = @("skills", "core", "agents", "integrations")
foreach ($directory in $Directories) {
    $source = Join-Path $RepoRoot $directory
    if (Test-Path -LiteralPath $source -PathType Container) {
        Copy-Item -LiteralPath $source -Destination $Destination -Recurse -Force
    }
}

foreach ($file in @("VERSION", "LICENSE", "THIRD_PARTY_NOTICES.md", "AGENTS.md", "CLAUDE.md")) {
    $source = Join-Path $RepoRoot $file
    if (Test-Path -LiteralPath $source -PathType Leaf) {
        Copy-Item -LiteralPath $source -Destination $Destination -Force
    }
}

$installedSkill = Join-Path $Destination "skills\engineering-focus\SKILL.md"
Write-Host "Engineering Focus installed to: $Destination"
Write-Host "Canonical skill: $installedSkill"
Write-Host "This installer does not modify provider-specific configuration automatically."
Write-Host "See $Destination\integrations for provider guidance."
