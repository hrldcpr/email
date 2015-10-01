
## Initial Setup

    sudo cp email.service /etc/systemd/system/
    sudo systemctl enable /etc/systemd/system/email.service

## (Re)building

Enter forwarding addresses in `secret/aliases`, with each line of the form `me@my.domain me123@hotmail.com`

    docker build -t email .
    sudo systemctl restart email.service
