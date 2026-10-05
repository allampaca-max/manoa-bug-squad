# Sprites

PixelLab output, assembled into one sheet per unit: 64px cells, rows idle / attack / hit, unique frames only. Play order and scale are in `SPRITES` in `index.html`.

| Sheet | Rows (frames) | Notes |
|---|---|---|
| `girl.png` | 4 / 6 / 5 | idle plays 0-3 forward and back; hit is the second try, pinned to the base frame (the first try turned into a run) |
| `alpaca.png` | 5 / 5 / 5 | idle closes its eyes (dozing), held on the open and closed frames; attack is the second try (seed 11, unpinned) keeping frames 0, 2, 4, 5, 6, played out and back so the spray frame lands with the damage |
| `centipede.png` | 5 / 7 / 5 | attack bites on column 4 |
| `roach.png` | 5 / 7 / 5 | attack ends half-lidded, so the play order closes on column 1 |
| `mist.png` | single 64x32 | spray can cut off the generated image, then mirrored so the cloud billows right |

## How they were made

All with seed 7, 64x64, transparent background.

Base frame: `create_image_pixen`, `view: side`, `outline: single color black outline`, `detail: medium detail`, `direction: east` for the heroes and `west` for the bugs. Prompts:

- girl: cute chibi pixel art young woman, long wavy black hair, white sunscreen cream smeared on her cheeks, gray t-shirt, blue denim shorts, white sneakers, holding a red bug spray can, full body standing, side view facing right, 16-bit retro game sprite
- alpaca: cute chibi pixel art alpaca, round fluffy cream white wool, standing upright on its hind legs like a plush mascot, big round eyes, holding a red bug spray can in its front hooves, full body, side view facing right, 16-bit retro game sprite
- centipede: cute chibi pixel art centipede monster, orange and dark red segmented body, many small yellow legs, big round cartoon eyes, two antennae, crawling, full body, side view facing left, 16-bit retro game enemy sprite
- roach: cute chibi pixel art cockroach monster, glossy reddish brown shell, big round cartoon eyes, long antennae, six legs, standing, full body, side view facing left, 16-bit retro game enemy sprite
- mist (64x32, lineless, low detail): puff of white bug spray mist cloud, soft wispy billowing vapor with light blue shading, drifting to the right, pixel art effect sprite

Animations: `animate_image` from the base frame, 4 frames (idle, hit) or 6 (attack), 1 generation each. Frame 0 of the result is the input.

- Passing the base frame again as `last_frame_url` makes the motion come back to the base pose. Use it for idle and hit. It also damps the motion, so leave attacks unpinned and play the frames back toward column 0 instead (the first, pinned alpaca attack barely moved).
- The model barely draws the spray cloud (only the redone alpaca attack shows a little), which is why `mist.png` is a separate effect.

## Card art

`cards/<card id>.png`, one per card in `CARDS`, shown full-bleed in the card's art box (4:3, 78x58 on a phone). `create_image_pixen`, 64x48, background on, `detail: medium detail`, seed 7. Attack cards ask for a warm orange background, skills for blue sky, team cards for gold, so the old type colours survive.

Start every prompt with "full frame pixel art scene:". "card illustration" made the model draw a card with a frame inside the picture (the first sunscreen try; `spray.png` also came with a frame and is cropped 4px on each side to 56x40).

- spray: a red bug spray can spraying a big puffy white mist cloud to the right, a tiny brown cockroach fleeing from the mist, warm orange background
- parasol: an open pink frilly parasol umbrella shielding from bright sunshine rays, soft blue sky background
- sunscreen: a white sunscreen lotion tube squeezing out a big swirl of white cream on a sunny tropical beach, cute smiling sun in the blue sky, palm trees
- raid: a big red insecticide spray can blasting a huge fiery spray burst to the right, explosion of orange and yellow sparks, warm orange background
- slipper: a blue rubber flip-flop slipper flying fast with motion lines about to smack a startled brown cockroach, warm orange background
- spit: cute fluffy cream white alpaca with big round eyes spitting a big glob of saliva to the right, splash droplets flying, warm orange background
- fluff: cute fluffy cream white alpaca with big round eyes puffed up into a huge round ball of soft wool like a cloud, sparkles, soft blue sky background
- alpacaAttack: cute fluffy cream white alpaca with big round eyes and a determined face charging forward to the right, speed lines and dust clouds behind it, warm orange background
- hug: cute fluffy cream white alpaca hugging a girl with long wavy black hair and a gray t-shirt, wrapping her in its soft wool, pink hearts floating, soft blue background
- tea: a steaming cup of Hawaiian herbal tea on a wooden saucer with a red hibiscus flower and green leaves beside it, cozy warm golden background
- rainbow: a bright rainbow arching over lush green Hawaiian mountains and a turquoise ocean, Manoa valley, fluffy clouds, golden sunny sky

Total: 31 generations of the trial's 40 (17 for the first pass, 2 to redo girl hit and alpaca attack, 12 for card art including one redo).
