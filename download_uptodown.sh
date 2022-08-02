#!/usr/bin/env bash

declare -A apks

# this method does not work for twitter. Don't know why.
# apks["com.google.android.youtube.apk"]="https://youtube.en.uptodown.com/android/apps/16906/versions"
# apks["com.google.android.apps.youtube.music.apk"]="https://youtube-music.en.uptodown.com/android/apps/146929/versions"
# apks["com.twitter.android"]="https://twitter.en.uptodown.com/android/apps/16792/versions"
# apks["com.reddit.frontpage"]="https://reddit-official-app.en.uptodown.com/android/apps/179119/versions"

apks["com.google.android.youtube.apk"]="https://youtube.en.uptodown.com/android/download"
apks["com.google.android.apps.youtube.music.apk"]="https://youtube-music.en.uptodown.com/android/download"
apks["com.twitter.android"]="https://twitter.en.uptodown.com/android/download"
apks["com.reddit.frontpage"]="https://reddit-official-app.en.uptodown.com/android/download"

## Functions

get_apk_download_url() {
    # Usage: get_apk_download_url <repo_name> <artifact_name> <file_type>
    version_url=$(curl -s "$1" | jq ".data[] | select(.version | contains(\"$2\")) | .versionURL")
    dl_url=$(curl -s "${version_url:1:-1}" | grep -oE "https:\/\/dw\.uptodown\.com.+\/")
    echo "$dl_url"
}

## Main

for apk in "${!apks[@]}"; do
    if [ ! -f $apk ]; then
        echo "Downloading $apk"
        dl_url=$(curl -s "${apks[$apk]}" | grep -oE "https:\/\/dw\.uptodown\.com.+\/")
        curl -sLo $apk $dl_url
    fi
done
