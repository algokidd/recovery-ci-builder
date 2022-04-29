 
 ​#!​/bin/bash 
  
 ​#​ Source Vars 
 ​source​ ​$CONFIG 
  
 ​#​ Change to the Source Directory 
 ​cd​ ​~​/twrp 
  
 ​#​ Color 
 ​ORANGE=​'​\033[0;33m​' 
  
 ​#​ Display a message 
 ​echo​ ​"​============================​" 
 ​echo​ ​"​Uploading the Build...​" 
 ​echo​ ​"​============================​" 
  
 ​#​ Change to the Output Directory 
 ​cd​ out/target/product/​${DEVICE} 
  
 ​#​ Set FILENAME var 
 ​FILENAME=​$(​echo ​$OUTPUT​) 
  
 ​#​ Upload to oshi.at 
 ​if​ [ ​-z​ ​"​$TIMEOUT​"​ ]​;​then 
 ​    TIMEOUT=20160 
 ​fi 
  
 ​#​ Upload to WeTransfer 
 ​#​ NOTE: the current Docker Image, "registry.gitlab.com/sushrut1101/docker:latest", includes the 'transfer' binary by Default 
 ​transfer wet ​$FILENAME​ ​>​ link.txt ​||​ { ​echo​ ​"​ERROR: Failed to Upload the Build!​"​ ​&&​ ​exit​ 1​;​ } 
  
 ​#​ Mirror to oshi.at 
 ​curl -T ​$FILENAME​ https://oshi.at/​${FILENAME}​/​${OUTPUT}​ ​>​ mirror.txt ​||​ { ​echo​ ​"​WARNING: Failed to Mirror the Build!​"​;​ } 
  
 ​DL_LINK=​$(​cat link.txt ​|​ grep Download ​|​ cut -d​\ ​ -f3​) 
 ​MIRROR_LINK=​$(​cat mirror.txt ​|​ grep Download ​|​ cut -d​\ ​ -f1​) 
  
 ​#​ Show the Download Link 
 ​echo​ ​"​==============================================​" 
 ​echo​ ​"​Download Link: ​${DL_LINK}​"​ ​||​ { ​echo​ ​"​ERROR: Failed to Upload the Build!​"​;​ } 
 ​echo​ ​"​Mirror: ​${MIRROR_LINK}​"​ ​||​ { ​echo​ ​"​WARNING: Failed to Mirror the Build!​"​;​ } 
 ​echo​ ​"​==============================================​" 
  
 ​DATE_L=​$(​date +%d​\ ​%B​\ ​%Y​) 
 ​DATE_S=​$(​date +​"​%T​"​) 
  
 ​#​ Send the Message on Telegram 
 ​echo​ -e \ 
 ​" 
 ​TWRP-CI 
  
 ​✅ Build Completed Successfully! 
  
 ​📱 Device: ​"​${DEVICE}​" 
 ​🖥 Build System: ​"​TWRP BUILDER​" 
 ​⬇️ Download Link: <a href=​\"​${DL_LINK}​\"​>Here</a> 
 ​📅 Date: ​"​$(​date +%d​\ ​%B​\ ​%Y​)​" 
 ​⏱ Time: ​"​$(​date +%T​)​" 
 ​"​ ​>​ tg.html 
  
 ​TG_TEXT=​$(​<​ tg.html​) 
  
 ​telegram_message ​"​$TG_TEXT​" 
  
 ​echo​ ​"​ ​" 
  
 ​#​ Exit 
 ​exit​ 0