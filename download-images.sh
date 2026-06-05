#!/usr/bin/env bash
# Run this once from the project root to download all WordPress images locally.
# Usage: bash download-images.sh

set -e
DEST="public/images"
mkdir -p "$DEST"

IMAGES=(
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2016/01/brewing_rig.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2016/01/dallas_skyline.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2016/02/hissy_fitting.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2016/02/uss_springfield_ssn-761.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2016/04/not_fire_proof-e1459801316662.jpeg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2016/06/screen-shot-2016-06-19-at-11-45-18-am.png"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2017/03/bluebonnet_2017_stein_scottish_export-e1490906948393.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2018/12/Bluebonnet-2018-2.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2018/12/Screen-Shot-2018-12-28-at-9.19.46-PM.png"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2019/01/Screen-Shot-2019-01-01-at-7.30.36-PM.png"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2019/01/campfiredonatenow-03.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2019/01/image_snbc_resilience_ipa-800x483.png"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2020/11/eod-iron-mash.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2020/11/ironmash-2020.png"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2020/11/special-ingredient.jpg"
  "https://agalewerksblog.wordpress.com/wp-content/uploads/2020/11/wort-ironmash.jpg"
)

for url in "${IMAGES[@]}"; do
  filename=$(basename "$url")
  dest="$DEST/$filename"
  if [ -f "$dest" ]; then
    echo "  already exists: $filename"
  else
    echo -n "  downloading $filename ... "
    curl -sL --max-time 30 -o "$dest" "$url" && echo "done" || echo "FAILED"
  fi
done

echo ""
echo "All done. Images saved to $DEST/"
