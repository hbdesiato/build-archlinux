FROM desiato/archlinux-bootstrap
COPY build.sh /usr/local/bin/
VOLUME /output
CMD build.sh