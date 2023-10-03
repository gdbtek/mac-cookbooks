#!/bin/bash -e

function uninstall()
{
    local -r confirm="${1}"

    if [[ "${confirm}" = 'true' ]]
    then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)" < '/dev/null' || true
    else
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)" || true
    fi

    # Mac Intel

    rm -f -r \
        '/usr/local/.com.apple.installer.keep' \
        '/usr/local/bin' \
        '/usr/local/Caskroom' \
        '/usr/local/Cellar' \
        '/usr/local/etc' \
        '/usr/local/Frameworks' \
        '/usr/local/Homebrew' \
        '/usr/local/include' \
        '/usr/local/lib' \
        '/usr/local/opt' \
        '/usr/local/sbin' \
        '/usr/local/share' \
        '/usr/local/var'

    # Mac M1

    rm -f -r \
        '/opt/homebrew'

    # Others

    rm -f -r \
        '/opt/chef-workstation' \
        '/opt/chef' \
        '/opt/inspec'

    info "\n=> /usr/local\n$(ls -a -l '/usr/local')"
    info "\n=> /opt/\n$(ls -a -l '/opt')"
}

function main()
{
    local -r confirm="${1}"

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'UNINSTALLING BREW'

    # Uninstall

    uninstall "${confirm}"
}

main "${@}"