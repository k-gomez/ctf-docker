# docker build -t ctf:ubuntu19.10 .
# If using Windows
      # docker run --rm -v %cd%:/pwd --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d --name ctf -i ctf:ubuntu19.10
# If using Linux    
      # docker run --rm -v $PWD:/pwd --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d --name ctf -i ctf:ubuntu19.10
# docker exec -it ctf /bin/bash

FROM ubuntu:22.04
ENV LC_CTYPE C.UTF-8

# apt and dpkg packages
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy \
    sudo \
    git \
    nasm \
    build-essential \
    jq \
    strace \
    ltrace \
    dnsutils \
    python3 python3-dev python3-pip python3-setuptools \
    libc6-dbg \
    libc6-dbg:i386 \
    gcc-multilib \
    gdb \
    gdb-multiarch \
    zsh \
    qemu-user \
    qemu-system \
    gcc \
    wget \
    curl \
    vim \
    glibc-source \
    cmake \
    python3-capstone \
    socat \
    netcat \
    net-tools \
    ruby-dev \
    rubygems \
    cpio \
    liblzo2-dev \
    telnet \
    squashfs-tools \
    libgmp3-dev \ 
    libmpc-dev \
    exiftool && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    cd ~ && tar -xf /usr/src/glibc/glib*.tar.xz


# pip packages
RUN pip install capstone requests pwntools r2pipe && \
    pip3 install pwntools keystone-engine unicorn capstone ropper

# install binwalk
RUN cd ~ && git clone https://github.com/ReFirmLabs/binwalk.git && \
    cd ~/binwalk && \
    python3 setup.py install

# build radare2
RUN git clone https://github.com/radareorg/radare2  && \
    sh -c radare2/sys/install.sh

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    sed -i 's/robbyrussell/ys/g' /root/.zshrc

# RsaCtfTool
RUN git clone https://github.com/Ganapati/RsaCtfTool.git && \
    cd RsaCtfTool && \
    pip3 install -r "requirements.txt"

# sleuthkit
RUN git clone https://github.com/sleuthkit/sleuthkit.git
RUN cd /sleuthkit && ./bootstrap && ./configure && make && make install


CMD ["/bin/zsh"]
