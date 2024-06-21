# IPFS Setup and Usage

This repository contains a script to install and configure IPFS on a Raspberry Pi.

## Setup

To set up IPFS on your Raspberry Pi, run the following commands:

```bash
git clone https://github.com/bitk1/bk-setup-01.git
cd bk-setup-01
sudo ./setup_ipfs.sh


Make the Script Executable:

chmod +x setup_ipfs.sh
Run the Setup Script:

Basic IPFS Commands
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
The IPFS daemon is set up to run as a systemd service. You can manage it using the following commands:

Check Status:

sudo systemctl status ipfs
Start the Service:

sudo systemctl start ipfs
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

Explore IPFS Use Cases:
Consider how you will use IPFS for your project, such as distributed file storage, content sharing, or data backup.

Automation and Scripting:
If you have specific use cases, consider creating additional scripts or tools to automate tasks with IPFS.

Verification Steps
After setting up IPFS, verify that the IPFS daemon is running and configured correctly:

Check the IPFS Service Status:

sudo systemctl status ipfs
The output should indicate that the IPFS service is active and running.

Verify IPFS Daemon is Running:

ipfs id
This command should return the identity information of your IPFS node, including its peer ID and addresses.

Troubleshooting
If you encounter issues, here are some steps to troubleshoot:

Reboot the Raspberry Pi:

sudo reboot
Check System Logs for Errors:

sudo journalctl -u ipfs -b
Check Network Configuration:
Ensure that your Raspberry Pi has a stable network connection.

Reinitialize IPFS Repository (if needed):

ipfs init
