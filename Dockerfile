FROM forumi0721/arch-armhf-base
LABEL maintainer="github.com/razaqq"

# additional files
##################

# add supervisor conf file
ADD build/*.conf /etc/supervisor.conf

# add install bash script
ADD build/root/*.sh /root/

# symlink busybox utilities to /bootstrap folder
RUN ["docker-build-start"]

RUN chmod +x /root/*.sh && \
	/bin/bash /root/install.sh

RUN ["docker-build-end"]

# set environment variables for user nobody
ENV HOME /home/nobody

# set environment variable for terminal
ENV TERM xterm

# set environment variables for language
ENV LANG en_GB.UTF-8

# run
#####

# run tini to manage graceful exit and zombie reaping
ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
