# this seems to be the way to fix all homebrew problems:

sudo chown -R $USER:admin /usr/local
cd /usr/local
git reset --hard origin/master
brew update

via https://github.com/Homebrew/homebrew/issues/19140
