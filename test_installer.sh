#!/bin/sh
find /usr/local/git > install_contents_before.txt
echo "Testing..."
sudo rm /etc/paths.d/git
sudo rm /etc/manpaths.d/git
sudo rm -rf /usr/local/git

echo "OK - running the installer. Come back and press a key when you're done."
open Disk\ Image/git*.pkg 

read -n 1

for file in /etc/paths.d/git /etc/manpaths.d/git /usr/local/git/bin/git "/usr/local/git/share/git-gui/lib/Git Gui.app/Contents/Info.plist"; do
  printf "'$file'"
  if [ -f "$file" ]; then
    echo " - exists"
  else
    echo " DOES NOT EXIST!"
    echo "FAIL FAIL FAIL ALL CAPS FAT KID IN DODGE BALL FAIL"
    exit 1
  fi
done

find /usr/local/git > install_contents_after.txt

install_diff=$(diff install_contents_before.txt install_contents_after.txt)
if [ "$install_diff" == "" ]; then
  echo "No files went missing!"
else
  echo "A FEW FILES WENT MISSING!
$install_diff"
  exit 1
fi
echo "Success!"

