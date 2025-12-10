
# Convert Your Script to Unix Format
sudo apt-get install dos2unix -y
dos2unix *.sh

# Make Git Automatically Fix Line Endings
git config --global core.autocrlf false
git config --global core.eol lf

# Add a .gitattributes file
*.sh text eol=lf

