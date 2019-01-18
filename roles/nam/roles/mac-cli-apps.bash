#!/bin/bash -e

function main()
{
    # Packages

    local -r caskPackageNames=(
        'chef/chef/chefdk'
        'google-cloud-sdk'
        'java'
        'vagrant'
    )

    local -r packageNames=(
        'ack'
        'awscli'
        'azure-cli'
        'ccat'
        'coreutils'
        'cowsay'
        'dialog'
        'geoip'
        'glances'
        'go'
        'hping'
        'htop'
        'jq'
        'mas'
        'moreutils'
        'mtr'
        'netcat'
        'nmap'
        'node'
        'nomad'
        'packer'
        'shellcheck'
        'siege'
        'terraform'
        'testssl'
        'tmux'
        'tree'
        'vault'
        'wget'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireNonRootUser

    "$(dirname "${BASH_SOURCE[0]}")/../../../cookbooks/brew/recipes/reinstall.bash" 'true'
    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")" \
        --package-names "$(arrayToString "${packageNames[@]}")"

    postUpMessage
}

main "${@}"