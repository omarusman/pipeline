FROM ubuntu:18.04

RUN apt-get update && apt-get install -y python3-pip 
RUN apt-get remove docker docker-engine docker.io && apt install -y docker.io

RUN pip3 install -U awscli

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
