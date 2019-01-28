#!/bin/bash -e

function resetApplicationPermissionOfPath()
{
    local -r folderPath="${1}"

    if [[ -d "${folderPath}" ]]
    then
        # Get App Path List

        local -r OLD_IFS="${IFS}"
        IFS=$'\n'

        local -r appPathList=($(
            find "${folderPath}" \
                -type d \
                -name '*.app' \
                -maxdepth 2 |
            sort -f
        ))

        IFS="${OLD_IFS}"

        # Reset App Permissions

        if [[ "${#appPathList[@]}" -gt '0' ]]
        then
            header "RESETTING APPLICATION PERMISSIONS OF ${folderPath}"
        fi

        local appPath=''

        for appPath in "${appPathList[@]}"
        do
            echo ">>>${appPath}"
        done
    fi
}

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Reset Application Permission

    resetApplicationPermissionOfPath '/Applications'
    resetApplicationPermissionOfPath "$(getCurrentUserHomeFolder)/Applications"
}

main "${@}"