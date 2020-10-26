#!/bin/bash

set -e

snap install microk8s --classic --channel=1.17/stable

usermod -a -G microk8s $USER

su - $USER

microk8s.status --wait-ready
