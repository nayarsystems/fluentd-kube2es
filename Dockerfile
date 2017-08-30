FROM fluent/fluentd:v0.12-debian
MAINTAINER Jaime <jbreva@nayarsystems.com>

USER root

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo gem install \
        fluent-plugin-elasticsearch fluent-plugin-parser fluent-plugin-record-reformer fluent-plugin-systemd\
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem
           
           
COPY fluent.conf /fluentd/etc/fluent.conf

ENTRYPOINT ["/usr/local/bin/fluentd"]
CMD ["-c", "/fluentd/etc/fluent.conf"]