**Raspberry Pi setup guide**

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
	rm -rf servicenode.sh && wget https://raw.githubusercontent.com/Ether1Project/ether1-node-scripts/master/rpi/install-arm6.sh
	chmod +x install-arm6.sh
	./install-arm6.sh

*You will be asked to input the password for ether1node before the third command runs*

Now the node script is running on the Server! In order to double check that the node is running you can use one of these commands

	sudo systemctl status ether1node
	sudo journalctl -f -u ether1node
 
**Congratulations your node setup is complete.**
