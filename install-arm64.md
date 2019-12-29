**ARMv8/ARM64 setup guide**

Get [Armbian](https://www.armbian.com/download/) for your ARMv8 SoC or [Ubuntu Server](http://cdimage.ubuntu.com/releases/19.10.1/release/ubuntu-19.10.1-preinstalled-server-arm64+raspi3.img.xz) for for [Raspberry Pi 4](https://ubuntu.com/download/raspberry-pi)

**Armbian** Log in as: *root*  Password: *1234*

**Ubuntu** Log in as: *ubuntu*  Password: *ubuntu*

Running Ether-1 nodes must adhere to the following hardware and networking **requirements**:
	
1. Have a **static** public IPv4 address
2. Masternodes require **2GB** of **RAM** and Service Nodes **1GB** of **RAM**
3. Must allow firewall access through TCP & UDP port **30305**. (For node traffic)
4. **40GB** of available storage for a Masternode and **20GB** of available storage for a Service Node
5. The collateral required to host a masternode is **15 thousand ETHO** and a service node only requires **5 thousand ETHO**.	

***Update and install***

	1. apt-get update
	2. apt-get dist-upgrade -y
	3. mkdir /var/run/fail2ban
 	4. apt-get install sudo fail2ban nano -y

***One last task before installing is configuring fail2ban***

	1. cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
	2. cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
	3. systemctl restart fail2ban
	4. fail2ban-client status

***Install***

	1. mkdir -p /tmp/ether1 && cd /tmp/ether1
	2. rm -rf servicenode.sh && wget https://raw.githubusercontent.com/Ether1Project/ether1-node-scripts/master/rpi/install-arm64.sh
	3. chmod +x install-arm64.sh
	4. ./install-arm64.sh

*You will be asked to input the password for ether1node before the third command runs*

Now the node script is running on the Server! In order to double check that the node is running you can use one of these commands

	1. sudo systemctl status ether1node
	2. sudo journalctl -f -u ether1node
 
**Congratulations your node setup is complete.**

**Now we have to register your node** 

*Node Dashboard / Verification Process (An explanation on how to finalize the node set up the process on the Ether-1 website.*

1. After setting up the Ether-1 node software on your server, you need to verify the node and tether it to your account on the Ether-1 website. This is to ensure that you control the collateral being used for the node, along with providing information such as node type, and IP address to the Ether-1 network. 

2. Go to the Ether-1 website to continue: https://nodes.ether1.org/

3. From here select the node dashboard and create an account using your E-Mail address and password.

4. In order to add the node to your account, click on the Add Node button. 

5. This page requires you to select the type of node, either Service Node or Master Node, along with the IP address of the ARM device which the node software is running on.

6. The ETHO wallet address must be the same address which holds the collateral for the node. For a Master Node, this is 15,000 coins, whereas a Service Node only requires 5,000 coins. The balance of the address can exceed the collateral requirement, but you must maintain the minimum balance in order to be eligible for payouts.

7. After submitting this information, you will need to send a small verification transaction of 0.01 ETHO, this is to verify the balance of the wallet address and to confirm that you have ownership over the address by making a transaction from it. (At this point the 0.01 ETHO is not recoverable.)

8. The node should now be present in the dashboard but the node is not verified. This means the node is not eligible for payouts. To verify the node click on the details button at the end of the table.

9. The verification address is the address which the 0.01 ETHO must be sent to in order to verify the node.

10. It is  important NOT to send the collateral to this address, only the 0.01 ETHO verification amount, as any funds sent to the verification address are not currently recoverable.

11. After sending the transaction, it will appear in your wallet. Once the transaction is confirmed by the network, copy the transaction ID from your wallet to the node verification page on the Ether-1 website.

12. After pasting this link into the node page, click the Add button. This will take a few seconds to verify and then you will be returned to the node dashboard.

***An uptime of 95% is required for Service Nodes and Masternodes***

Tip to extend your SDcard's lifetime. Install [log2ram](https://github.com/azlux/log2ram#install) from azlux. And on SoC with 4gb RAM or more, you can disable SWAP
