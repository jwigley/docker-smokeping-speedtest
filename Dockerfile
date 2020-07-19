FROM linuxserver/smokeping:latest

# Install speedtest-cli and it's dependencies
RUN apk add python3 --no-cache \
    && (cd /usr/bin && ln -s python3.8 python) \
    && curl -L -s -S -o /usr/share/perl5/vendor_perl/Smokeping/probes/speedtest.pm https://github.com/mad-ady/smokeping-speedtest/raw/master/speedtest.pm \
    && curl -L -s -S -o /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py \
    && chmod a+x /usr/local/bin/speedtest-cli
