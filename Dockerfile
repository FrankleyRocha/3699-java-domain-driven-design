FROM ubuntu:24.04
SHELL ["/bin/bash", "-ic"]

RUN apt update

#pacotes essenciais
RUN apt install -y \
    vim \
    wget \
    curl \
    git \
    sudo \
    build-essential \
    zip unzip

#configuração de locale
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen pt_BR.UTF-8 && \
    update-locale LANG=pt_BR.UTF-8

ENV LANG=pt_BR.UTF-8
ENV LC_ALL=pt_BR.UTF-8

#necessario para o python
#RUN apt install -y \
#    zlib1g-dev \
#    libncurses5-dev \
#    libgdbm-dev \
#    libnss3-dev \
#    libssl-dev \
#    libreadline-dev \
#    libffi-dev \
#    libbz2-dev \
#    libsqlite3-dev \
#    liblzma-dev \
#	python3-tk \
#    tk-dev

#opcional docker
#RUN apt install -y \
#    docker.io \
#    docker-compose

#opcional fontes microsoft
#RUN apt install -y \
#    ttf-mscorefonts-installer

#opcional necessario para executar eclipse
#RUN apt install -y \
#    libswt-gtk-4-java

# remove the user ubuntu
RUN deluser ubuntu

ARG USERNAME=toolbox
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --create-home --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

WORKDIR /home/toolbox

RUN curl -s "https://get.sdkman.io" | bash

#RUN curl https://pyenv.run | bash
#RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
#RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
#RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

RUN sdk install java 17.0.15-tem
RUN sdk install maven

#RUN pyenv install 3.13
#RUN pyenv global 3

#RUN nvm install 22

#RUN npm install -g @angular/cli
#RUN npm i -g @ionic/cli
