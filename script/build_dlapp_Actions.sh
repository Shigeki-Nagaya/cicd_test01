#!/bin/bash

DLAPP_ROOT=/mnt/dlapp/recorder/aiads_recorder
TARGET_ROOT=./drt/aiads_recorder

echo "dlapp-airecを作成します\n"
cd /mnt/dlapp/Workplace/_deploy_airec/IMPACTTV

echo "カレントディレクトリ: -- $(pwd) --\n"

read -p "バージョンを入力してください（1.x.x）:  " VAR_VERSION
# Version File
# VAR_STB_VERSION='STB-2.0.9_BUILD2021-01-25-12:00:00'
VAR_AIREC_VERSION="AIREC-${VAR_VERSION}_BUILD$(date "+%Y-%m-%d-%H:%M:%S")"
echo "---> バージョン: $VAR_AIREC_VERSION"

echo ""
echo "Dlapp-AIRECを作成します..."
echo "==========================================================="
sleep 3

mkdir -p ./drt/aiads_recorder
touch ./drt/aiads_recorder/env_AIREC_APP_VERSION
echo $VAR_AIREC_VERSION >./drt/aiads_recorder/env_AIREC_APP_VERSION


### Phase(A) ##########################################################################
### Phase(0)
# Keep-up Access right and Owner
# Owener and Grp
echo ubuntu | sudo -S chown -R ubuntu:fuse /mnt/dlapp
# Access right
echo ubuntu | sudo -S chmod -R 775 /mnt/dlapp

### Phase(1) Rsync #######################################
echo "==========================================================="
# conf
rsync -av --delete /mnt/dlapp/conf .
# usrscript
rsync -av --delete /mnt/dlapp/usrscript .

# drt/(src,script,tests,bin,tools,doc,etc...)
# 上の3つの設定ファイル env_* はrsyncの対象外となる
rsync -av --delete \
  --exclude '__pycache__' --exclude '.vscode' --exclude '.git' --exclude '.github' --exclude '.gitignore' \
  --exclude '*.log' --exclude '*.mp4' --exclude '*.swp' --exclude '*.pyc' --exclude '*.png' --exclude 'nohup.out' \
  $DLAPP_ROOT/src \
  $DLAPP_ROOT/snippets \
  $DLAPP_ROOT/tools \
  $DLAPP_ROOT/script \
  $DLAPP_ROOT/README.md \
  $DLAPP_ROOT/pyproject.toml \
  $TARGET_ROOT

### Phase(2) Delete files ###################################
# mp4
fd --fixed-strings .mp4 | xargs rm 2> /dev/null
# swp
fd --fixed-strings .swp | xargs rm 2> /dev/null
# log
fd --fixed-strings .log | xargs rm 2> /dev/null
# # .gitignore
# fd --fixed-strings .gitignore | xargs rm
# .pyc
fd --fixed-strings .pyc | xargs rm 2> /dev/null
# .png
fd --fixed-strings .png | xargs rm 2> /dev/null

# ### Phase(3) Trimings #######################################
# # Set Splash Screens using ENV_DISPLAY
# if [ $VAR_DISPLAY == 'IMPACTTV' ]; then
#   cp conf/images/init1-UpsideDown.jpg conf/images/init1.jpg
#   cp conf/images/init2-UpsideDown.jpg conf/images/init2.jpg
#   cp conf/images/init3-UpsideDown.jpg conf/images/init3.jpg
# else
#   cp conf/images/init1-Normal.jpg conf/images/init1.jpg
#   cp conf/images/init2-Normal.jpg conf/images/init2.jpg
#   cp conf/images/init3-Normal.jpg conf/images/init3.jpg
# fi

# Change startup.usr.sh
echo "==========================================================="
cp $DLAPP_ROOT/src/assets/startup.usr.sh ./conf

###################################################################################
# Phase (B)
# libs
# rsync -av --exclude '__pycache__' --exclude '*.pyc' /mnt/dlapp/drt/lib ./drt
# rsync -av --exclude '__pycache__' --exclude '*.pyc' /mnt/dlapp/drt/homeLocalLib ./drt
# rsync -av --exclude '__pycache__' --exclude '*.pyc' /mnt/dlapp/drt/usrLib ./drt

###################################################################################
### Phase(C)
# Keep-up Access right and Owner
# Owener and Grp
echo ubuntu | sudo -S chown -R ubuntu:fuse .
# Access right
echo ubuntu | sudo -S chmod -R 775 .

###################################################################################

# Archive
echo "==========================================================="
echo "ZIPアーカイブを作成します: ~/aaaApp.zip"
if [ -e ~/aaaApp.zip ]; then
  rm ~/aaaApp.zip
fi
zip -8 -r -y ~/aaaApp.zip .
