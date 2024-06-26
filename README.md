# IPFS Setup and Usage

This repository contains a script to install and configure IPFS on a BKAD (bitknoweldge archive device). 

## Preparation 

Ensure you are on a linux machine, create a bitk1 account and ensure you are logged on. 

## Setup

To set up IPFS on your BKAD, run the following commands:

```bash
git clone https://github.com/bitk1/bk-setup-01.git
cd bk-setup-01


Make the Script Executable (if needed):
chmod +x setup_ipfs.sh

Run the Setup Script:
sudo ./setup_ipfs.sh

Start the Service:
sudo systemctl start ipfs

Check Status:
sudo systemctl status ipfs

Stop the Service:
sudo systemctl stop ipfs

Restart the Service:
sudo systemctl restart ipfs

Enable the Service (start at boot):
sudo systemctl enable ipfs

Disable the Service:
sudo systemctl disable ipfs

Additional Configuration
Set Up IPFS Web UI:
Access the IPFS Web UI by opening http://127.0.0.1:5001/webui in a web browser on the Raspberry Pi. You can also configure remote access if needed.




## Basic IPFS command line commands

Add a File to IPFS:
echo "Hello, IPFS!" > hello.txt
ipfs add hello.txt

Retrieve a File from IPFS:
ipfs cat <file_hash>
Replace <file_hash> with the actual hash of the file.

Check IPFS Node Info:
ipfs id

View Connected Peers:
ipfs swarm peers
Systemd Service

List files:
ipfs files ls /

List all pinned files: 
ipfs pin ls --type=all


The IPFS daemon is set up to run as a systemd service. You can manage it using the following commands:


sudo systemctl status ipfs
The output should indicate that the IPFS service is active and running.

Verify IPFS Daemon is Running:
ipfs id
This command should return the identity information of your IPFS node, including its peer ID and addresses.

Troubleshooting
If you encounter issues, here are some steps to troubleshoot:

Reboot the BKAD:
sudo reboot

Check System Logs for Errors:
sudo journalctl -u ipfs -b

Reinitialize IPFS Repository (if needed):
ipfs init
