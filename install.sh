echo "Installing... "

#copy els.sh and put it in /usr/local/bin
sudo cp els.sh /usr/local/bin/els.sh

#add alias to user's .bash_profile file for conveniance
echo alias els=\". els.sh\" >> ~/.bash_profile

echo "Done."

echo "You're all set up."
echo "But note that els won't be runnable in already open terminals."
echo "To use, type \"els\" to navigate around the filesystem better. It's like \"ls\" but easier."
