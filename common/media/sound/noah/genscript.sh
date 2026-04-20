#!/bin/bash

OUTPUT="sounds.txt"

# Empty the output file if it already exists
> "$OUTPUT"

for file in *.ogg; do
    # Skip if no .ogg files match
    [[ ! -f "$file" ]] && continue

    # Filename without extension
    base="${file%.*}"

    cat >> "$OUTPUT" <<EOF
sound Dial_${base} {
    category = Object,
    loop = false,
    is3D = true,
    clip {
        file = media/sound/emma/${file},
        distanceMin = 1,
        distanceMax = 7,
        reverbFactor = 0.6,
    }
}

EOF

done