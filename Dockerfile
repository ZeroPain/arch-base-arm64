FROM agners/archlinuxarm-arm64v8
LABEL maintainer="github.com/zeropain"

# additional files
##################

# add supervisor conf file
ADD build/*.conf /etc/supervisor.conf

# add install bash script
ADD build/root/*.sh /root/

RUN chmod +x /root/*.sh && \
	/bin/bash /root/install.sh

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
