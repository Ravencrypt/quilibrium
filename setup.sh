#!/bin/bash

# Go Installation & setup
wget https://go.dev/dl/go1.20.14.linux-amd64.tar.gz
tar -xf go1.20.14.linux-amd64.tar.gz
rm -rf /usr/local/go
chown -R root:root ./go
mv -v go /usr/local
echo -e "\n# Go Lang Path\nexport GOPATH=\$HOME/go\nexport PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin" | tee -a /etc/profile

source /etc/profile

rm -r go1.20.14.linux-amd64.tar.gz

# Clone the Quillibrium repository
git clone https://github.com/QuilibriumNetwork/ceremonyclient.git

sleep 20 

# Configure the firewall
ufw enable
ufw allow 22
ufw allow 8336
ufw allow 8337
ufw allow 8338
ufw allow 8317
ufw allow 8316

# Create a systemd service file for the Ceremony Client
cat <<EOF > /lib/systemd/system/ceremonyclient.service
[Unit]
Description=Ceremony Client Go App Service

[Service]
Type=simple
Restart=always
RestartSec=5s
WorkingDirectory=/root/ceremonyclient/node
Environment=GOEXPERIMENT=arenas
ExecStart=/root/go/bin/node ./...

[Install]
WantedBy=multi-user.target
EOF

# Install the Ceremony Client Node
cd ceremonyclient/node
GOEXPERIMENT=arenas go install ./...

sleep 20

# Return to home directory
cd ~

# Reload systemd, enable and start the service
systemctl daemon-reload
systemctl enable ceremonyclient.service
systemctl start ceremonyclient.service


sleep 20

# Backup configuration files to home directory
cp ceremonyclient/node/.config/keys.yml ~
cp ceremonyclient/node/.config/config.yml ~

# Build the client (for 1.5)
#cd ceremonyclient/client
#go build ./... -o qclient


# Script completion message
echo "Setup and build completed successfully!"