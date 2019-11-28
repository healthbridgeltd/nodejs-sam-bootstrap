#!/bin/sh
# Return exit code 1 if exec or cd = false
set -e

# Print exec run to terminal
set -x

# Change directory to /app
cd /app

# Run command and params passed from "docker run"
exec "$@"
