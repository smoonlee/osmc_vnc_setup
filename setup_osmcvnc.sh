

# Install Package Dependancies 
sudo apt install -y build-essential rbp-userland-dev-osmc libvncserver-dev libconfig++-dev unzip

# Download VNC Server Source 
cd /home/osmc
sudo wget https://github.com/patrikolausson/dispmanx_vnc/archive/master.zip
unzip master.zip -d  /home/osmc/
rm master.zip -y
cd dispmanx_vnc-master 
make

# Configure VNC Server
sudo cp dispmanx_vncserver /usr/bin/vncserver
sudo chmod +x /usr/bin/vncserver
sudo cp dispmanx_vncserver.conf.sample /etc/vnc_server.conf
sudo vi /etc/vnc_server.conf

# Configure VNC Service
sudo vi /etc/systemd/system/vnc_server.service

[Unit]
Description=VNC Server
After=network-online.target mediacenter.service
Requires=mediacenter.service


[Service]
Restart=on-failure
RestartSec=30
Nice=15
User=root
Group=root
Type=simple
ExecStartPre=/sbin/modprobe evdev
ExecStart=/usr/bin/vncserver
KillMode=process

[Install]
WantedBy=multi-user.target