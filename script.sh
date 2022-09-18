#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y 
sudo systemctl enable nginx
sudo systemctl start nginx
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16.15.0
sudo yum install git -y
cd /home/ec2-user/
git clone https://github.com/TheSpaceCuber/react-hooks.git
cd /home/ec2-user/react-hooks/
npm i
npm run build
cd /usr/share/html
sudo cp -R /home/ec2-user/react-hooks/build/* .
sudo cp /home/ec2-user/react-hooks/nginx.conf /etc/nginx/nginx.conf
sudo systemctl reload nginx