from PIL import Image, ImageDraw
import numpy as np
import os

# ---------------------
# Settings
# ---------------------
width, height = 1600, 1600
scale = 70  # pixels per meter
SCALE_FACTOR = 2
hi_w, hi_h = width * SCALE_FACTOR, height * SCALE_FACTOR
center_px_hi = hi_w // 2
center_py_hi = hi_h // 2

dt = 0.1
gravity = -9.81
frames = 480  # number of frames (loopable)
particles_per_frame = 120
base_speed = 12
fade_duration = 40
particle_color = (220, 240, 255)
tilt_deg = -45  # shower spray angle downward
tilt_rad = np.radians(tilt_deg)

output_dir = "frames_shower"
os.makedirs(output_dir, exist_ok=True)

# ---------------------
# Utility Functions
# ---------------------
center_px = width // 2
center_py = height // 2

tile_w = 64
tile_h = 32
elevation_scale = 64  # project zomboid style projection

def to_screen_coords(x, y, z):
    px = (x - z) * (tile_w / 2)
    py = (x + z) * (tile_h / 2) - y * elevation_scale
    return int(center_px_hi + px), int(center_py_hi + py)

# ---------------------
# Simulation
# ---------------------
particles = []

# showerhead world position
origin = [0.0, 2.2, -2.0]  # slightly above and in front of the center (mounted on a "wall")

for frame in range(frames):

    # Fixed direction — 45 degrees downward and outward
    # The user can change 'tilt_deg' to adjust steepness
    for _ in range(particles_per_frame):
        # Random horizontal spread
        spread_angle = np.radians(np.random.uniform(-10, 10))
        speed = np.random.uniform(0.6 * base_speed, base_speed)

        vx = speed * np.cos(tilt_rad) * np.cos(spread_angle)
        vy = -speed * np.sin(tilt_rad) + np.random.normal(0, 0.3)
        vz = speed * np.cos(tilt_rad) * np.sin(spread_angle)

        particles.append({
            "pos": list(origin),
            "vel": [vx, vy, vz],
            "age": 0
        })

    img_hi = Image.new("RGBA", (hi_w, hi_h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img_hi)
    new_particles = []

    for p in particles:
        for i in range(3):
            p["pos"][i] += p["vel"][i] * dt
        p["vel"][1] += gravity * dt
        p["age"] += 1

        x, y, z = p["pos"]
        if y < 0:
            continue  # ground collision

        start_px, start_py = to_screen_coords(x, y, z)

        streak_len = 0.03
        vx, vy, vz = p["vel"]
        x_end = x + vx * streak_len
        y_end = y + vy * streak_len
        z_end = z + vz * streak_len
        end_px, end_py = to_screen_coords(x_end, y_end, z_end)

        alpha = int(180 * max(0, 1 - p["age"] / fade_duration))
        if alpha <= 0:
            continue

        draw.line(
            (start_px, start_py, end_px, end_py),
            fill=(*particle_color, alpha),
            width=3
        )

        new_particles.append(p)

    particles = new_particles

    img_final = img_hi.resize((width, height), resample=Image.LANCZOS)
    img_final.save(f"{output_dir}/{frame+1:03d}.png", "PNG")

print("✅ Saved shower water frames to:", os.path.abspath(output_dir))
