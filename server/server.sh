#!/bin/bash

# Set the current working directory to the one this script is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}

coffee web_server.coffee