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
        'fortune'
        'gawk'
        'geoip'
        'glances'
        'go'
        'hping'
        'htop'
        'ipcalc'
        'jq'
        'lolcat'
        'mas'
        'maven'
        'midnight-commander'
        'moreutils'
        'mtr'
        'ncdu'
        'netcat'
        'nmap'
        'node'
        'nomad'
        'packer'
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
        'wget'
        'whatmask'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/app.bash"
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")" \
        --package-names "$(arrayToString "${packageNames[@]}")"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/update-software.bash"

    resetVirtualBoxUSRLocalBinFiles
}

main "${@}"