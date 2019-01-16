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
    echo -e '\033[1;35m'
    echo    'DESCRIPTION :'
    echo    '  --help                Help page (optional)'
    echo    '  --application-name    Application name to be installed (require)'
    echo    '  --cask-application    If application is cask application or not (optional)'
    echo    "                        Value could be 'true' or 'false'. Defualt to 'false'"
    echo -e '\033[1;36m'
    echo    'EXAMPLES :'
    echo    "  ./${scriptName} --help"
    echo    "  ./${scriptName} --application-name 'java' --cask-application 'true'"
    echo    "  ./${scriptName} --application-name 'tree'"
    echo -e '\033[0m'

    exit "${1}"
}

function uninstall()
{
    local -r applicationName="${1}"
    local -r caskApplication="${2}"

    checkExistCommand 'brew'

    if [[ "${caskApplication}" = 'true' ]]
    then
        brew cask uninstall "${applicationName}" || true
    else
        brew uninstall "${applicationName}" || true
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

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    checkNonEmptyString "${applicationName}" 'undefined application name'
    checkTrueFalseString "${caskApplication}"

    # Install

    header "UNINSTALLING $(tr '[:lower:]' '[:upper:]' <<< "${applicationName}")"

    installDependencies
    uninstall "${applicationName}" "${caskApplication}"
}

main "${@}"