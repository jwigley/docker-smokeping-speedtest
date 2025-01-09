FROM linuxserver/smokeping:latest AS release

ARG OOKLA_SPEEDTEST_VERSION=1.2.0

# Copy in default speedtest probe/target config
COPY conf / /speedtest-conf/

# Install speedtest (ookla), speedtest-cli and it's dependencies
RUN apk add python3 --no-cache \
    && curl -L -s -S -o /usr/share/smokeping/Smokeping/probes/SSH.pm https://github.com/oetiker/SmokePing/raw/master/lib/Smokeping/probes/SSH.pm \
    && sed -i 's/127.0.0.1/$ENV{SSH_PROBE_INIT_TARGET}/g' /usr/share/smokeping/Smokeping/probes/SSH.pm \
    && curl -L -s -S -o /usr/share/smokeping/Smokeping/probes/speedtest.pm https://github.com/mad-ady/smokeping-speedtest/raw/master/speedtest.pm \
    &&  curl -L -s -S -o /usr/share/smokeping/Smokeping/probes/speedtestcli.pm https://github.com/mad-ady/smokeping-speedtest/raw/master/speedtestcli.pm \
    && curl -L -s -S -o /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py \
    && chmod a+x /usr/local/bin/speedtest-cli \
    && curl -L -s -S -o ookla-speedtest-${OOKLA_SPEEDTEST_VERSION}-x86_64-linux.tgz https://install.speedtest.net/app/cli/ookla-speedtest-${OOKLA_SPEEDTEST_VERSION}-linux-x86_64.tgz \
    && tar -zxvf ookla-speedtest-${OOKLA_SPEEDTEST_VERSION}-x86_64-linux.tgz -C /usr/local/bin/ \
    && chmod a+x /usr/local/bin/speedtest \
    && cat /speedtest-conf/Probes >> /defaults/smoke-conf/Probes \
    && cat /speedtest-conf/Targets >> /defaults/smoke-conf/Targets

# Build image with tests
FROM release AS test
COPY test/ /test
WORKDIR /test
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["./tests.sh"]

FROM release
