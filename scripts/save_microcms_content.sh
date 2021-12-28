#!/bin/bash
set -e

function save_microcms_content {
  MAP_CONFIG="${SCRIPTS_DIR}/mapconfig_microcms.yaml"
  DOCS_API_NAME="docs_ja"
  PAGE_SIZE="10"
  POSITION_START="$(find "${DOCS_SAVE_CONTENTS_DIR}" -maxdepth 1 -type f | wc -l)"

  RCC_ENV_VARS_PREFIX=RCC_MICROCMS npx "${SAVE_CMD}" --map-config "${MAP_CONFIG}" \
    save \
    --static-root "${SAVE_STATIC_DIR}" \
    "${DOCS_API_NAME}" "${DOCS_SAVE_CONTENTS_DIR}" "${DOCS_SAVE_IMAGES_DIR}" \
    --page-size "${PAGE_SIZE}" \
    --position-start "$((POSITION_START + 1))"
}
