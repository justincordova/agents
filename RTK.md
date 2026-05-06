# RTK - Rust Token Killer

**Usage**: Token-optimized CLI proxy (60-90% savings on dev operations)

## Meta Commands (always use rtk directly)

```bash
rtk gain              # Show token savings analytics
rtk gain --history    # Show command usage history with savings
rtk discover          # Analyze Claude Code history for missed opportunities
rtk proxy <cmd>       # Execute raw command without filtering (for debugging)
```

## Installation Verification

```bash
rtk --version         # Should show: rtk X.Y.Z
rtk gain              # Should work (not "command not found")
which rtk             # Verify correct binary
```

⚠️ **Name collision**: If `rtk gain` fails, you may have reachingforthejack/rtk (Rust Type Kit) installed instead.

## Hook-Based Usage

All other commands are automatically rewritten by the Claude Code hook.
Example: `git status` → `rtk git status` (transparent, 0 tokens overhead)

## Output Filtering

RTK filters, compresses, and truncates output to save tokens. This is intentional — but it can drop details you need.

When RTK's output isn't enough:

- **Need more detail**: add `-v` or `-vv` to increase verbosity (e.g. `rtk git log -v`)
- **Need full unfiltered output**: use `rtk proxy <cmd>` (e.g. `rtk proxy git log`)
- **Command failed**: RTK saves the full raw output to a tee log and prints the path — read that file instead of re-running
- **Skip RTK entirely**: run the plain command directly (e.g. `git log` instead of `rtk git log`)
