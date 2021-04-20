FROM linuxserver/smokeping:latest as release

# Copy in default speedtest probe/target config
COPY conf / /speedtest-conf/

# Install speedtest-cli and it's dependencies
ARG OOKLASPEEDTESTVER=1.0.0
RUN apk add python3 --no-cache \
    && (cd /usr/bin && ln -s python3.8 python) \
    && curl -L -s -S -o /usr/share/perl5/vendor_perl/Smokeping/probes/speedtest.pm https://github.com/mad-ady/smokeping-speedtest/raw/master/speedtest.pm \
    && curl -L -s -S -o /usr/share/perl5/vendor_perl/Smokeping/probes/speedtestcli.pm https://github.com/mad-ady/smokeping-speedtest/raw/master/speedtestcli.pm \
    && curl -L -s -S -o /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py \
    && chmod a+x /usr/local/bin/speedtest-cli \
    && cat /speedtest-conf/Probes >> /defaults/smoke-conf/Probes \
    && cat /speedtest-conf/Targets >> /defaults/smoke-conf/Targets \
    && curl -L -s -S -o /usr/local/bin/ookla-speedtest-$OOKLASPEEDTESTVER-x86_64-linux.tgz https://install.speedtest.net/app/cli/ookla-speedtest-$OOKLASPEEDTESTVER-x86_64-linux.tgz \
    && cd /usr/local/bin/ && tar -zxvf /usr/local/bin/ookla-speedtest-$OOKLASPEEDTESTVER-x86_64-linux.tgz \
    && chmod a+x /usr/local/bin/speedtest

# Build image with tests
FROM alpine:latest as test
COPY --from=release / /
COPY test/ /test
WORKDIR /test
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["./tests.sh"]

FROM release
