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
    echo    '    --disable'
    echo    '    --enable'
    echo -e '\033[1;35m'
    echo    'DESCRIPTION :'
    echo    '  --help       Help page (optional)'
    echo    '  --disable    Disable AutoBoot (require)'
    echo    '  --enable     Enable AutoBoot (require)'
    echo -e '\033[1;36m'
    echo    'EXAMPLES :'
    echo    "  ./${scriptName} --help"
    echo    "  ./${scriptName} --enable"
    echo    "  ./${scriptName} --disable"
    echo -e '\033[0m'

    exit "${1}"
}

function setupNVRAM()
{
    local -r header="${1}"
    local -r option="${2}"

    header "${header} NVRAM-AUTOBOOT"
    info "$(nvram -p)"
    sudo nvram "AutoBoot=${option}"
    info "$(nvram -p)"
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

            --enable)
                setupNVRAM 'ENABLING' '%03'
                break
                ;;

            --disable)
                setupNVRAM 'DISABLING' '%00'
                break
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
}

main "${@}"