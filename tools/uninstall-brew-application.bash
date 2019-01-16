#!/bin/bash -e

##################
# IMPLEMENTATION #
##################

function displayUsage()
{
    local -r scriptName="$(basename "${BASH_SOURCE[0]}")"

    echo -e '\033[1;33m'
    echo    'SYNOPSIS :'
    echo    "  ${scriptName}"
    echo    '    --help'
    echo    '    --application-name    <APPLICATION_NAME>'
    echo -e '\033[1;35m'
    echo    'DESCRIPTION :'
    echo    '  --help                Help page (optional)'
    echo    '  --application-name    Application name to be installed (require)'
    echo -e '\033[1;36m'
    echo    'EXAMPLES :'
    echo    "  ./${scriptName} --help"
    echo    "  ./${scriptName} --application-name 'tree'"
    echo -e '\033[0m'

    exit "${1}"
}

function uninstall()
{
    local -r applicationName="${1}"

    checkExistCommand 'brew'

    brew uninstall "${applicationName}" || true
}

########
# MAIN #
########

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Parsing Command Arguments

    local -r optCount="${#}"

    while [[ "${#}" -gt '0' ]]
    do
        case "${1}" in
            --help)
                displayUsage 0
                ;;

            --application-name)
                shift

                if [[ "${#}" -gt '0' ]]
                then
                    local applicationName=''
                    applicationName="$(trimString "${1}")"
                fi

                ;;

            *)
                shift
                ;;
        esac
    done

    # Validate Opt

    if [[ "${optCount}" -lt '1' ]]
    then
        displayUsage 0
    fi

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser
    checkNonEmptyString "${applicationName}" 'undefined application name'

    # Install

    header "UNINSTALLING $(tr '[:lower:]' '[:upper:]' <<< "${applicationName}")"

    uninstall "${applicationName}"
}

main "${@}"