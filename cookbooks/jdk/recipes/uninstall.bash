#!/bin/bash -e

"$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-application.bash" --application-name 'java' --cask-application 'true'
sudo rm -f -r '/Library/Java/JavaVirtualMachines'/openjdk-*.jdk