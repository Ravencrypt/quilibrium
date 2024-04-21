# quillibrium
Setup and Update Quillibrium Node
With this guide you can Setup and Update your Quil node

Requirements recommended:
- min 8 cores
- 64GB RAM
- 500GB Disk Space

Setup:
- Download setup.sh and update.sh
- sed -i 's/\r$// setup.sh  (I used notepad++ to create it, so the carriage return characters need to be removed eventually. Just run this so you don't run into issues in any case. Only need to do that once)
- chmod +x setup.sh (make file executable, only needed once)
- ./setup.sh (run script)
- Same goes for the update script.

Line 68/69 is commented out
#cd ceremonyclient/client
#go build ./... -o qclient

remove the # if you install version 1.5 directly so the qclient is automatically setup aswell. this won't work in earlier versions hence why it's commented out

The Script automatically copies the key.yml and config.yml to your root folder, make sure to save that somewhere safe as this are the key to your wallet!

Some common commands:
 - stop your node
service ceremonyclient stop

 - start your node
service ceremonyclient start

- see status of your node
service ceremonyclient status

- see Quil Logs
sudo journalctl -u ceremonyclient.service -f --no-hostname -o cat

- run db console
GOEXPERIMENT=arenas go run ./... --db-console

- see peer id
GOEXPERIMENT=arenas go run ./... --peer-id

