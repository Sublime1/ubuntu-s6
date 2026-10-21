# syntax=docker/dockerfile:1.4

# * Base image
ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME}"
ARG BASE_IMAGE_TAG="${BASE_IMAGE_TAG}"
FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

# * Arguments
ARG S6_OVERLAY_VERSION="${S6_OVERLAY_VERSION}" \
    BUILD_DATE="${BUILD_DATE}" \
    BASE_IMAGE_NAME="${BASE_IMAGE_NAME}" \
    BASE_IMAGE_TAG="${BASE_IMAGE_TAG}" \
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
    org.opencontainers.image.title="Base image with s6 init system" \
    org.opencontainers.image.description="Debian/Ubuntu base docker image using s6-overlay" \
    org.opencontainers.image.base.name="${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}" \
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
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get -o Acquire::Retries=3 -o Acquire::http::Timeout=20 -o Acquire::https::Timeout=20 update && \
    DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::Retries=3 -o Acquire::http::Timeout=20 -o Acquire::https::Timeout=20 install -y --no-install-recommends \
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
    && apt-get clean

# * Entrypoint
ENTRYPOINT ["/init"]
