docker build -f Dockerfile -t chuic456/emacs:latest .

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip

docker run -it --name emacs --privileged -e DISPLAY=$ip:0 -v /tmp/.X11-unix:/tmp/.X11-unix chuic456/emacs &

