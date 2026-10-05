# CLAUDE.md

Private inner-joke game for the owner and their wife. The wife plays on a phone in portrait, so mobile portrait is the primary target; always check a 375px-wide viewport.

## Layout of the code

All code lives in `index.html` (vanilla HTML/CSS/JS, no build, no framework); pixel art lives in `sprites/`.

- `DATA` section at the top of the script: heroes, cards, enemies, AI. Balance changes go here.
- Game state `S` is plain JSON (cards are `{uid, id}`), so the artifact's hot-reload snapshot can hand it back. Keep it serializable.
- Two heroes with separate HP/block; each card has an `actor` (`girl` / `alpaca` / `both`).
- Unit art is `SPRITES` in `DATA`: one 64px-cell sheet per unit in `sprites/` (rows idle / attack / hit, unique frames only; the arrays are play order by column). One rAF loop (`tickSprites`) steps every `.sprite.px`; a unit without a `SPRITES` entry falls back to its emoji. `anim(f, name)` plays the matching sheet row and still adds `.sprite-wrap.a-{attack,skill,buff,hit}` for the CSS lunge/shake/flash; skill/buff have no sheet row. Heroes face right, bugs face left in the art itself (no flipping).
- Sheets share a baseline (lowest pixel at y=61) so feet line up on the shadow; `k` scales a unit relative to the girl; `face` is the head crop (sheet pixels) that enemy intents show as the target. Every sheet column must be used by some play-order array, because the sheet width is derived from the highest index. Cards with `spray: true` send `sprites/mist.png` from caster to target.
- Card art: `makeCard` lays `sprites/cards/<card id>.png` over the card's `art` emoji; if the file is missing the `<img>` removes itself and the emoji shows. A new card needs a new 64x48 picture (see `sprites/README.md`).
- Portrait vs landscape battlefield is a container query on `.field` (`max-aspect-ratio:5/6`); `paintBackground()` uses the same threshold (`H / W >= 1.2`). Change both together.

## Publishing

- The standalone page is `index.html` (works from file:// and GitHub Pages).
- The Claude artifact needs the page without the `<html>/<head>/<body>` wrapper: run `scripts/build-artifact.sh`, then publish `dist/artifact.html` with `url: https://claude.ai/artifact/BdnYHQ1pJZoqakaL7ukgc2` to keep the same link. Pass every PNG under `sprites/` (including `sprites/cards/`) in `files` (published path = repo path) or the units and card art render blank.
- Local preview: `.claude/launch.json` serves the folder on :8123. The browser pane opens file:// pages as a `data:` snapshot, where relative `sprites/` URLs don't resolve.
- Keep `<!-- artifact:start -->` / `<!-- artifact:end -->` markers and the `</head>` / `<body>` lines on their own lines; the build script depends on them.

## Roadmap

Stage 2 (v0.2) is done: PixelLab side-view 64px sprites + idle/attack/hit for 선크림 소녀, 알파카, 지네, 바퀴벌레, plus pixel card art for all 11 cards. Prompts, seeds and regeneration notes are in `sprites/README.md`.

- The mockups are in `reference/` (gitignored on purpose; the repo will be public, the mockups stay local). Stage 2 used them only as a text description of the style; no mockup was uploaded to PixelLab.
- PixelLab MCP is configured at local scope (`claude mcp add`, not `.mcp.json`) so the API token never lands in the repo. Never add a `.mcp.json` with the token.
- The owner's PixelLab account is a free trial: 40 generations, then 5 per day (stored up to 20), one job at a time. Check `get_balance` and say what a regeneration costs before spending.
