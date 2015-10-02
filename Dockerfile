FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install postfix rsyslog && \
    rm -r /var/lib/apt/lists

RUN postconf message_size_limit=26214400

ENV hostname x.st
RUN postconf myhostname=$hostname
RUN postconf mydestination="$hostname, localhost.localdomain, localhost"

ENV aliases /etc/postfix/virtual
RUN postconf -e virtual_alias_maps=hash:$aliases
COPY secret/aliases $aliases
RUN postmap $aliases

CMD service rsyslog start && service postfix start && tail -F /var/log/mail.log
