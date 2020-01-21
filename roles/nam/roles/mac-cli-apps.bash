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
        'kubernetes-cli'
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

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/app.bash"
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    # Install Brew

    "$(dirname "${BASH_SOURCE[0]}")/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    # Install Brew Applications

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")" \
        --package-names "$(arrayToString "${packageNames[@]}")"

    # Install Command Line Tools

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-command-line-tools.bash"

    # Install All Available Software Updates

    sudo "$(dirname "${BASH_SOURCE[0]}")/../../../tools/update-software.bash"

    # Install VirtualBox Binary Files

    installVirtualBoxUSRLocalBinFiles
}

main "${@}"