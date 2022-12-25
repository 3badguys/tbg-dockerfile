# Usage in macos:
# 1. Build image: docker build -f Dockerfile -t chuic456/gitlab:latest .
# 2. Run container: docker run -it --name gitlab --privileged -p 8443:443 -p 8880:80 -p 8822:22 chuic456/gitlab

FROM debian:bullseye
LABEL author=chuic456

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
RUN echo "deb http://mirrors.163.com/debian/ bullseye main non-free contrib" >/etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/debian/ bullseye-proposed-updates main non-free contrib" >>/etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ bullseye main non-free contrib" >>/etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ bullseye-proposed-updates main non-free contrib" >>/etc/apt/sources.list
RUN apt update

RUN apt -y install curl openssh-server ca-certificates
COPY ./_cc_build/script.deb.sh /root/script.deb.sh
RUN bash -x /root/script.deb.sh
RUN apt -y install gitlab-ce

COPY ./init-gitlab.sh /root/init-gitlab.sh
RUN chmod +x /root/init-gitlab.sh
RUN echo "\nif [ -f /root/init-gitlab.sh ]; then bash /root/init-gitlab.sh; fi" >>/root/.bashrc

EXPOSE 443
EXPOSE 80
EXPOSE 22
