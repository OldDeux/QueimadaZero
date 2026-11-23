# Ambiente de desenvolvimento Flutter do QueimadaZero.
# A versão acompanha a usada para criar o projeto em app/ (Dart ^3.13.7).
FROM debian:bookworm-slim

ARG FLUTTER_VERSION=3.47.9
ARG FLUTTER_SHA256=25ed8c3c29d51a7353f2a944310b478af8214920639524b19c50a19e6c044c5a

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates curl git unzip xz-utils zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /tmp/flutter.tar.xz \
       "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
    && echo "${FLUTTER_SHA256}  /tmp/flutter.tar.xz" | sha256sum -c - \
    && tar -xJf /tmp/flutter.tar.xz -C /opt \
    && rm /tmp/flutter.tar.xz

ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}" \
    PUB_CACHE=/root/.pub-cache

RUN git config --global --add safe.directory '*' \
    && flutter config --no-analytics --no-cli-animations \
    && dart --disable-analytics \
    && flutter precache --web --no-android --no-ios --no-linux --no-windows --no-macos \
    && flutter --version

WORKDIR /workspace/app

ENTRYPOINT ["flutter"]
CMD ["--version"]
