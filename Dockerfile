FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install postfix && \
    rm -r /var/lib/apt/lists

RUN postconf -e message_size_limit=26214400

ENV aliases /etc/aliases_virtual
RUN postconf -e virtual_alias_maps=hash:$aliases
COPY secret/aliases $aliases
RUN postmap $aliases

CMD service postfix start && tail -f /var/log/mail.log
