#!/bin/bash
clear
mkdir -p /root/Desktop/enumerationdir
cd /root/Desktop/enumerationdir


echo "Enter the target IP Address or Range. ex. 192.168.1.1-254 or 192.168.1.0/24, and press enter"
read ipaddr

#Running nmap ping scan to detect live hosts
nmap -T4 -n -sn $ipaddr -oG livehosts

#Cutting the ip addresses out of the output from previous scan for input on the next scan
cat livehosts | grep Status | cut -d " " -f 2 > inputlist.txt

#taking live hosts and running OS detection on them via nmap again and saving to a greppable file
nmap -iL inputlist.txt -O -oG 4sorting

#Cutting and soting the versionscan output into Windows and Linux hosts
cat 4sorting | grep OS | grep Linux | cut -d " " -f 2 > linuxhosts.txt

cat 4sorting | grep OS | grep Windows | cut -d " " -f 2 > winhosts.txt
 
while read hosts; do enum4linux $host; done < hosts=linuxhosts.txt 

nbtscan -v -f winhosts.txt
smbmap --host-file winhosts.txt 

while read hostswin; do
	rpcclient -U " " -N  $hostwin; 
	
	done  < hostswin=winhosts.txt 























exit