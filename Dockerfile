FROM fluent/fluentd:latest
MAINTAINER Jaime <jbreva@nayarsystems.com>
RUN gem install fluent-plugin-elasticsearch fluent-plugin-parser fluent-plugin-record-reformer
COPY fluent.conf /fluentd/etc/fluent.conf
USER root
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT

