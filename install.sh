echo "Installing... "

#copy kd.sh and put it in /usr/local/bin
sudo cp kd.sh /usr/local/bin/kd.sh

#add alias to user's .bashrc file for convenience
echo alias kd=\"source kd.sh\" >> ~/.bashrc

echo "Done."

echo "You're all set up."
echo "To use kd, type \"kd\" to navigate around the filesystem easier."
echo "But note that kd won't be runnable in already open terminals."
