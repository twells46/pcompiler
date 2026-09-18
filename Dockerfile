FROM debian:13.6

RUN dpkg --add-architecture arm64 \
    && apt update \
    && apt install -y \
        cmake \
        g++-aarch64-linux-gnu \
        gcc-aarch64-linux-gnu \
        make \
        qt6-base-dev:arm64 \
        wget \
    && rm -rf /var/lib/apt/lists/*

# TODO Don't hardcode
RUN wget 'https://github.com/twells46/libkar/releases/download/v1.0.1/libkar-1.0.1-Linux.deb' \
    && printf 'b925d91433a08cd38d90bb4dfc9cb765e143f45ec7b6c87f177d1b82b16a1ebd libkar-1.0.1-Linux.deb' > libkar.CHECKSUM \
    && sha256sum -c libkar.CHECKSUM \
    && apt install ./libkar-1.0.1-Linux.deb \
    && rm libkar-1.0.1-Linux.deb libkar.CHECKSUM

RUN groupadd --gid 1000 kipr \
    && useradd --uid 1000 --gid 1000 kipr

USER kipr:kipr