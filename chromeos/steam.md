# To install steam on crostini
1. add `deb http://httpredir.debian.org/debian/ jessie main contrib non-free` to eg. /etc/apt/sources.list.d/nonfree.list
2. sudo dpkg --add-architecture i386
3. sudo apt update
4. sudo apt install steam

Then run it with:
GDK\_SCALE=2 steam (doesn't actually work though, app still unreadably small)

Can right click on its icon in the bar and choose "low density"

And to run Stardew Valley (say) you have to run steam with "export TERM=xterm" I'M NOT KIDDING.

# remapping controls of steam games
https://gaming.stackexchange.com/questions/42498/is-it-possible-to-edit-the-keybindings-in-super-meat-boy

# installing zdoom
sudo apt-get install software-properties-common
wget -O- https://debian.drdteam.org/drdteam.gpg | sudo apt-key add -
sudo apt-add-repository 'deb https://debian.drdteam.org/ stable multiverse'
