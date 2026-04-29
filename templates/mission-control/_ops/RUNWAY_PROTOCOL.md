# Runway Protocol

Updated: {{UPDATED_AT}}

This protocol prevents multiple Codex chats from colliding on the same browser, inbox, repo, desktop, social account, or payment surface.

## Rule

Work can happen in many projects at once. Shared surfaces are serialized by lane.

Before using a shared surface:

1. Check `SURFACE_LANES.md` and `cmc lanes`.
2. Claim the lane with `cmc claim <lane> <owner> <reason>`.
3. Do the smallest approved action.
4. Release the lane with `cmc release <lane> <owner>`.
5. Write proof or blockers to the mission outbox.

If a lane is held, switch to safe local prep. Do not wait on the lane.

## Write Ownership

| Area | Writer |
| --- | --- |
| Mission project folder | Owning mission |
| Shared dashboard and state | `FLIGHT` |
| Mission outbox | Owning mission |
| External surface | One approved lane owner |
| Mechanical lane locks | First claimant |

## Stop Conditions

- If approval is missing, write a packet and stop.
- If a lane is held, write local prep or a blocker and stop.
- If verification fails, fix once within scope, then report the exact failing command.
