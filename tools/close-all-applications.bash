#!/bin/bash -e

function closeApplicationsOfPath()
{
    local -r folderPath="${1}"

    if [[ -d "${folderPath}" ]]
    then
        # Get App Name List

        local -r OLD_IFS="${IFS}"
        IFS=$'\n'

        local -r appNameList=($(
            find "${folderPath}" \
                -type d \
                -name '*.app' \
                -maxdepth 2 |
            rev |
            cut -d '/' -f 1 |
            rev |
            sort -f
        ))

        IFS="${OLD_IFS}"

        # Close Applications

        closeMacApplications "CLOSING APPLICATIONS OF ${folderPath}" "${appNameList[@]}"
    fi
}

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Close Applications

    closeApplicationsOfPath '/Applications'
    closeApplicationsOfPath '/System/Applications'
    closeApplicationsOfPath "$(getCurrentUserHomeFolder)/Applications"
}

main "${@}"