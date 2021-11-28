#!/bin/bash
set -e

function save_prismic_content {
  MAP_CONFIG="${SCRIPTS_DIR}/mapconfig_prismic.yaml"
  DOCS_API_NAME="docsThemeCollection"
  DOCS_COLLECTION_ID="test-collage-cms-content"
  DOCS_PREVIEW=""
  POSITION_START="$(find "${DOCS_SAVE_CONTENTS_DIR}" -maxdepth 1 -type f | wc -l)"

  RCC_ENV_VARS_PREFIX=RCC_PRISMIC npx "${SAVE_CMD}" --map-config "${MAP_CONFIG}" \
    save \
    --static-root "${SAVE_STATIC_DIR}" \
    "${DOCS_API_NAME}" "${DOCS_SAVE_CONTENTS_DIR}" "${DOCS_SAVE_IMAGES_DIR}" \
    --position-start "$((POSITION_START + 1))" \
    --max-repeat 1 \
    --vars "locale=${SAVE_LOCALE}" "uid=${DOCS_COLLECTION_ID}"
}

