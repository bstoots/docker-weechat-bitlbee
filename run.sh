#!/bin/bash

mosh --version
mosh-server new -v

# echo "Starting bitblee"
# su - $WEECHAT_USER -c "/usr/sbin/bitlbee"
# echo "Waiting for bitblee to start."
# sleep 2

# echo "Starting weechat"
# su - $WEECHAT_USER -c "LC_ALL=en_US.utf8 TERM=xterm-256color weechat irc://localhost"

# echo "Killing bitblee"
# pkill bitlbee
# echo "Waiting for bitblee to end"
# sleep 2
