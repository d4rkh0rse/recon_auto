#!/bin/bash 

#this script was written by @D4rk_h0rs3
#happy hacking 

#install script languages 

sudo apt-get install golang;
sudo apt-get install python3;
sudo apt-get install python3-pip;
sudo apt-get install python-pip; 
sudo apt-get install ruby;
sudo apt-get install screen;
sudo apt-get install git;
pip install requests; 



#install subfinder
GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder;

# massdns
git clone https://github.com/blechschmidt/massdns.git;
cd massdns/
make
cp /bin/massdns /usr/bin/;
cd ../

# install dnsvalidator

git clone https://github.com/vortexau/dnsvalidator.git

cd dnsvalidator/
python3 setup.py install
dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 20 -o resolvers.txt
cp resolvers.txt ./recon_auto
cd ../

# install gf
go get -u github.com/tomnomnom/gf
echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.bashrc
cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf 
git clone https://github.com/1ndianl33t/Gf-Patterns
mv ~/Gf-Patterns/*.json ~/.gf

# install assetfinder
go get -u github.com/tomnomnom/assetfinder

# install waybackurls
go get -u github.com/tomnomnom/waybackurls 

# amass instal
export GO111MODULE=on
go get -v github.com/OWASP/Amass/v3/...