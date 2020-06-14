ARG PROGET_VERSION=5.3.3

FROM mono
ARG PROGET_VERSION

RUN set -x \
  && echo $PROGET_VERSION \
  && apt-get update \
  && apt-get install xz-utils \
  && mkdir -p /usr/local/proget \
  && curl -sSL "https://s3.amazonaws.com/cdn.inedo.com/downloads/proget-linux/ProGet.${PROGET_VERSION}.tar.xz" \
  | tar xJC /usr/local/proget

VOLUME /var/proget/packages
VOLUME /var/proget/extensions
VOLUME /usr/share/Inedo/SharedConfig

EXPOSE 80

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]