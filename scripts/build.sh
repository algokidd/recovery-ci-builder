#!/bin/bash

source $CONFIG

# Change to the Source Directry
cd ~/twrp

# Send the Telegram Message

echo -e \
"
✨ PBRP Recovery CI

✔️ The Build has been Triggered!

📱 Device: "${DEVICE}

TG_TEXT=$(< tg.html)

telegram_message "${TG_TEXT}"
echo " "

# Prepare the Build Environment
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh

# export some Basic Vars
#export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
#export LC_ALL="C"

# lunch the target
lunch twrp_${DEVICE}-eng|| { echo "ERROR: Failed to lunch the target!" && exit 1; }
mka -j$(nproc --all) recoveryimage
# Exit
exit 0
