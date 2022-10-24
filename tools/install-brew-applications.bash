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
    echo    '    --package-names         <PACKAGE_NAMES>'
    echo -e '\033[1;35m'
    echo    'DESCRIPTION :'
    echo    '  --help                  Help page (optional)'
    echo    '  --package-names         List of package names seperated by spaces or commas (require)'
    echo -e '\033[1;36m'
    echo    'EXAMPLES :'
    echo    "  ./${scriptName} --help"
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
    local -r packageNames="${1}"

    # Get App Name List

    local packageNameList=()

    IFS=$',' read -a packageNameList <<< "${packageNames}"

    # Each Package Name

    local packageName=''

    for packageName in "${packageNameList[@]}"
    do
        local packageNameForHeader=''
        packageNameForHeader="$(tr '[:lower:]' '[:upper:]' <<< "${packageName}")"

        # Pre Install

        if [[ -f "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/${packageName}/recipes/pre-install.bash" ]]
        then
            header "PRE-INSTALLING PACKAGE ${packageNameForHeader}"
            sudo "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/${packageName}/recipes/pre-install.bash"
        fi

        # Install

        export HOMEBREW_NO_INSTALL_CLEANUP=FALSE

        header "INSTALLING BREW PACKAGE ${packageNameForHeader}"
        brew reinstall --force "${packageName}" || brew install --force "${packageName}"
        displayVersion "$(brew list --version "${packageName}")" "${packageNameForHeader}"

        # Post Install

        if [[ -f "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/${packageName}/recipes/post-install.bash" ]]
        then
            header "POST-INSTALLING PACKAGE ${packageNameForHeader}"
            sudo "$(dirname "${BASH_SOURCE[0]}")/../cookbooks/${packageName}/recipes/post-install.bash"
        fi
    done
}

function install()
{
    local -r packageNames="${1}"

    # Upgrade Brew

    "$(dirname "${BASH_SOURCE[0]}")/upgrade-brew.bash"

    # Install Packages

    installBrewPackage "${packageNames}"

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

    if [[ "$(isEmptyString "${packageNames}")" = 'true' ]]
    then
        fatal '\nFATAL : undefined package names'
    fi

    # Install

    installDependencies
    install "${packageNames}"
    postUpMessage
}

main "${@}"