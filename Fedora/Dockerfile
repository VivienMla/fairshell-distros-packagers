FROM fedora

LABEL maintainer="vmalerba@gmail.com"

ARG http_proxy=
ARG https_proxy=

COPY install.sh build.sh /
RUN /install.sh

ENTRYPOINT ["/build.sh"]
