#!/bin/bash

set -e

failure(){
    echo "Error occured at line number: $1, error command: $2"
}

trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
       echo -e "$2...$R FAILURE $N"
       exit 2
    else
       echo -e "$2...$G SUCCESS $N"
    fi
}

check_root(){
    if [ $USERID -ne 0 ]
    then
        echo "Please run this script with root access."
        exit 1 # manually exit if error comes.
    else
        echo "You are super user."
    fi
}