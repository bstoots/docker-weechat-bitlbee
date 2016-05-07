FROM       ubuntu:14.04
MAINTAINER Brian Stoots <bstoots@gmail.com>

ENV TIMEZONE=America/New_York

RUN apt-get update
RUN apt-get install -y software-properties-common language-pack-en apt-transport-https

# Make latest weechat packages available to apt
# https://weechat.org/download/debian/#instructions
RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
RUN bash -c "echo 'deb https://weechat.org/ubuntu trusty main' > /etc/apt/sources.list.d/weechat.list"
RUN bash -c "echo 'deb-src https://weechat.org/ubuntu trusty main' >> /etc/apt/sources.list.d/weechat.list"
RUN apt-get update

# Make latest bitlbee packages available to apt
# http://code.bitlbee.org/debian/README.html
ADD bitlbee.key /tmp/bitlbee.key
RUN apt-key add /tmp/bitlbee.key
RUN bash -c "echo 'deb http://code.bitlbee.org/debian/master/trusty/amd64 ./' > /etc/apt/sources.list.d/bitlbee.list"
RUN apt-get update

# Welcome to the goodie room
RUN apt-get install -y weechat-curses weechat-plugins bitlbee perl

RUN ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

ADD bitlbee.conf /etc/bitlbee/bitlbee.conf

ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
