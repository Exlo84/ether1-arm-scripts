**ARMv8/ARM64 setup guide**

Download *Raspbian Buster Lite* [Link](https://www.raspberrypi.org/downloads/raspbian/)

Direct links:
[Torrent](https://downloads.raspberrypi.org/raspbian_lite_latest.torrent) - [Https](https://downloads.raspberrypi.org/raspbian_lite_latest)

Unzip the downloaded file, and burn the .img with f.ex _Win32 Disk Imager_ [Link](https://sourceforge.net/projects/win32diskimager/)

_For SSH access without monitor on first boot, include a file called "ssh" in root of the 'boot' partition on the sd-card. The file should contain ONLY `ECHO is on.` and have NO extention._

***With a monitor attached, or with SSH, log with:***

	User: pi
	Password: raspberry

***Set root password***

	sudo -i
	passwd
	

***Update and add user***

	apt-get update
	apt-get dist-upgrade -y
	mkdir /var/run/fail2ban
 	apt-get install sudo ufw fail2ban nano -y
  
	adduser ether1node
	adduser ether1node sudo
	adduser ether1node systemd-journal

***One last task to be executed as root is configuring fail2ban***

	cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
	cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
	systemctl restart fail2ban
	fail2ban-client status

After running the above commands & creating the ether1node user, disconnect from the server by closing down the Putty window or by type exit into the same window. Then reconnect to the server using the same IP address as before, but using the ‘ether1node’ user which you just set up.

**It is very important to ensure that you are connected as ether1node and not as the root user.**



***Install***

	mkdir -p /tmp/ether1 && cd /tmp/ether1
	rm -rf servicenode.sh && wget https://raw.githubusercontent.com/Ether1Project/ether1-node-scripts/master/rpi/install-arm64.sh
	chmod +x install-arm64.sh
	./install-arm64.sh

*You will be asked to input the password for ether1node before the third command runs*

Now the node script is running on the Server! In order to double check that the node is running you can use one of these commands

	sudo systemctl status ether1node
	sudo journalctl -f -u ether1node
 
**Congratulations your node setup is complete.**

**Now we have to register your node** 

*Node Dashboard / Verification Process (An explanation on how to finalize the node set up the process on the Ether-1 website.*

1. After setting up the Ether-1 node software on your server, you need to verify the node and tether it to your account on the Ether-1 website. This is to ensure that you control the collateral being used for the node, along with providing information such as node type, and IP address to the Ether-1 network. 

2. Go to the Ether-1 website to continue: https://nodes.ether1.org/

3. From here select the node dashboard and create an account using your E-Mail address and password.

4. In order to add the node to your account, click on the Add Node button. 

5. This page requires you to select the type of node, either Service Node or Master Node, along with the IP address of the ARM device which the node software is running on.

6. The ETHO wallet address must be the same address which holds the collateral for the node. For a Master Node, this is 15,000 coins, whereas a Service Node only requires 5,000 coins. The balance of the address can exceed the collateral requirement, but you must maintain the minimum balance in order to be eligible for payouts.

7. After submitting this information, you will need to send a small verification transaction of 0.01 ETHO, this is to verify the balance of the wallet address and to confirm that you have ownership over the address by making a transaction from it. (At this point the 0.01 ETH0 is not recoverable.)

8. The node should now be present in the dashboard but the node is not verified. This means the node is not eligible for payouts. To verify the node click on the details button at the end of the table.

9. The verification address is the address which the 0.01 ETHO must be sent to in order to verify the node.

10. It is  important NOT to send the collateral to this address, only the 0.01 ETHO verification amount, as any funds sent to the verification address are not currently recoverable.

11. After sending the transaction, it will appear in your wallet. Once the transaction is confirmed by the network, copy the transaction ID from your wallet to the node verification page on the Ether-1 website.

12. After pasting this link into the node page, click the Add button. This will take a few seconds to verify and then you will be returned to the node dashboard.

***An uptime of 95% is required for Service Nodes and Masternodes***
