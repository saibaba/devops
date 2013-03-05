DEFAULT_RUBY_VERSION="2.0.0-p0"
 
sudo apt-get -y install curl git-core bzip2 build-essential zlib1g-dev libssl-dev autoconf
 
if [ -x /usr/local/rvm/bin/rvm ]; then 
  echo "RVM Found..nothing to do";
else
  echo "Installing RVM";
  
  curl -o /tmp/rvm-installer -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer
  chmod +x /tmp/rvm-installer
  sudo /tmp/rvm-installer stable
  has_rvm=`groups |grep -c rvm`; 
  if [ "$has_rvm" == "0" ]; then 
    sudo /usr/sbin/usermod -G `groups | tr ' ' ','`,rvm $USER
  fi
fi
 
source /etc/profile
 
has_ruby_version=`rvm list | grep -c $DEFAULT_RUBY_VERSION`
if [ $has_ruby_version == "0" ]; then
  rvm install $DEFAULT_RUBY_VERSION
  # rvm system ; rvm gemset export system.gems ; rvm $DEFAULT_RUBY_VERSION; rvm gemset import system.gems
  rvm alias create default $DEFAULT_RUBY_VERSION
else
  echo "RVM has already installed Ruby v$DEFAULT_RUBY_VERSION"
fi
 
gem install chef --no-ri --no-rdoc

