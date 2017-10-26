#Configure password-less ssh login using rsa keys.

#https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2
if ! ssh-keygen -t rsa; then
    echo "Failed to create keys. Exiting..."
    exit
fi

echo -en "Enter your psu id:\n>"
read user

if ! ssh-copy-id "$user@ada.hbg.psu.edu"; then
    echo "Could not configure keys on $user@ada.hbg.psu.edu"
    exit
fi

mkdir ~/bin > /dev/null 2&>1

#configure the script. no args -> default connection to ada.
echo "server=\"\$1\"

if (( \$# < 1 )); then
    echo \"Connecting to ada.hbg.psu.edu...\"
    ssh $user@ada.hbg.psu.edu
else
    echo \"Connecting to \$server.hbg.psu.edu\"
    ssh $user@\$server.hbg.psu.edu
fi" > ~/bin/sunlab

chmod 755 ~/bin/sunlab

echo "You can add host keys now by providing a file containing the hosts."
echo "You do not need to do this now. You can do it later by executing"
echo "$ ./add_host_keys.sh <host file>"
echo -n "Do you have a you have a hosts file ready now? (y/n): "

read choice
if [[ ${choice:0:1} =~ [yY] ]]; then
	echo -n "Filename: "
	read filename

	./add_host_keys.sh "$filename" 
fi 

echo "sunlab script setup finished!"
echo "Usage: $ sunlab <server>"
echo -e "Example: sunlab dijkstra\n"
