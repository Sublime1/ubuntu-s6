#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSIONS ; set +a;

IMAGE="${IMAGE:-${IMAGE_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}}"
IMAGE_LATEST="${IMAGE_LATEST:-${IMAGE_REPOSITORY}/${IMAGE_NAME}:latest}"
DOCKERFILE="${DOCKERFILE:-Dockerfile}"

docker buildx build \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg S6_OVERLAY_VERSION="${S6_OVERLAY_VERSION}" \
    --build-arg UBUNTU_VERSION="${UBUNTU_VERSION}" \
    --tag "${IMAGE}" \
    --file ../"${DOCKERFILE}" \
    --tag "${IMAGE_LATEST}" \
    ../.

# Let everyone know we are finished!
for i in {1..10}; do
    echo -e "\a"
    sleep 0.5   
done