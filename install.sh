#!/bin/sh

#this script was written by @D4rk_h0rs3

#install subfinder
GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder;
git clone https://github.com/blechschmidt/massdns.git;
cd massdns/
make
cp bin/massdns /usr/bin/
cd ../


# install dnsvalidator
git clone https://github.com/vortexau/dnsvalidator.git;
cd dnsvalidator/;
python3 setup.py install;
dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 200 -o resolvers.txt;
cp dnsvalidator/resolvers.txt ../recon_auto/;
cd ../;

# install assetfinder
go get -u github.com/tomnomnom/assetfinder

# install waybackurls
go get -u github.com/tomnomnom/waybackurls

# amass install
export GO111MODULE=on
go get -v github.com/OWASP/Amass/v3/...

# ffuf install
go get -u github.com/ffuf/ffuf

# install shuffledns
GO111MODULE=on go get -u -v github.com/projectdiscovery/shuffledns/cmd/shuffledns

# install httpx
GO111MODULE=auto go get -u -v github.com/projectdiscovery/httpx/cmd/httpx

# install gf
go get -u github.com/tomnomnom/gf
mkdir ~/.gf
echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.bashrc
cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns
mv ./Gf-Patterns/*.json ~/.gf
