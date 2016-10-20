FROM kylemanna/openvpn:latest
MAINTAINER Sven van de Scheur <svenvandescheur@gmail.com>

# Add files
ADD files /

# Set entrypoint file
ENTRYPOINT ["/entrypoint.sh"]