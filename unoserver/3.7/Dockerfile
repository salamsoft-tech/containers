FROM alpine:3.24.1

ARG VERSION_UNOSERVER=3.7

WORKDIR /

RUN apk add --no-cache \
    py3-pip \
    libreoffice

# fonts - https://wiki.alpinelinux.org/wiki/Fonts
RUN apk add --no-cache \
    font-noto font-noto-cjk font-noto-extra font-tlwg \
    terminus-font \
    ttf-font-awesome \
    ttf-dejavu \
    ttf-freefont \
    ttf-hack \
    ttf-inconsolata \
    ttf-liberation \
    ttf-mononoki  \
    ttf-opensans   \
    fontconfig && \
    fc-cache -f

# https://github.com/unoconv/unoserver/
RUN pip install --break-system-packages -U unoserver==${VERSION_UNOSERVER}

COPY script/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/data"]
EXPOSE 2003
ENTRYPOINT ["/entrypoint.sh"]
