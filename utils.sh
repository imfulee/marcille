steam_compatibility_directory=$HOME/.steam/root/compatibilitytools.d

get_proton_ge() {
  if [ -z "$1" ]; then
    echo "usage: get_proton_ge VERSION"
    return 5
  fi

    local proton_ge_version=$1

  echo "[download proton ge]"
  mkdir -p $steam_compatibility_directory
  wget "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton$proton_ge_version/GE-Proton$proton_ge_version.tar.gz" \
    -P $steam_compatibility_directory \
    --no-verbose --show-progress

  local tar_file=$steam_compatibility_directory/GE-Proton$proton_ge_version.tar.gz

  echo "[extract file]"
  pv $tar_file | tar xzf - -C $steam_compatibility_directory
  rm $tar_file
}

rm_proton_ge() {
  if [ -z "$1" ]; then
    echo "usage: rm_proton_ge VERSION"
    return 5
  fi

    local proton_ge_version=$1
    local to_delete_directory=$steam_compatibility_directory/GE-Proton$proton_ge_version
    [[ -d $to_delete_directory ]] && rm -rf $to_delete_directory
}
