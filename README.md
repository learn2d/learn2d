Learn2D
=======

Learn 2D game development in 2 days with Learn2D

Installation:
=============

**First get Node**

*  https://github.com/joyent/node/wiki/Installation
*  https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager

**Get npm**

*  sudo curl https://npmjs.org/install.sh | sudo sh

**Get nvm and switch to node 0.6.20:**

*  You could clone it to ~/nvm
*  cd ~
*  git clone git://github.com/creationix/nvm.git

**Configure it:**

*  In .bashrc and/or .profile, add the next 3 lines
  *  . ~/nvm/nvm.sh
  *  [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
  *  nvm use v0.8.17

*  cd /path/to/learn2d
*  nvm install v0.8.17
  *  should say
  *  Now using node v0.8.17
*  nvm use v0.8.17
*  node -v
  *  should say
  *  v0.8.17

**In the Learn2D clone directory:**

*  npm install

**Get coffee-script:**

*  npm install -g coffee-script

**Run Learn2D with:**

*  ./server/server.sh

**Port Forwarding**

*  [local host](http://192.168.1.1/)
*  forward ports 3000 and 3001 to your machine

License
=======

CC0