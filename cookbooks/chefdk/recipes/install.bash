#!/bin/bash -e

"$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-application.bash" --application-name 'chef/chef/chefdk' --cask-application 'true' --command 'chef'