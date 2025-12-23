#!/bin/bash
# shellcheck source=config.sh
steam_compatibility_directory=$HOME/.steam/root/compatibilitytools.d

get_proton_ge() {
  if [ -z "$1" ]; then
    echo "usage: get_proton_ge VERSION"
    return 5
  fi

  local proton_ge_version=$1
  local url
  local tarball_name
  if [[ "$proton_ge_version" == "latest" ]]; then
    url=$(
      curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest |
        grep browser_download_url | cut -d\" -f4 |
        grep .tar.gz
    )
  else
    url="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/"
    url+="GE-Proton$proton_ge_version/GE-Proton$proton_ge_version.tar.gz"
  fi
  tarball_name=$(basename "$url")

  echo "[download proton ge $tarball_name]"
  mkdir -p "$steam_compatibility_directory"
  wget "$url" \
    -P "$steam_compatibility_directory" \
    --no-verbose --show-progress

  local tar_file="$steam_compatibility_directory/$tarball_name"

  echo "[extract file]"
  pv "$tar_file" | tar xzf - -C "$steam_compatibility_directory"
  rm "$tar_file"
}

rm_proton_ge() {
  if [ -z "$1" ]; then
    echo "usage: rm_proton_ge VERSION"
    return 5
  fi

  local proton_ge_version=$1
  local to_delete_directory=$steam_compatibility_directory/GE-Proton$proton_ge_version
  [[ -d $to_delete_directory ]] && rm -rf "$to_delete_directory"
}

get_proton_ge latest
