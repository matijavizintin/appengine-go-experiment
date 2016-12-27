#!/bin/bash

rm router
GOOS=linux GOARCH=arm go build router.go
ssh pi@raspberry 'kill -15 $(ps -C "router" -o pid=)'
scp router pi@raspberry:redirector
ssh pi@raspberry "sh -c 'cd redirector; nohup ./router > /dev/null 2>&1 &'"
