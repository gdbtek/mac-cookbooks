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
    echo    '    --cask-application    <CASK_APPLICATION>'
    echo    '    --command             <COMMAND>'
    echo -e '\033[1;35m'
    echo    'DESCRIPTION :'
    echo    '  --help                Help page (optional)'
    echo    '  --application-name    Application name to be installed (require)'
    echo    '  --cask-application    If application is cask application or not (optional)'
    echo    "                        Value could be 'true' or 'false'. Defualt to 'false'"
    echo    '  --command             Command of the application (optional)'
    echo    '                        Default to application name'
    echo -e '\033[1;36m'
    echo    'EXAMPLES :'
    echo    "  ./${scriptName} --help"
    echo    "  ./${scriptName} --application-name 'geoip' --command 'geoiplookup'"
    echo    "  ./${scriptName} --application-name 'java' --cask-application 'true'"
    echo    "  ./${scriptName} --application-name 'tree'"
    echo -e '\033[0m'

    exit "${1}"
}

function installDependencies()
{
    if [[ "$(existCommand 'brew')" = 'false' ]]
    then
        "${APP_FOLDER_PATH}/../cookbooks/brew/recipes/install.bash" 'true'
    fi
}

function install()
{
    local -r applicationName="${1}"
    local -r caskApplication="${2}"
    local -r command="${3}"

    initializeFolder "$(getCurrentUserHomeFolder)/Library/Caches/Homebrew"

    if [[ "${caskApplication}" = 'true' ]]
    then
        if [[ -d "/usr/local/Caskroom/${applicationName}" ]]
        then
            brew cask reinstall "${applicationName}"
        else
            brew cask install "${applicationName}"
        fi

        displayVersion "$(brew cask list --versions "${applicationName}")"
    else
        if [[ "$(existCommand "${command}")" = 'true' || -d "/usr/local/opt/${applicationName}" ]]
        then
            brew reinstall "${applicationName}"
        else
            brew install "${applicationName}"
        fi

        displayVersion "$(brew list --versions "${applicationName}")"
    fi
}

########
# MAIN #
########

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../libraries/util.bash"

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

            --cask-application)
                shift

                if [[ "${#}" -gt '0' ]]
                then
                    local caskApplication=''
                    caskApplication="$(trimString "${1}")"
                fi

                ;;

            --command)
                shift

                if [[ "${#}" -gt '0' ]]
                then
                    local command=''
                    command="$(trimString "${1}")"
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

    # Default Values

    if [[ "$(isEmptyString "${caskApplication}")" = 'true' ]]
    then
        caskApplication='false'
    fi

    if [[ "$(isEmptyString "${command}")" = 'true' ]]
    then
        command="${applicationName}"
    fi

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    checkNonEmptyString "${applicationName}" 'undefined application name'
    checkTrueFalseString "${caskApplication}"

    # Install

    header "INSTALLING $(tr '[:lower:]' '[:upper:]' <<< "${applicationName}")"

    installDependencies
    install "${applicationName}" "${caskApplication}" "${command}"
}

main "${@}"