#!/usr/bin/env bash
set -euo pipefail
#set -x

if [[ "$BUILDKITE_BRANCH" == "master" ]]; then
  echo "+++ Publishing stable images"
  docker push "opxhub/gbp:${DIST}"
  docker push "opxhub/gbp:${DIST}-dev"
elif [[ -n "$BUILDKITE_TAG" ]]; then
  shopt -s extglob
  case "$BUILDKITE_TAG" in
    v*.*.*) echo "+++ Publishing release $BUILDKITE_TAG";;
    *) echo "--- Skipping tag $BUILDKITE_TAG"; exit 0;;
  esac

  docker tag  "opxhub/gbp:${DIST}" \
              "opxhub/gbp:${BUILDKITE_TAG}-${DIST}"
  docker push "opxhub/gbp:${BUILDKITE_TAG}-${DIST}"
  docker pull "opxhub/gbp:${DIST}"

  docker tag  "opxhub/gbp:${DIST}-dev" \
              "opxhub/gbp:${BUILDKITE_TAG}-${DIST}-dev"
  docker push "opxhub/gbp:${BUILDKITE_TAG}-${DIST}-dev"
  docker pull "opxhub/gbp:${DIST}-dev"
fi
