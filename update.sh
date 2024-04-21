#!/bin/bash

# Script to update, clean, and rebuild the Ceremonyclient

# Stop the ceremony client service
service ceremonyclient stop

# Update the project repository
cd /root/ceremonyclient
git fetch origin
git merge origin/master  # Assuming you want to merge master; adjust if another branch

# Clean the Node
cd node
GOEXPERIMENT=arenas go clean -v -n -a ./...

# Remove the previous build
rm -f /root/go/bin/node

# Install the Binary again
GOEXPERIMENT=arenas go install ./...

# Check if the new executable is in the expected location
if [ -f /root/go/bin/node ]; then
    echo "Node executable is present in /root/go/bin."
else
    echo "Error: Node executable is not present in /root/go/bin."
    exit 1
fi

# Start the ceremony client service
service ceremonyclient start

echo "Ceremony Client has been successfully updated and restarted."
