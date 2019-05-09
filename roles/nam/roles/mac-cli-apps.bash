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
        'akamai'
        'awscli'
        'azure-cli'
        'ccat'
        'consul'
        'coreutils'
        'cowsay'
        'dialog'
        'docker-compose'
        'docker-machine'
        'docker'
        'fortune'
        'geoip'
        'glances'
        'go'
        'hping'
        'htop'
        'ipcalc'
        'jq'
        'lolcat'
        'mas'
        'midnight-commander'
        'moreutils'
        'mtr'
        'netcat'
        'nmap'
        'node'
        'nomad'
        'packer'
        'parallel'
        'python3'
        'shellcheck'
        'siege'
        'terraform'
        'testssl'
        'tldr'
        'tmux'
        'tree'
        'vault'
        'watch'
        'watchman'
        'wget'
        'whatmask'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")" \
        --package-names "$(arrayToString "${packageNames[@]}")"
}

main "${@}"