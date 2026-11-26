# Ambiente de desenvolvimento Flutter do QueimadaZero.
# A versão acompanha a usada para criar o projeto em app/ (Dart ^3.13.7).
FROM debian:bookworm-slim AS flutter-base

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

# Imagem separada para compilar APKs, sem aumentar a imagem usada para Web/testes.
FROM flutter-base AS android

RUN apt-get update \
    && apt-get install -y --no-install-recommends openjdk-17-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64 \
    ANDROID_HOME=/opt/android-sdk \
    ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH="${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${PATH}"

# Android Command-line Tools oficiais, com hash publicado pelo Google.
ARG ANDROID_TOOLS_VERSION=15859902
ARG ANDROID_TOOLS_SHA256=4e4c464f145a7512b57d088ac6c278c03c9eea610886b35a5e0804e74eedf583
RUN curl -fsSL -o /tmp/android-tools.zip \
       "https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_TOOLS_VERSION}_latest.zip" \
    && echo "${ANDROID_TOOLS_SHA256}  /tmp/android-tools.zip" | sha256sum -c - \
    && mkdir -p "${ANDROID_HOME}/cmdline-tools/latest" /tmp/android-tools \
    && unzip -q /tmp/android-tools.zip -d /tmp/android-tools \
    && mv /tmp/android-tools/cmdline-tools/* "${ANDROID_HOME}/cmdline-tools/latest/" \
    && rm -rf /tmp/android-tools /tmp/android-tools.zip

# SDK 36, Build Tools e NDK exigidos pelo projeto Android gerado pelo Flutter.
# Ao construir esta imagem, o desenvolvedor aceita as licencas do Android SDK.
RUN yes | sdkmanager --sdk_root="${ANDROID_HOME}" --licenses > /dev/null \
    && sdkmanager --sdk_root="${ANDROID_HOME}" \
       "platform-tools" "platforms;android-36" "build-tools;36.0.0" "ndk;28.2.13676358" \
    && flutter config --android-sdk "${ANDROID_HOME}" \
    && flutter precache --android
