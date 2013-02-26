# Learn2D

Learn 2D Development with Learn2D.

That's the idea at least. The reality is that Learn2D is pre-alpha software.
It's still under rapid development and not suitable for the general public.
If you're an HTML5 game developer you may find it extremely interesting.
Learn2D is currently looking for additional developers. Please contribute your
code and/or suggestions to the GitHub issue tracker.

Follow along at the [Learn2D Blog](http://learn2d.com/blog/) and join our IRC
channel at #learn2d on irc.freenode.net.

## Installation:

### Install nvm (Node Version Manager)

This isn't strictly required, but it just makes Node.js development easier.

Please refer to the [nvm project on GitHub](https://github.com/creationix/nvm)
for installation instructions. I generally clone the nvm repoistory to my home
folder with the following command:

    git clone git://github.com/creationix/nvm.git ~/.nvm

Then I configure it to start automatically by adding the following to my
`.bashrc` or `.bash_profile`:

    source ~/.nvm/nvm.sh
    [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
    # Automatically activate v0.8.21
    nvm use v0.8.21

### Install Node.js

Using nvm, you can install and activate Node.js version 0.8.21 with the
following commands:

    # Install Node.js v0.8.21
    nvm install v0.8.21
    # Activate Node.js v0.8.21
    nvm use v0.8.21

### Clone Learn2D

We're finally ready to get to the Learn2D-specific stuff. Let's clone the
repository:

    git clone https://github.com/learn2d/learn2d.git
    cd learn2d

### Install Node.js Dependencies

Npm is the package manager distributed with Node.js. The following will install
the Learn2D Node.js dependencies using the package names in `package.json`.

    # CoffeeScript is required as a global package
    npm install -g coffee-script
    # Install npm dependencies into the `node_modules` folder.
    npm install

### Get Bower and install dependencies

Bower is a browser package manager, sort of like npm. It uses the package names
or GitHub repository names in `component.json` to pull down dependencies.

    # Bower package manager is required as a global package
    npm install -g bower
    # Install Bower dependencies into the `components` folder.
    bower install

### Run the server

    ./server/server.sh

### View the application

The application should now be running on http://127.0.0.1:3000/ (the IP will
be different if you're accessing a remote machine). In production, I forward
port 80 and 443 to the application running on port 3000.
