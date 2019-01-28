#!/bin/bash -e

function clearAppExtendedAttributesOfPath()
{
    local -r appPath="${1}"

    if [[ -d "${appPath}" ]]
    then
        # Get App Path List

        local -r OLD_IFS="${IFS}"
        IFS=$'\n'

        local -r appPathList=($(
            find "${appPath}" \
                -type d \
                -name '*.app' \
                -maxdepth 2 |
            sort -f
        ))

        IFS="${OLD_IFS}"

        # Clear Extended Attributes

        clearAppExtendedAttributes "CLEARING EXTENDED ATTRIBUTES OF ${appPath}" "${appPathList[@]}"
    fi
}

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireRootUser

    # Clear Extended Attributes

    clearAppExtendedAttributesOfPath '/Applications'
    clearAppExtendedAttributesOfPath "$(getCurrentUserHomeFolder)/Applications"
}

main "${@}"