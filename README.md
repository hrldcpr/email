Enter forwarding addresses in `secret/aliases`, with each line of the form `me@my.domain me123@hotmail.com`

    docker build --tag email .
    docker run --name email --publish 25:25 --publish 465:465 --publish 587:587 --restart always --detach email
