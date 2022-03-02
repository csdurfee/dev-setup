#!/usr/bin/env bash

# ~/pydata.sh

# Removed user's cached credentials
# This script might be run with .dots, which uses elevated privileges
sudo -K

echo "-------------------------------"
echo "setting up python3 as default"


## this ^^^ needs to be set up before the virtualenvwrapper stuff will work right

echo "------------------------------"
echo "Setting up pip."

# Install pip
easy_install pip
#brew install brew-pip
## this assumes 'python' is aliased to the version of python you want to use.
/usr/local/opt/python@3.9/bin/python3.9 -m pip install --upgrade pip
# I don't know why this isn't done by default. maybe there is a good reason.
ln -s /usr/local/bin/pip3 /usr/local/bin/pip


###############################################################################
# Virtual Enviroments                                                         #
###############################################################################

echo "------------------------------"
echo "Setting up virtual environments."

# Install virtual environments globally
# It fails to install virtualenv if PIP_REQUIRE_VIRTUALENV was true
export PIP_REQUIRE_VIRTUALENV=false
pip install virtualenv
pip install virtualenvwrapper

echo "------------------------------"
echo "Source virtualenvwrapper from ~/.extra"

EXTRA_PATH=~/.extra
echo $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
echo "source /usr/local/bin/virtualenvwrapper.sh" >> $EXTRA_PATH
echo "" >> $BASH_PROFILE_PATH
source $EXTRA_PATH

# ###############################################################################
# # Python 2 Virtual Enviroment                                                 #
# ###############################################################################

# echo "------------------------------"
# echo "Setting up py2-data virtual environment."

# # Create a Python2 data environment
# mkvirtualenv py2-data
# workon py2-data

# # Install Python data modules
# pip install numpy
# pip install scipy
# pip install matplotlib
# pip install pandas
# pip install sympy
# pip install nose
# pip install unittest2
# pip install seaborn
# pip install scikit-learn
# pip install "ipython[all]"
# pip install bokeh
# pip install Flask
# pip install sqlalchemy
# pip install mysql-python

###############################################################################
# Python 3 Virtual Enviroment                                                 #
###############################################################################

echo "------------------------------"
echo "Setting up py3-data virtual environment."

# Create a Python3 data environment
mkvirtualenv --python=/usr/local/bin/python3 py3-data
workon py3-data

# Install Python data modules
pip install numpy
pip install scipy
pip install matplotlib
pip install pandas
pip install sympy
pip install nose
pip install unittest2
pip install seaborn
pip install scikit-learn
pip install "ipython[all]"
pip install ipykernel
pip install bokeh
pip install Flask
pip install sqlalchemy
#pip install mysql-python  # Python 2 only, use mysqlclient instead
pip install mysqlclient

# necessary for Excel support in pandas
pip install openpyxl

###############################################################################
# Install IPython Profile
###############################################################################

echo "------------------------------"
echo "Installing IPython Notebook Default Profile"

# Add the IPython profile
mkdir -p ~/.ipython
cp -r init/profile_default/ ~/.ipython/profile_default

echo "-------------------------------"
echo "Installing r language"
brew install r
brew install pandoc # for R Markdown
brew install librsvg 
brew install homebrew/cask/basictex

echo "installing jupyter"
brew install jupyter

echo "this is where we would run install_r_packages.r"
echo "but I need to figure out how to auto-select a particular FTP server."

echo "------------------------------"
echo "Script completed."
echo "Usage: workon py2-data for Python2"
echo "Usage: workon py3-data for Python3"


echo "install oh-my-zsh" # TODO: move this
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"