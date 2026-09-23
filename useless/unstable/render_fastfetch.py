import re, subprocess
from PIL import Image, ImageDraw, ImageFont

# Run fastfetch with standard colors
res = subprocess.run(
    ["fastfetch", "--logo", "/home/yahn/HiganveinOS/airootfs/etc/higan-logo.txt", "--logo-color-1", "red", "--logo-color-2", "white"],
    capture_output=True, text=True
)

raw = res.stdout
img = Image.new("RGB", (960, 420), color="#0f0f13")
draw = ImageDraw.Draw(img)

try:
    font = ImageFont.truetype("/usr/share/fonts/TTF/JetBrainsMonoNerdFont-Regular.ttf", 15)
except Exception:
    font = ImageFont.load_default()

# ANSI Color parser for terminal fidelity
ANSI_COLORS = {
    "30": "#27272a", "31": "#ef4444", "32": "#22c55e", "33": "#eab308",
    "34": "#3b82f6", "35": "#a855f7", "36": "#06b6d4", "37": "#f4f4f5",
    "90": "#71717a", "91": "#f87171", "92": "#4ade80", "93": "#fde047",
    "94": "#60a5fa", "95": "#c084fc", "96": "#22d3ee", "97": "#ffffff"
}

y = 25
ansi_regex = re.compile(r'(\x1b\[[0-9;]*m)')

for line in raw.splitlines():
    x = 30
    current_color = "#e4e4e7"
    tokens = ansi_regex.split(line)
    for token in tokens:
        if not token:
            continue
        if token.startswith("\x1b["):
            codes = token[2:-1].split(";")
            for c in codes:
                if c in ANSI_COLORS:
                    current_color = ANSI_COLORS[c]
                elif c == "0":
                    current_color = "#e4e4e7"
        else:
            draw.text((x, y), token, fill=current_color, font=font)
            # calculate text width
            bbox = font.getbbox(token)
            x += (bbox[2] - bbox[0])
    y += 22

img.save("/home/yahn/HiganveinOS/fastfetch_higanbana.png")
print("DONE")
