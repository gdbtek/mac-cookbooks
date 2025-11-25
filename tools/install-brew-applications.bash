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
    echo    "  ./${scriptName} --cask-package-names 'dropbox, transmit' --package-names 'tree, wget'"
    echo    "  ./${scriptName} --cask-package-names 'dropbox, transmit'"
    echo    "  ./${scriptName} --package-names 'tree, wget'"
    echo -e '\033[0m'

    exit "${1}"
}

function installDependencies()
{
    if [[ "$(existCommand 'brew')" = 'false' ]]
    then
        "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/brew/recipes/install.bash" 'true'
    fi
}

function installBrewPackage()
{
    local -r packageType="${1}"
    local -r packageNames="${2}"

    export HOMEBREW_NO_ENV_HINTS='1'
    export HOMEBREW_NO_INSTALL_CLEANUP=''

    # Get App Name List

    local packageNameList=()

    IFS=$',' read -a packageNameList <<< "${packageNames}"

    # Each Package Name

    local i=0

    for ((i = 0; i < ${#packageNameList[@]}; i = i + 1))
    do
        local orderStatus="($((i + 1))/${#packageNameList[@]})"
        local packageName="${packageNameList[${i}]}"

        local packageNameForHeader=''
        packageNameForHeader="$(tr '[:lower:]' '[:upper:]' <<< "${packageName}")"

        # Pre Install

        if [[ -f "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/${packageName}/recipes/pre-install.bash" ]]
        then
            header "PRE-INSTALLING PACKAGE ${packageNameForHeader} ${orderStatus}"
            sudo "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/${packageName}/recipes/pre-install.bash"
        fi

        # Install

        if [[ "$(existCommand 'brew')" = 'false' ]]
        then
            export PATH="/opt/homebrew/bin:${PATH}"
        fi

        local tap="$(dirname "${packageName}")"

        if [[ "${tap}" != '.' ]]
        then
            header "TAPPING $(tr '[:lower:]' '[:upper:]' <<< "${tap}") ${orderStatus}"
            brew tap "${tap}"
        fi

        if [[ "${packageType}" = 'cask' ]]
        then
            header "INSTALLING CASK ${packageNameForHeader} ${orderStatus}"

            brew reinstall --"${packageType}" --force "${packageName}" || brew install --"${packageType}" --force "${packageName}"
            displayVersion "$(brew list --version "${packageName}" --"${packageType}")" "${packageNameForHeader}"
        else
            header "INSTALLING BREW ${packageNameForHeader} ${orderStatus}"

            brew reinstall --force "${packageName}" || brew install --force "${packageName}"
            displayVersion "$(brew list --version "${packageName}")" "${packageNameForHeader}"
        fi

        # Post Install

        if [[ -f "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/${packageName}/recipes/post-install.bash" ]]
        then
            header "POST-INSTALLING PACKAGE ${packageNameForHeader} ${orderStatus}"
            sudo "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/${packageName}/recipes/post-install.bash"
        fi
    done
}

function install()
{
    local -r caskPackageNames="${1}"
    local -r packageNames="${2}"

    # Upgrade Brew

    "$(dirname "${BASH_SOURCE[0]}")/upgrade-brew.bash"

    # Install Packages

    installBrewPackage 'cask' "${caskPackageNames}"
    installBrewPackage '' "${packageNames}"

    # Clean Up

    "$(dirname "${BASH_SOURCE[0]}")/clean-up-brew.bash"
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

            --cask-package-names)
                shift

                if [[ "${#}" -gt '0' ]]
                then
                    local caskPackageNames="${1}"
                fi

                ;;

            --package-names)
                shift

                if [[ "${#}" -gt '0' ]]
                then
                    local packageNames="${1}"
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
    postUpMessage
}

main "${@}"