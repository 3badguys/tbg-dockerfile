# Usage in macos:
# 1. Build image: docker build -f Dockerfile -t chuic456/emacs:latest .
# 2. Install XQuartz, download link: https://www.xquartz.org/
# 3. Before run container, start XQuartz and run: xhost +
# 4. Run container: docker run -it --name emacs --privileged -e DISPLAY=$ip:0 -v /tmp/.X11-unix:/tmp/.X11-unix chuic456/emacs

FROM debian:bullseye
LABEL author=chuic456

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
RUN echo "deb http://mirrors.163.com/debian/ bullseye main non-free contrib" >/etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/debian/ bullseye-proposed-updates main non-free contrib" >>/etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ bullseye main non-free contrib" >>/etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ bullseye-proposed-updates main non-free contrib" >>/etc/apt/sources.list
RUN apt update

RUN apt -y build-dep emacs
RUN apt -y install libgccjit0 libgccjit-10-dev

COPY ./_cc_build/emacs /root/emacs
RUN cd /root/emacs/ && ./autogen.sh && ./configure --with-pop --with-mailutils --with-native-compilation && make -j$(nproc) && make install

RUN rm -rf /root/.emacs.d
COPY ./_cc_build/.emacs.d /root/.emacs.d
COPY ./_cc_build/xah-fly-keys /root/.emacs.d/site-lisp/xah-fly-keys
COPY ./_cc_build/xah-elisp-mode /root/.emacs.d/site-lisp/xah-elisp-mode

ENTRYPOINT ["emacs"]
