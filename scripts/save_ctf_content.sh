#!/bin/bash
set -e

function save_ctf_content {
  if test "${PREVIEW_FLAG}" = "true" ; then
    DOCS_PREVIEW="preview=true"
  fi

  MAP_CONFIG="${SCRIPTS_DIR}/mapconfig_ctf.yaml"
  DOCS_API_NAME="docsThemeCollection"
  DOCS_COLLECTION_ID="test-collage-cms-content"
  DOCS_PREVIEW=""
  PAGE_SIZE="10"
  POSITION_START="$(find "${DOCS_SAVE_CONTENTS_DIR}" -maxdepth 1 -type f | wc -l)"

  RCC_ENV_VARS_PREFIX=RCC_CTF npx "${SAVE_CMD}" --map-config "${MAP_CONFIG}" \
    save \
    --static-root "${SAVE_STATIC_DIR}" \
    "${DOCS_API_NAME}" "${DOCS_SAVE_CONTENTS_DIR}" "${DOCS_SAVE_IMAGES_DIR}" \
    --page-size "${PAGE_SIZE}" \
    --position-start "$((POSITION_START + 1))" \
    --vars "locale=${SAVE_LOCALE}" "id=${DOCS_COLLECTION_ID}" "${DOCS_PREVIEW}"
}
