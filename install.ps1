#Requires -Version 7.0
<#
  Symlink this repo's agent config into Claude Code and OpenCode.
  Windows counterpart to install.sh. Safe to re-run - links are replaced in place.

  Requires Developer Mode (Settings > System > For developers) or an elevated shell.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Repo = $PSScriptRoot

function Link {
  param([string]$Source, [string]$Dest)

  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Dest) | Out-Null

  $existing = Get-Item -LiteralPath $Dest -Force -ErrorAction SilentlyContinue
  if ($existing) { Remove-Item -LiteralPath $Dest -Force -Recurse }

  New-Item -ItemType SymbolicLink -Path $Dest -Target $Source | Out-Null
  Write-Host "  $Dest -> $Source" -ForegroundColor DarkGray
}

# Skills are linked one directory at a time so standalone skills installed
# outside this repo can live alongside them.
function LinkSkills {
  param([string]$DestDir)
  New-Item -ItemType Directory -Force -Path $DestDir | Out-Null
  Get-ChildItem -Directory (Join-Path $Repo 'skills') | ForEach-Object {
    Link $_.FullName (Join-Path $DestDir $_.Name)
  }
}

Write-Host 'Claude Code (~/.claude):' -ForegroundColor Cyan
Link (Join-Path $Repo 'AGENTS.md') (Join-Path $HOME '.claude\CLAUDE.md')
Link (Join-Path $Repo 'RTK.md')    (Join-Path $HOME '.claude\RTK.md')
Link (Join-Path $Repo 'commands')  (Join-Path $HOME '.claude\commands')
Link (Join-Path $Repo 'rules')     (Join-Path $HOME '.claude\rules')
LinkSkills (Join-Path $HOME '.claude\skills')

if (-not (Get-Command rtk -ErrorAction SilentlyContinue)) {
  Write-Host '  note: rtk is not installed - RTK.md''s guidance will not apply' -ForegroundColor Yellow
}

Write-Host "`nOpenCode (~/.opencode):" -ForegroundColor Cyan
Link (Join-Path $Repo 'AGENTS.md') (Join-Path $HOME '.opencode\AGENTS.md')
Link (Join-Path $Repo 'commands')  (Join-Path $HOME '.opencode\commands')
Link (Join-Path $Repo 'rules')     (Join-Path $HOME '.opencode\rules')
LinkSkills (Join-Path $HOME '.opencode\skills')

Write-Host "`nDone." -ForegroundColor Green
