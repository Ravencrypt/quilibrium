# quilibrium
Setup and Update Quillibrium Node
With this guide you can Setup and Update your Quil node. Script is written for Ubuntu.

Requirements recommended:
- min 8 cores
- 32GB RAM
- 500GB Disk Space

What does the scripts do?

Setup:
- Install go
- Set global variables
- Setup firewall rules
- Download Ceremony Client (Quil Node)
- Setup Ceremonyclient Service
- Install Node Binaries
- Reload Deamon and start Service
- Backup key + config to root
- Build Q client

Update:
- will update once 1.4.18 is out as the process will change

HowTo:
- Download setup.sh
- chmod +x setup.sh
- ./setup.sh (run script)
- It's possible that a warning pops up "This operation might disrupt your current ssh connection" or something similar. This is because the firewall gets activated - say "y" here

The Script automatically copies the key.yml and config.yml to your root folder, make sure to save that somewhere safe as this are the keys to your wallet!

Some common commands:
 - stop your node:
service ceremonyclient stop

 - start your node:
service ceremonyclient start

- see status of your node:
service ceremonyclient status

- see Quil Logs:
sudo journalctl -u ceremonyclient.service -f --no-hostname -o cat

- run db console:
GOEXPERIMENT=arenas go run ./... --db-console

- see peer id:
GOEXPERIMENT=arenas go run ./... --peer-id

