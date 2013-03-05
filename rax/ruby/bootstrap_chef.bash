#
# Run as: bash <( curl -L https://raw.github.com/saibaba/devops/master/rax/ruby/bootstrap_chef.bash )
#

RUBY_VERSION="2.0.0-p0"
 
sudo apt-get -y install curl git-core bzip2 build-essential zlib1g-dev libssl-dev autoconf
 
if [ -x /usr/local/rvm/bin/rvm ]; then 
  echo "RVM Found..nothing to do";
else
  echo "Installing RVM";
  curl -L https://get.rvm.io | bash -s stable --ruby
  has_rvm=`groups |grep -c rvm`; 
  if [ "$has_rvm" == "0" ]; then 
    sudo /usr/sbin/usermod -G `groups | tr ' ' ','`,rvm $USER
  fi
fi
 
source /etc/profile
 
has_ruby_version=`rvm list | grep -c $RUBY_VERSION`
if [ $has_ruby_version == "0" ]; then
  rvm install $RUBY_VERSION
  rvm alias create default $RUBY_VERSION
else
  echo "RVM has already installed Ruby $RUBY_VERSION"
fi
 
gem install chef --no-ri --no-rdoc

