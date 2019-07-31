FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3-pip gettext mysql-client
RUN apt-get remove docker docker-engine docker.io && apt install -y docker.io

RUN pip3 install -U awscli

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN apt-get install -y curl
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && mv /tmp/eksctl /usr/local/bin

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

RUN apt-get -y install software-properties-common && add-apt-repository -y ppa:ondrej/php && apt-get update &&  apt-get -y install php7.3 && apt-get install -y php7.3-cli php7.3-fpm php7.3-bcmath php7.3-curl php7.3-gd php7.3-intl php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-sqlite3 php7.3-xml php7.3-zip

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

# Install aws-iam-authenticator
RUN curl -o aws-iam-authenticator curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator && chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

RUN apt-get install -y wget
RUN wget https://getcomposer.org/download/1.8.6/composer.phar && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get install -y nodejs

ENTRYPOINT ["/entrypoint.sh"]
