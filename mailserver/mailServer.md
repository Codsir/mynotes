## How to Install and Configure Mail Server in Ubuntu

```sh
sudo su
apt-get update
apt-get update --fix-missing
#apt-get install bind9 dnsutils apache2 php5 postfix dovecot-common dovecot-imapd dovecot-pop3d squirrelmail
apt-get install bind9 dnsutils apache2 php5.6 postfix dovecot-core dovecot-imapd dovecot-pop3d squirrelmail

cd /etc/bind
ls -l
nano named.conf.local
# add following code
zone "mark.net" {
  		type master;
        file "/etc/bind/db.mark";
};

zone "0.168.192.in-addr.arpa"{
  		type master;
        file "/etc/bind/db/.192";
};

# cd /etc/bind
cp db.local db.mark
cp db.127 db.192
nano db.mark

```

![Selection_023](/media/tiger/Tiger_Passport/Documents/mailserver/Selection_023.png)

```
nano db.192
```

![Selection_024](/media/tiger/Tiger_Passport/Documents/mailserver/Selection_024.png)

Disconnect the net

```
invoke-rc.d bind9 restart
nslookup mail.mark.net
dig mail.mark.net
cd /etc/apache2/sites-available/
cp default mail
nano mail
```

Add the follow code under "ServerAdmin..."

```
ServerName mail.mark.net
DocumentRoot /usr/share/squirrelmail
```

Change "<Directory..." to

```
<Directory /usr/share/squirrelmail/>
```

```
a2ensite mail
invoke-rc.d apache2 restart
dpkg-reconfigure postfix
```

Set:

```
Local only
System mail name: mail.mark.net
Other destinations to ...:
	add in the head: mail.mark.net
	add in the end:mark.net
Force synchronous updates on mail queue?
	No
Local networks:
	add 192.168.0.0/24 in the end

```

```
nano /etc/squirrelmail/apache.conf
uncomment and ADD:
	DocumentRoot /usr/share/squirrelmail
	ServerName mail.mark.net
	
```

```
nano /etc/dovecot/dovecot.conf
ADD in the end:
	protocols = imap pop3
	# disable_plaintext_auth = no
	mail_location = mbox:~/mail:INBOX=/var/mail/%u
	mail_location = maildir:~/Maildir
```

```
killall named
killall apache2
killall dovecot
```

```
ifconfig eth0 192.168.0.1 netmask 255.255.255.0
ifconfig eth0 up
```

```
invoke-rc.d bind9 restart
invoke-rc.d apache2 restart
invoke-rc.d postfix restart
invoke-rc.d dovecot restart
adduser mark1

```

```
nano /etc/dovecot/dovecot.conf
# comment the last line
mail_location = maildir:~Maildir
# then
invoke-rc.d apache2 restart
invoke-rc.d dovecot restart
```

