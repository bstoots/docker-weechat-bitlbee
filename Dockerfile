FROM       ubuntu:14.04
MAINTAINER Brian Stoots <bstoots@gmail.com>

ENV TIMEZONE=America/New_York
ENV WEECHAT_USER=weechat
ENV WEECHAT_HOME=/weechat
ENV WEECHAT_UID=1000
ENV WEECHAT_GID=1000

# Come correct with a timezone
RUN ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
# Set locale UTF-8 for mosh
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get update
RUN apt-get install -y software-properties-common language-pack-en apt-transport-https

# Make latest bitlbee packages available to apt
# http://code.bitlbee.org/debian/README.html
ADD bitlbee.key /tmp/bitlbee.key
RUN apt-key add /tmp/bitlbee.key
RUN bash -c "echo 'deb http://code.bitlbee.org/debian/master/trusty/amd64 ./' > /etc/apt/sources.list.d/bitlbee.list"
RUN apt-get update

# Make latest weechat packages available to apt
# https://weechat.org/download/debian/#instructions
RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
RUN bash -c "echo 'deb https://weechat.org/ubuntu trusty main' > /etc/apt/sources.list.d/weechat.list"
RUN bash -c "echo 'deb-src https://weechat.org/ubuntu trusty main' >> /etc/apt/sources.list.d/weechat.list"
RUN apt-get update

# Make latest mosh packages available to apt
# https://launchpad.net/~keithw/+archive/ubuntu/mosh-dev
RUN add-apt-repository ppa:keithw/mosh-dev
RUN apt-get update

# Welcome to the goodie room
RUN apt-get install -y bitlbee weechat-curses weechat-plugins mosh perl

# Configure users and groups
RUN addgroup --gid $WEECHAT_GID $WEECHAT_USER 
RUN adduser  --uid $WEECHAT_UID --gid $WEECHAT_GID $WEECHAT_USER --home $WEECHAT_HOME --no-create-home --disabled-password --gecos '' 

# Configure bitlbee
ADD bitlbee.conf /etc/bitlbee/bitlbee.conf
RUN mkdir -p $WEECHAT_HOME/bitlbee
RUN chmod 700 $WEECHAT_HOME/bitlbee
RUN chown -R $WEECHAT_USER:$WEECHAT_USER $WEECHAT_HOME
VOLUME [$WEECHAT_HOME]

# Configure weechat

# Configure mosh

ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
