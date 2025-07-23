# syntax=docker/dockerfile:1.4

# * Base image
ARG UBUNTU_VERSION="${UBUNTU_VERSION}"
FROM ubuntu:${UBUNTU_VERSION}

# * Arguments
ARG S6_OVERLAY_VERSION="${S6_OVERLAY_VERSION}" \
    BUILD_DATE="${BUILD_DATE}" \
    UBUNTU_VERSION="${UBUNTU_VERSION}"

# * Labels
LABEL \
    maintainer="Oupfiz V <oupfiz5@yandex.ru>" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.authors="Oupfiz V (Five)" \
    org.opencontainers.image.url="https://chiselapp.com/user/oupfiz5/repository/ubuntu-s6/home" \
    org.opencontainers.image.documentation="https://chiselapp.com/user/oupfiz5/repository/ubuntu-s6/wiki" \
    org.opencontainers.image.source="https://chiselapp.com/user/oupfiz5/repository/ubuntu-s6/brlist" \
    org.opencontainers.image.version="0.0.6d" \
    org.opencontainers.image.revision="" \
    org.opencontainers.image.vendor="" \
    org.opencontainers.image.licenses="" \
    org.opencontainers.image.ref.name="" \
    org.opencontainers.image.title="Ubuntu image with s6 init system" \
    org.opencontainers.image.description="Ubuntu base docker image using s6-overlay" \
    org.opencontainers.ubuntu.version="${UBUNTU_VERSION}" \
    org.opencontainers.s6overlay.version="${S6_OVERLAY_VERSION}"

# * Environment

# * Copy
COPY rootfs/ /

# * Add
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz /tmp


# * Run
# hadolint ignore=DL3008,DL3003
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tzdata \   
        xz-utils \
    # Now we use the build-time dependency (xz-utils)
    && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-symlinks-noarch.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-symlinks-arch.tar.xz \
    # Now that we're done with it, purge the build-time dependency
    && apt-get purge -y --auto-remove xz-utils \
    # And finish with standard cleanup
    && rm -rf /tmp/*.tar.xz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# * Entrypoint
ENTRYPOINT ["/init"]
