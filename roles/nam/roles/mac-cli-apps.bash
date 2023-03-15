#!/bin/bash -e

function main()
{
    # Packages

    local -r packageNames=(
        'awscli'
        'ccat'
        'chef-workstation'
        'coreutils'
        'dialog'
        'gawk'
        'go'
        'jq'
        'kubernetes-cli'
        'maven'
        'minikube'
        'moreutils'
        'netcat'
        'openjdk'
        'p7zip'
        'packer'
        'pcre'
        'terraform'
        'tree'
        'vault'
        'wget'
        'xq'
        'yq'
        # 'ack'
        # 'akamai'
        # 'azure-cli'
        # 'consul'
        # 'cowsay'
        # 'docker-compose'
        # 'docker'
        # 'fortune'
        # 'geoip'
        # 'glances'
        # 'hping'
        # 'htop'
        # 'ipcalc'
        # 'lolcat'
        # 'mas'
        # 'midnight-commander'
        # 'mtr'
        # 'ncdu'
        # 'nmap'
        # 'node'
        # 'nomad'
        # 'python3'
        # 'redis'
        # 'shellcheck'
        # 'siege'
        # 'stunnel'
        # 'testssl'
        # 'tldr'
        # 'tmux'
        # 'watch'
        # 'whatmask'
    )

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/app.bash"
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    # Install Brew

    sudo rm -f -r '/opt/chefdk'

    "$(dirname "${BASH_SOURCE[0]}")/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    # Install Brew Applications

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
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