#
#
#
FROM alpine:3.6

RUN apk add         \
    --update        \
    --no-cache      \
    ca-certificates \
    bash            \
    perl            \
    python          \
    python-dev      \
    py-pip          \
    openssl-dev     \
    build-base      \
    git

RUN pip install tlslite six

RUN git clone https://github.com/PeterMosmans/openssl.git --depth 1 -b 1.0.2-chacha && \
    cd openssl && \
    ./Configure zlib no-shared experimental-jpake enable-md2 enable-rc5 \
    enable-rfc3779 enable-gost enable-static-engine linux-x86_64 && \
    make depend && make && make install && \
    cd / && rm -rf openssl

RUN cd / && \
    git clone https://github.com/mozilla/cipherscan cipherscan &&  \
    cd /cipherscan && \
    rm -rf .git && \
    ln -s /usr/local/ssl/bin/openssl /cipherscan/openssl && \
    ./openssl version && \
    ./cipherscan firefox.com:443

RUN apk del     \
    python-dev  \
    openssl-dev \
    build-base  \
    git

WORKDIR /cipherscan

# ENTRYPOINT [ "./cipherscan" ]