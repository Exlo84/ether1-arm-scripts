#!/usr/bin/env sh
_user="$(id -u -n)"

echo '**************************'
echo 'Installing misc dependencies'
echo '**************************'

# install dependencies
sudo apt-get update && sudo apt-get install systemd unzip wget -y

echo '**************************'
echo 'Installing Ether-1 Node binary'
echo '**************************'

# Download node binary
sudo systemctl stop ether1node

sudo rm geth

wget https://github.com/Ether1Project/Ether-1-SN-MN-Binaries/releases/download/1.2.1/Ether1-MN-SN-1.2.1-arm.zip

unzip Ether1-MN-SN-1.2.1-arm.zip

# Make node executable
chmod +x geth

# Remove and cleanup
rm Ether1-MN-SN-1.2.1-arm.zip

echo '**************************'
echo 'Creating and setting up system service'
echo '**************************'

cat > /tmp/ether1node.service << EOL
[Unit]
Description=Ether1 Masternode/Service Node
After=network.target
[Service]
User=$_user
Group=$_user
Type=simple
Restart=always
ExecStart=/usr/sbin/geth --syncmode=fast --cache=512
[Install]
WantedBy=default.target
EOL

sudo \mv /tmp/ether1node.service /etc/systemd/system
sudo \rm /usr/sbin/geth
sudo \mv geth /usr/sbin/
sudo systemctl enable ether1node && sudo systemctl stop ether1node && sudo systemctl start ether1node
systemctl status ether1node --no-pager --full

echo '**************************'
echo 'Servicenode Setup Complete....Deploying IPFS'
echo '**************************'

cd /home/$_user
wget wget https://github.com/ipfs/go-ipfs/releases/download/v0.4.22/go-ipfs_v0.4.22_linux-arm.tar.gz

tar -xvzf go-ipfs_v0.4.22_linux-arm.tar.gz
cd go-ipfs
chmod +x ipfs

# Remove and cleanup
rm /home/$_user/go-ipfs_v0.4.22_linux-arm.tar.gz

echo '**************************'
echo 'Creating and setting up IPFS system service'
echo '**************************'

cat > /tmp/ipfs.service << EOL
[Unit]
Description=IPFS Node System Service
After=network.target
[Service]
User=$_user
Group=$_user
Type=simple
Restart=always
ExecStart=/usr/sbin/ipfs daemon --migrate --enable-namesys-pubsub --enable-gc --routing=dhtclient
[Install]
WantedBy=default.target
EOL

sudo systemctl stop ipfs
sudo \mv /tmp/ipfs.service /etc/systemd/system
sudo \mv ipfs /usr/sbin/
ipfs bootstrap rm --all
sudo rm -r $HOME/.ipfs
sudo rm -r /home/$_user/.ipfs
ipfs init

_maxstorage="16GB"

ipfs config Datastore.StorageMax $_maxstorage
ipfs config --json Swarm.ConnMgr.LowWater 400
ipfs config --json Swarm.ConnMgr.HighWater 600
ipfs bootstrap add /ip4/142.44.246.43/tcp/4001/ipfs/QmPW8zExrEeno85Us3H1bk68rBo7N7WEhdpU9pC9wjQxgu
ipfs bootstrap add /ip4/51.79.70.144/tcp/4001/ipfs/QmTcwcKqKcnt84wCecShm1zdz1KagfVtqopg1xKLiwVJst
ipfs bootstrap add /ip4/51.77.150.202/tcp/4001/ipfs/QmUEy4ScCYCgP6GRfVgrLDqXfLXnUUh4eKaS1fDgaCoGQJ
ipfs bootstrap add /ip4/51.38.131.241/tcp/4001/ipfs/Qmf4oLLYAhkXv95ucVvUihnWPR66Knqzt9ee3CU6UoJKVu
ipfs bootstrap add /ip4/164.68.107.82/tcp/4001/ipfs/QmeG81bELkgLBZFYZc53ioxtvRS8iNVzPqxUBKSuah2rcQ
ipfs bootstrap add /ip4/164.68.98.94/tcp/4001/ipfs/QmeG81bELkgLBZFYZc53ioxtvRS8iNVzPqxUBKSuah2rcQ
ipfs bootstrap add /ip4/164.68.108.54/tcp/4001/ipfs/QmRwQ49Zknc2dQbywrhT8ArMDS9JdmnEyGGy4mZ1wDkgaX
sudo mv $HOME/.ipfs /home/$_user/
sudo chown -R $_user:$_user /home/$_user/.ipfs

cat > /tmp/swarm.key << EOL
/key/swarm/psk/1.0.0/
/base16/
38307a74b2176d0054ffa2864e31ee22d0fc6c3266dd856f6d41bddf14e2ad63
EOL

sudo \mv /tmp/swarm.key /home/$_user/.ipfs
sudo systemctl daemon-reload
sudo systemctl enable ipfs && systemctl start ipfs
sudo systemctl restart ipfs
sudo systemctl status ipfs --no-pager --full

echo '**************************'
echo 'IPFS Setup Complete....Deploying ethoFS'
echo '**************************'

cd $HOME
wget https://github.com/Ether1Project/Ether-1-SN-MN-Binaries/releases/download/1.2.1/ethofs-arm.zip
unzip ethofs-arm.zip
chmod +x ethofs

# Remove and cleanup
rm ethofs-arm.zip

echo '**************************'
echo 'Creating and setting up ethoFS system service'
echo '**************************'

cat > /tmp/ethoFS.service << EOL
[Unit]
Description=ethoFS Node System Service
After=network.target
[Service]
User=$_user
Group=$_user
Type=simple
Restart=always
ExecStart=/usr/sbin/ethofs -servicenode
[Install]
WantedBy=default.target
EOL

sudo systemctl stop ethoFS
sudo \mv /tmp/ethoFS.service /etc/systemd/system
sudo \mv ethofs /usr/sbin/
sudo systemctl daemon-reload
sudo systemctl enable ethoFS && sudo systemctl start ethoFS
sudo systemctl restart ethoFS
sudo systemctl status ethoFS --no-pager --full

echo '**************************'
echo 'ethoFS Setup Complete'
echo '**************************'

echo 'Done.'
