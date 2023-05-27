FROM linuxserver/smokeping:latest AS release

# Copy in default speedtest probe/target config
COPY conf / /speedtest-conf/

# Install speedtest-cli and it's dependencies
RUN apk add python3 --no-cache \
    && curl -L -s -S -o /usr/share/smokeping/Smokeping/probes/SSH.pm https://github.com/oetiker/SmokePing/raw/master/lib/Smokeping/probes/SSH.pm \
    && sed -i 's/127.0.0.1/$ENV{SSH_PROBE_INIT_TARGET}/g' /usr/share/smokeping/Smokeping/probes/SSH.pm \
    && curl -L -s -S -o /usr/share/smokeping/Smokeping/probes/speedtest.pm https://github.com/mad-ady/smokeping-speedtest/raw/master/speedtest.pm \
    && curl -L -s -S -o /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py \
    && chmod a+x /usr/local/bin/speedtest-cli \
    && cat /speedtest-conf/Probes >> /defaults/smoke-conf/Probes \
    && cat /speedtest-conf/Targets >> /defaults/smoke-conf/Targets

# Build image with tests
FROM alpine:latest AS test
COPY --from=release / /
COPY test/ /test
WORKDIR /test
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["./tests.sh"]

FROM release
