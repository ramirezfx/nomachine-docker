echo "TAG (example: nomachine:latest)"
read tag
rm nomachine_6.11.2_1_amd64.deb
wget https://download.nomachine.com/download/6.11/Linux/nomachine_6.11.2_1_amd64.deb
sudo docker build -t $tag .
echo "Build finished"
