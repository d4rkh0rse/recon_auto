#!/bin/bash

domain=$1
resolvers="/root/tools/recon_auto/resolvers.txt"
#subfinder

basic_enum(){
mkdir -p $domain $domain/sources $domain/recon $domain/recon/nuclei $domain/recon/wayback $domain/recon/gf

subfinder -d $domain -o $domain/sources/subfinder.txt

#assetfinder
assetfinder -subs-only $domain | tee $domain/sources/assetfinder.txt

#amass
amass enum -passive -d $domain -o $domain/sources/passive.txt

cat $domain/sources/*.txt > $domain/sources/all.txt
}

basic_enum

resolve_domain(){

shuffledns -d $domain -list $domain/sources/all.txt -o $domain/domains.txt -r $resolvers
}

resolve_domain
http_probe(){
cat $domain/sources/all.txt | httpx -threads 200 -o $domain/recon/httpx.txt
}
http_probe



wayback(){
cat $domain/domains.txt | waybackurls | tee $domain/recon/wayback/tmp.txt
cat $domain/recon/wayback/tmp.txt | egrep -v "\.woff|\.ttf|\.svg|\.eot|\.jpeg|\.css|\.ico|\.jpg|\.png" | sed 's/:80//g;s/:443//g' | sort -u > $domain/recon/wayback/wayback.txt
}
wayback


fff(){
ffuf -c -u "FUZZ" -w $domain/recon/wayback/wayback.txt -of csv -o $domain/recon/wayback/valid_temp.txt
# ffuf -c -u "FUZZ" -w $domain/recon/wayback/wayback.txt -mc 200 -of csv -o aa.txt

cat $domain/recon/wayback/valid_temp.txt | grep http | awk -F "," '{print $1}' > $domain/recon/wayback/valid.txt
# rm $domain/recon/wayback/valid_temp.txt
}
fff

gff(){
gf xss $domain/recon/wayback/valid.txt | tee $domain/recon/gf/xss.txt
gf sqli $domain/recon/wayback/valid.txt | tee $domain/recon/gf/sqli.txt
gf lfi $domain/recon/wayback/valid.txt | tee $domain/recon/gf/lfi.txt
gf redirect  $domain/recon/wayback/valid.txt | tee $domain/recon/gf/redirect.txt
}
gff
