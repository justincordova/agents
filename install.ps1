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
  # Drop links to skills that were renamed or removed from this repo.
  $SkillsDir = Join-Path $Repo 'skills'
  Get-ChildItem -Force $DestDir | Where-Object {
    $_.LinkType -eq 'SymbolicLink' -and $_.Target -like "$SkillsDir*" -and -not (Test-Path -LiteralPath $_.Target)
  } | ForEach-Object {
    Remove-Item -LiteralPath $_.FullName -Force
    Write-Host "  removed stale $($_.FullName)" -ForegroundColor DarkGray
  }
}

Write-Host 'Claude Code (~/.claude):' -ForegroundColor Cyan
Link (Join-Path $Repo 'AGENTS.md') (Join-Path $HOME '.claude\CLAUDE.md')
Link (Join-Path $Repo 'RTK.md')    (Join-Path $HOME '.claude\RTK.md')
Link (Join-Path $Repo 'rules')     (Join-Path $HOME '.claude\rules')
LinkSkills (Join-Path $HOME '.claude\skills')

# Claude Code exposes every skill as /<name>, and a same-named skill shadows a
# command, so commands/ is only linked for OpenCode.
$ClaudeCommands = Get-Item -LiteralPath (Join-Path $HOME '.claude\commands') -Force -ErrorAction SilentlyContinue
if ($ClaudeCommands -and $ClaudeCommands.LinkType -eq 'SymbolicLink' -and $ClaudeCommands.Target -like "$Repo*") {
  Remove-Item -LiteralPath $ClaudeCommands.FullName -Force
  Write-Host "  removed $($ClaudeCommands.FullName) (skills already provide these)" -ForegroundColor DarkGray
}

if (-not (Get-Command rtk -ErrorAction SilentlyContinue)) {
  Write-Host '  note: rtk is not installed - RTK.md''s guidance will not apply' -ForegroundColor Yellow
}

$OpenCode = Join-Path $HOME '.config\opencode'
Write-Host "`nOpenCode (~/.config/opencode):" -ForegroundColor Cyan
Link (Join-Path $Repo 'AGENTS.md') (Join-Path $OpenCode 'AGENTS.md')
Link (Join-Path $Repo 'RTK.md')    (Join-Path $OpenCode 'RTK.md')
Link (Join-Path $Repo 'commands')  (Join-Path $OpenCode 'commands')
Link (Join-Path $Repo 'rules')     (Join-Path $OpenCode 'rules')
LinkSkills (Join-Path $OpenCode 'skills')

# OpenCode does not expand AGENTS.md's @-imports; it loads extra files from the
# "instructions" array in opencode.json instead.
$OpenCodeJson = Join-Path $OpenCode 'opencode.json'
if (-not ((Test-Path $OpenCodeJson) -and (Select-String -Quiet -Path $OpenCodeJson -Pattern '"instructions"'))) {
  Write-Host "  note: add to $OpenCodeJson so rules/ and RTK.md load:" -ForegroundColor Yellow
  Write-Host '    "instructions": ["~/.config/opencode/rules/*.md", "~/.config/opencode/RTK.md"]' -ForegroundColor Yellow
}

# Earlier versions linked into ~/.opencode, which OpenCode does not read.
$Stale = @('AGENTS.md', 'commands', 'rules') | ForEach-Object { Join-Path $HOME ".opencode\$_" }
$Stale += Get-ChildItem -Force (Join-Path $HOME '.opencode\skills') -ErrorAction SilentlyContinue | ForEach-Object FullName
foreach ($old in $Stale) {
  $item = Get-Item -LiteralPath $old -Force -ErrorAction SilentlyContinue
  if ($item -and $item.LinkType -eq 'SymbolicLink' -and $item.Target -like "$Repo*") {
    Remove-Item -LiteralPath $old -Force
    Write-Host "  removed stale $old" -ForegroundColor DarkGray
  }
}

Write-Host "`nDone." -ForegroundColor Green
