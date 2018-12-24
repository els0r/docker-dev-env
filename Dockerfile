FROM debian:buster-slim

# Locales
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get update && apt-get install -y apt-utils dialog && apt-get install -y locales tzdata
#RUN locale-gen --purge en_US.UTF-8
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

#RUN echo "Europe/Zurich" > /etc/timezone && \
#    dpkg-reconfigure -f noninteractive tzdata && \
#    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
#    dpkg-reconfigure --frontend=noninteractive locales && \
#    update-locale LANG=en_US.UTF-8

# Colors and italics for tmux
COPY xterm-256color-italic.terminfo /root/
RUN tic /root/xterm-256color-italic.terminfo
ENV TERM=xterm-256color-italic

# Common packages
RUN apt-get update && apt-get install -y \
      git  \
      wget \
      zsh

# install git dotfiles
COPY dotfiles/*.git* /root/

# install zsh
WORKDIR /root/
RUN wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh || true

COPY dotfiles/lel.zsh-theme /root/.oh-my-zsh/themes/
COPY dotfiles/.zshrc /root/

# Install go
RUN wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz && tar xf go1.11.4.linux-amd64.tar.gz -C /usr/local/ && rm -rf go1.11.4.linux-amd64.tar.gz
RUN mkdir -p /home/code/go

RUN apt-get update && apt-get install -y \
      curl \
      htop \
      tmux \
      vim

# install vim and vim-go
COPY dotfiles/.vim /root/
COPY dotfiles/.vimrc /root/

WORKDIR /usr/local/src
RUN git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go

# Install docker
RUN apt-get install -y \
     apt-transport-https \
     ca-certificates \
     gnupg2 \
     software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" &&\
   apt-get update &&\
   apt-get install -y docker-ce
RUN curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.32.0/docker-compose-$(uname -s)-$(uname -m)" &&\
    chmod +x /usr/local/bin/docker-compose

# Install build packages
RUN apt-get update && apt-get install -y \
      build-essential \
      iputils-ping \
      jq \
      net-tools \
      libncurses5-dev \
      libevent-dev \
      netcat-openbsd \
      socat

# Install tmux
WORKDIR /usr/local/src
RUN wget https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz
RUN tar xzvf tmux-2.5.tar.gz
WORKDIR /usr/local/src/tmux-2.5
RUN ./configure
RUN make
RUN make install
RUN rm -rf /usr/local/src/tmux*

