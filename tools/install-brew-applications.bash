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
    echo    '    --cask-package-names    <CASK_PACKAGE_NAMES>'
    echo    '    --package-names         <PACKAGE_NAMES>'
    echo -e '\033[1;35m'
    echo    'DESCRIPTION :'
    echo    '  --help                  Help page (optional)'
    echo    '  --cask-package-names    List of cask package names seperated by spaces or commas (require)'
    echo    '  --package-names         List of package names seperated by spaces or commas (require)'
    echo -e '\033[1;36m'
    echo    'EXAMPLES :'
    echo    "  ./${scriptName} --help"
    echo    "  ./${scriptName} --cask-package-names 'chefdk, java' --package-names 'tree, wget'"
    echo    "  ./${scriptName} --cask-package-names 'chefdk, java'"
    echo    "  ./${scriptName} --package-names 'tree, wget'"
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
    local -r caskPackageNames=($(sortUniqArray "${1}"))
    local -r packageNames=($(sortUniqArray "${2}"))

    initializeFolder "$(getCurrentUserHomeFolder)/Library/Caches/Homebrew"

    # Cask Packages

    local caskPackageName=''

    for caskPackageName in "${caskPackageNames[@]}"
    do
        header "INSTALLING CASK PACKAGE $(tr '[:lower:]' '[:upper:]' <<< "${caskPackageName}")"

        brew cask reinstall "${caskPackageName}"
        displayVersion "$(brew list --versions "${caskPackageName}")"
    done

    # Packages

    local packageName=''

    for packageName in "${packageNames[@]}"
    do
        header "INSTALLING PACKAGE $(tr '[:lower:]' '[:upper:]' <<< "${packageName}")"

        brew reinstall "${packageName}"
        displayVersion "$(brew list --versions "${packageName}")"
    done
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

            --cask-package-names)
                shift

                if [[ "${#}" -gt '0' ]]
                then
                    local caskPackageNames=''
                    caskPackageNames="$(replaceString "${1}" ',' ' ')"
                fi

                ;;

            --package-names)
                shift

                if [[ "${#}" -gt '0' ]]
                then
                    local packageNames=''
                    packageNames="$(replaceString "${1}" ',' ' ')"
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

    if [[ "$(isEmptyString "${caskPackageNames}")" = 'true' && "$(isEmptyString "${packageNames}")" = 'true' ]]
    then
        fatal '\nFATAL : undefined cask package names and package names'
    fi

    # Install

    installDependencies
    install "${caskPackageNames}" "${packageNames}"
}

main "${@}"