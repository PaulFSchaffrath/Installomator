ardia)
    name="Ardia"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="$(downloadURLFromGit ardia-browser ardia)"
        appNewVersion="$(versionFromGit ardia-browser ardia)"
    else
        cleanupAndExit 95 "Ardia requires Apple Silicon" ERROR
    fi
    expectedTeamID="U5L5T3NGVV"
    ;;
