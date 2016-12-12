FROM debian:jessie

# Need this for tailing the log:
VOLUME /var/log

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install postfix rsyslog && \
    rm -r /var/lib/apt/lists

RUN postconf message_size_limit=26214400
RUN postconf smtp_tls_security_level=may

ENV hostname x.st
RUN postconf myhostname=$hostname
RUN postconf mydestination="$hostname, localhost.localdomain, localhost"

ENV aliases /etc/postfix/virtual
RUN postconf virtual_alias_maps=hash:$aliases
COPY secret/aliases $aliases
RUN postmap $aliases

CMD service rsyslog start && service postfix start && tail -F /var/log/mail.log
