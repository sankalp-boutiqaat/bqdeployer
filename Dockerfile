# Specify the base image.
FROM ubuntu:16.04

# Install dependencies.
RUN apt-get update
RUN apt-get install -y curl wget vim git-core

# Install go 1.10
RUN wget https://storage.googleapis.com/golang/go1.10.linux-amd64.tar.gz
RUN tar -xzvf go1.10.linux-amd64.tar.gz
RUN mv go /usr/local
RUN rm -rf go1.10.linux-amd64.tar.gz

# Install ansible
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible bzip2 cowsay

# Copy required files
COPY ./.bash_aliases /root/.bash_aliases
COPY ./deployer /root/bin/deployer
COPY ./ansible /opt/ansible
COPY ./etc/ansible /etc/ansible
COPY ./helper helper
RUN chmod +x helper && ./helper

# Configure getsetgo cli
RUN /usr/local/go/bin/go get -u github.com/BoutiqaatREPO/getsetgo/getsetgo
RUN mv /root/go/bin/getsetgo /root/bin/getsetgo 
