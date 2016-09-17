## Installation Instruction

- [root] $ apt-get autoremove

- [root] $ whereis ruby

- [root] $ apt-get install build-essential zlib1g zlib1g-dev libreadline6 libreadline6-dev libssl-dev

- [root] $\curl -L https://get.rvm.io | bash -s -- --ignore-dotfiles --autolibs=0 --ruby

- [root] $ source /etc/profile.d/rvm.sh 

- [root] $ type rvm | head -n 1 

- [root] $ ruby -v 

- [root] $ rvm gemset use global 

- [root] $ gem outdated 

- [root] $ gem update 

- [root] $ echo “gem: –no-document” >> ~/.gemrc 

- [root] $ rvm use ruby-2.3.1@rails5.0 --create 

- [root] $ gem install rails 

- [root] $ rails -v 

- [root] $ apt-get install libxslt-dev libxml2-dev libpq-dev

- [root] $ sudo apt-get install sqlite3 libsqlite3-dev 

- [root] $ gem install sqlite3

- [root] $ rvm use ruby-2.3.1@rails5.0

- [root] $ nano ~/.irbrc [+] IRB.conf[:PROMPT_MODE] = :SIMPLE

- [root] $ nano /etc/modprobe.d/blacklist-libnfc.conf [+] blacklist intel_rapl