#!/bin/bash

OUTPUT="sounds_tv.txt"

# Empty the output file if it already exists
> "$OUTPUT"

for file in *.ogg; do
    # Skip if no .ogg files match
    [[ ! -f "$file" ]] && continue

    # Filename without extension
    base="${file%.*}"

    cat >> "$OUTPUT" <<EOF
sound ${base} {
    category = Object,
    loop = false,
    is3D = true,
    clip {
        file = media/sound/tv/${file},
        distanceMin = 3,
        distanceMax = 10,
        reverbFactor = 0.2,
    }
}

EOF

done