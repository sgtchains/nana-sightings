#!/bin/bash

useradd nanas

cd ~
rm -rf /tmp/verimod

perl -e "use Mail::Mbox::MessageParser;" || 
  yum install perl-Mail-Mbox-MessageParser
perl -e "use CPAN;" || 
  yum install perl-CPAN

mkdir /tmp/verimod
cd /tmp/verimod

perl -e "use MIME::Lite;" || 
  perl -MCPAN -e "install MIME::Lite"

perl -e "use News::Overview;" ||
  perl -MCPAN -e "install News::Overview"

perl -e "use PGP::Sign;" ||
  perl -MCPAN -e "install PGP::Sign"

perl -e "use News::Newsrc;" || 
  perl -MCPAN -e "install News::Newsrc"

perl -e "use News::Article::NoCeM;" ||
  perl -MCPAN -e "install News::Article::NoCeM"

ls /usr/local/bin/perl || 
  ln -s /usr/bin/perl /usr/local/bin/perl


git clone git://github.com/sgtchains/nana-sightings.git

mkdir ~nanas/lib
cd ~nanas/lib
tar -zxvf /tmp/verimod/nana-sightings/News-Gateway-0.43.tgz
chown -R nanas:nanas ~nanas/lib

cd ~nanas
tar -zxvf /tmp/verimod/nana-sightings/dot-verimod.tgz
chown -R nanas:nanas ~nanas/.verimod

cp /tmp/verimod/nana-sightings/dot-verimodrc.example ~nanas/.verimodrc
chown nanas:nanas ~nanas/.verimodrc

mkdir ~nanas/bin
cp /tmp/verimod/nana-sightings/nanas.sh.example ~nanas/bin/nanas
chown -R nanas:nanas ~nanas/bin

cd /tmp/verimod/nana-sightings/

for foo in *.tar.gz ; do tar -zxvf $foo ; done

patch -p0 <News-Archive-0.14.5.patch

cd "News-Archive-0.14.5" 
perl Makefile.PL
make
make test
make install
cd ..

exit 

cd pgpmoose-2.00
perl Makefile.PL
make
make test
make install
cd ..

cd verimod 
perl Makefile.PL
make
make test
make install
cd ..


