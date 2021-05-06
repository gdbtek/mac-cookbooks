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
    echo    '    --app-names    <APP_NAMES>'
    echo -e '\033[1;35m'
    echo    'DESCRIPTION :'
    echo    '  --help         Help page (optional)'
    echo    '  --app-names    List of application names in App Store seperated by spaces or commas (require)'
    echo -e '\033[1;36m'
    echo    'EXAMPLES :'
    echo    "  ./${scriptName} --help"
    echo    "  ./${scriptName} --app-names 'Slack, SnippetsLab'"
    echo -e '\033[0m'

    exit "${1}"
}

function installDependencies()
{
    if [[ "$(existCommand 'mas')" = 'false' ]]
    then
        "$(dirname "${BASH_SOURCE[0]}")/install-brew-applications.bash" \
            --package-names 'mas'
    fi
}

function install()
{
    local -r appNames="${1}"

    # Get App Name List

    local appNameList=()

    IFS=$',' read -a appNameList <<< "${appNames}"

    # Each App Name

    local appName=''

    for appName in "${appNameList[@]}"
    do
        header "INSTALLING STORE APP $(tr '[:lower:]' '[:upper:]' <<< "${appName}")"
        mas lucky "${appName}"
    done

    if [[ "${#appNameList[@]}" -gt '0' ]]
    then
        header 'UPGRADING STORE APPLICATIONS'
        mas upgrade
    fi
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

            --app-names)
                shift

                if [[ "${#}" -gt '0' ]]
                then
                    local appNames="${1}"
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

    if [[ "$(isEmptyString "${appNames}")" = 'true' ]]
    then
        fatal '\nFATAL : undefined app names'
    fi

    # Install

    installDependencies
    install "${appNames}"
    postUpMessage
}

main "${@}"