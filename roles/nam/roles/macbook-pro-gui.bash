#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Load Libraries

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireNonRootUser

    # Brew Cask Applications

    "${appFolderPath}/../../../cookbooks/1password/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/beyond-compare/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/blue-jeans/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/dropbox/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/google-backup-and-sync/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/google-chrome/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/slack/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/tower/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/transmit/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/visual-studio-code/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/vmware-fusion/recipes/install.bash"

    # Finish

    postUpMessage
}

main "${@}"