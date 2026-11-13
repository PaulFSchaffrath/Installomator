logitechoptionsplusoffline)
    name="Logi Options+"
    appName="logioptionsplus.app"
    archiveName="logioptionsplus_installer_offline.zip"
    installerTool="logioptionsplus_installer_offline.app"
    type="zip"
    downloadURL="https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer_offline.zip"
    # Logi tags its download articles per macOS version (webos=mac-macos-x-NN.0) and adds new
    # macOS versions late. Query the running macOS first, then fall back to older versions.
    # A fixed older value (previously 13.0) returns the last release for that macOS, not the latest.
    osMajorVersion=$(sw_vers -productVersion | awk -F "." '{print $1}')
    appNewVersion=""
    for logiOSVersion in ${osMajorVersion} 26 15 14 13; do
        [[ ${logiOSVersion} -gt ${osMajorVersion} ]] && continue
        appNewVersion="$(curl -fs "https://support.logi.com/api/v2/help_center/en-us/articles.json?label_names=webcontent=productdownload,webos=mac-macos-x-${logiOSVersion}.0" | sed $'s/},{"id"/}\\\n{"id"/g' | awk -F '"body":"' 'index($0, "\"title\":\"Logi Options+\"") {print $2; exit}' | sed 's/\\n/ /g;s/<[^>]*>//g;s/\\"/"/g' | grep -oE 'Software Version: *[0-9]+([.][0-9]+)+' | head -1 | grep -oE '[0-9]+([.][0-9]+)+')"
        [[ -n "${appNewVersion}" ]] && break
    done
    CLIInstaller="logioptionsplus_installer_offline.app/Contents/MacOS/logioptionsplus_installer"
    CLIArguments=(--quiet)
    expectedTeamID="QED4VVPZWA"
    ;;
