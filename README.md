virtualenv-auto-activate.sh
===========================

Automatically source your Python virtualenv when you enter a directory. In your project root, name your virutal environement .venv, and this script will automatically source it for you when you enter into that directory.

## Install ##
 * Clone the project into a .bash dir in your home directory
 * Open your ~/.profile or ~/.bash_profile
 * Add the line: ``` source ~/.bash/virtualenv-auto-activate.sh ```
 * cd to your project's home directory and create a virtual environment called .venv
 * ``` $ virtualenv .venv ```
 * Or you can symlink your virtual environment to your project folder, as long as it is called .venv


