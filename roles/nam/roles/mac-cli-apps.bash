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
        'dialog'
        'docker-compose'
        'docker'
        'gawk'
        'git-lfs'
        'glances'
        'go'
        'hashicorp/tap/packer'
        'hashicorp/tap/terraform'
        'hashicorp/tap/vault'
        'jq'
        'kubelogin'
        'kubernetes-cli'
        'mas'
        'maven'
        'midnight-commander'
        'minikube'
        'mongosh'
        'moreutils'
        'netcat'
        'openjdk'
        'p7zip'
        'pcre'
        'python3'
        'rename'
        'shellcheck'
        'siege'
        'speedtest-cli'
        'stunnel'
        'teleport'
        'terragrunt'
        'testssl'
        'tmux'
        'tree'
        'watch'
        'wget'
        'xq'
        'yamlfmt'
        'yq'
    )

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

    # Finish

    postUpMessage
}

main "${@}"