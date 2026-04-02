#!/usr/bin/env python3
# Original:
#   Claude Codeの使用率がステータスラインに表示できるようになったので表示用のスクリプトを作った話 - 逆瀬川ちゃんのブログ
#   Pattern 3: Ring meter - pie-like circle segments
#   https://nyosegawa.com/posts/claude-code-statusline-rate-limits/
# Modified by taskie

import json
import sys
import time

if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8")

data = json.load(sys.stdin)

R = "\033[0m"
DIM = "\033[2m"
BOLD = "\033[1m"


RINGS = ["○", "◔", "◑", "◕", "●"]


def gradient(pct):
    if pct < 50:
        r = int(pct * 5.1)
        return f"\033[38;2;{r};200;80m"
    else:
        g = int(200 - (pct - 50) * 4)
        return f"\033[38;2;255;{max(g, 0)};60m"


def ring(pct):
    idx = min(int(pct / 25), 4)
    return RINGS[idx]


def remaining(resets_at):
    if resets_at is None:
        return ""
    left = resets_at - time.time()
    if left <= 0:
        return ""
    if left < 3600:
        return f" {DIM}({left / 60:.0f}m){R}"
    if left < 86400:
        return f" {DIM}({left / 3600:.1f}h){R}"
    return f" {DIM}({left / 86400:.1f}d){R}"


def fmt(label, pct, resets_at=None):
    p = round(pct)
    return f"{DIM}{label}{remaining(resets_at)}{R} {gradient(pct)}{ring(pct)} {p}%{R}"


model = data.get("model", {}).get("display_name", "Claude")
parts = [f"{BOLD}{model}{R}"]

cost = data.get("cost", {}).get("total_cost_usd")
if cost is not None:
    parts.append(f"{DIM}cost{R} ${cost:.1f}")

ctx = data.get("context_window", {}).get("used_percentage")
if ctx is not None:
    parts.append(fmt("ctx", ctx))

five_hour = data.get("rate_limits", {}).get("five_hour", {})
five = five_hour.get("used_percentage")
if five is not None:
    parts.append(fmt("5h", five, five_hour.get("resets_at")))

seven_day = data.get("rate_limits", {}).get("seven_day", {})
week = seven_day.get("used_percentage")
if week is not None:
    parts.append(fmt("7d", week, seven_day.get("resets_at")))

print(f"  {DIM}·{R}  ".join(parts), end="")
