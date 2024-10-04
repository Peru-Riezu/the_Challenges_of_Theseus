FROM debian:latest

RUN	apt update && apt upgrade && apt install sudo vim nano man gosu procps -y
RUN	apt clean -y

RUN echo \
     "trap 'mv ~/sarraila ~/ate_irekia; mv ~/helburua ~/heburu_lortua; clear; tput cnorm; ' SIGUSR1" \
     >> /etc/bash.bashrc

COPY	basque/create_users.bash /root/basque/create_users.bash

COPY	create_all_users.bash /root/create_all_users.bash
RUN		chmod 700 /usr/bin/dash /bin/dash

COPY	basque/home/ /home/
RUN     for dir in /home/*; do sudo chown -R $(basename $dir):$(basename $dir) $dir; done
RUN     for dir in /home/*; do sudo chown -R $(basename $dir):$(basename $dir) $dir; done

COPY	basque/user_monitoring_scripts/ /root/basque/user_monitoring_scripts/
COPY	basque/launch_monitors.bash /root/basque/launch_monitors.bash
COPY	launch_all_monitors.bash /root/launch_all_monitors.bash
