FROM debian:bullseye-slim

LABEL maintainer="vmalerba@gmail.com"

COPY install.sh build.sh /
RUN /install.sh

ENTRYPOINT ["/build.sh"]
