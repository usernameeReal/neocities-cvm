#!/bin/bash
set -e
function doVagrant() {
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vagrant
}
function download() {
cd ~
git clone http://github.com/neocities/neocities.git
}
vagrant --version || doVagrant
git --version || sudo apt install -y git
ls ~/neocities || download
cd ~/neocities
vagrant up --provision
sleep 2
(sleep 2;echo 'bundle exec rackup -o 0.0.0.0';while true;do true;done) | script -c 'vagrant ssh' /dev/null
