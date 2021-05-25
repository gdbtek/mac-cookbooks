#!/bin/bash -e

function main()
{
    # Packages

    local -r caskPackageNames=(
        'chefdk'
    )

    local -r packageNames=(
        'awscli'
        'ccat'
        'coreutils'
        'dialog'
        'gawk'
        'jq'
        'moreutils'
        'netcat'
        'packer'
        'pcre'
        'tree'
        'yq'
        # 'ack'
        # 'akamai'
        # 'azure-cli'
        # 'consul'
        # 'cowsay'
        # 'fortune'
        # 'geoip'
        # 'glances'
        # 'go'
        # 'hping'
        # 'htop'
        # 'ipcalc'
        # 'kubernetes-cli'
        # 'lolcat'
        # 'mas'
        # 'maven'
        # 'midnight-commander'
        # 'minikube'
        # 'mtr'
        # 'ncdu'
        # 'nmap'
        # 'node'
        # 'nomad'
        # 'openjdk'
        # 'python3'
        # 'redis'
        # 'shellcheck'
        # 'siege'
        # 'stunnel'
        # 'terraform'
        # 'testssl'
        # 'tldr'
        # 'tmux'
        # 'vault'
        # 'watch'
        # 'wget'
        # 'whatmask'
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

    # Finish

    postUpMessage
}

main "${@}"