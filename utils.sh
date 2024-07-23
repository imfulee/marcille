steam_compatibility_directory=$HOME/.steam/root/compatibilitytools.d

get_proton_ge() {
  if [ -z "$1" ]; then
    echo "usage: get_proton_ge VERSION"
    return 5
  fi

    local proton_ge_version=$1

    steam_compatibility_directory=$HOME/.steam/root/compatibilitytools.d
    mkdir -p $steam_compatibility_directory && cd $steam_compatibility_directory
    # Football Manager seems to work well with this version
    wget https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton$proton_ge_version/GE-Proton$proton_ge_version.tar.gz
    tar zxvf GE-Proton$proton_ge_version.tar.gz && rm GE-Proton$proton_ge_version.tar.gz
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
