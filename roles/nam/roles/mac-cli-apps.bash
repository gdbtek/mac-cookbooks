#!/bin/bash -e

function main()
{
    # Packages

    local -r packageNames=(
        'awscli'
        'azure-cli'
        'ccat'
        'chef-workstation'
        'coreutils'
        'defaultbrowser'
        'dialog'
        'gawk'
        'go'
        'hashicorp/tap/vault'
        'jq'
        'kubernetes-cli'
        'maven'
        'minikube'
        'mongosh'
        'moreutils'
        'netcat'
        'openjdk'
        'p7zip'
        'pcre'
        'python3'
        'terraform'
        'testssl'
        'tree'
        'wget'
        'xq'
        'yamlfmt'
        'yq'
        # 'ack'
        # 'akamai'
        # 'consul'
        # 'cowsay'
        # 'docker-compose'
        # 'docker'
        # 'fortune'
        # 'geoip'
        # 'glances'
        # 'hashicorp/tap/packer'
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
        # 'redis'
        # 'shellcheck'
        # 'siege'
        # 'speedtest-cli'
        # 'stunnel'
        # 'tldr'
        # 'tmux'
        # 'watch'
        # 'whatmask'
    )

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    # Install Brew

    sudo rm -f -r '/opt/chefdk'

    "$(dirname "${BASH_SOURCE[0]}")/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    # Install Brew Applications

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --package-names "$(arrayToString "${packageNames[@]}")"

    # Use Older Packer For Chef-Solo

    header 'INSTALLING OLDER PACKER FOR CHEF-SOLO'

    if [[ "$(isMachineHardware 'arm64')" = 'true' ]]
    then
        unzipRemoteFile \
            'https://releases.hashicorp.com/packer/1.8.7/packer_1.8.7_darwin_arm64.zip' \
            "$(getCurrentUserHomeFolder)/Downloads"
    else
        unzipRemoteFile \
            'https://releases.hashicorp.com/packer/1.8.7/packer_1.8.7_darwin_amd64.zip' \
            "$(getCurrentUserHomeFolder)/Downloads"
    fi

    sudo mkdir -p '/usr/local/sbin'
    sudo mv -f "$(getCurrentUserHomeFolder)/Downloads/packer" '/usr/local/sbin'

    info "$(packer --version)"

    # Install Command Line Tools

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-command-line-tools.bash"

    # Install All Available Software Updates

    sudo "$(dirname "${BASH_SOURCE[0]}")/../../../tools/update-software.bash"

    # Finish

    postUpMessage
}

main "${@}"