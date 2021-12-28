#!/bin/bash
set -e

function save_gcms_content_overview {
  DOCS_PREVIEW="stage=PUBLISHED"
  if test "${PREVIEW_FLAG}" = "true" ; then
    DOCS_PREVIEW="stage=DRAFT"
  fi

  MAP_CONFIG="${SCRIPTS_DIR}/mapconfig_overview.yaml"
  DOCS_API_NAME="master"
  DOCS_COLLECTION_ID="test-collage-cms-content-overview"
  PAGE_SIZE="10"
  POSITION_START="$(find "${DOCS_SAVE_CONTENTS_DIR}" -maxdepth 1 -type f | wc -l)"

  RCC_ENV_VARS_PREFIX=RCC_GCMS npx "${SAVE_CMD}" --map-config "${MAP_CONFIG}" \
    save \
    --static-root "${SAVE_STATIC_DIR}" \
    "${DOCS_API_NAME}" "${DOCS_SAVE_CONTENTS_DIR}" "${DOCS_SAVE_IMAGES_DIR}" \
    --page-size "${PAGE_SIZE}" \
    --position-start "$((POSITION_START + 1))" \
    --vars "locale=${SAVE_LOCALE}" "slug=${DOCS_COLLECTION_ID}" "${DOCS_PREVIEW}"
}


function save_gcms_content {
  DOCS_PREVIEW="stage=PUBLISHED"
  if test "${PREVIEW_FLAG}" = "true" ; then
    DOCS_PREVIEW="stage=DRAFT"
  fi

  MAP_CONFIG="${SCRIPTS_DIR}/mapconfig_gcms.yaml"
  DOCS_API_NAME="master"
  DOCS_COLLECTION_ID="test-collage-cms-content"
  PAGE_SIZE="10"
  POSITION_START="$(find "${DOCS_SAVE_CONTENTS_DIR}" -maxdepth 1 -type f | wc -l)"

  RCC_ENV_VARS_PREFIX=RCC_GCMS npx "${SAVE_CMD}" --map-config "${MAP_CONFIG}" \
    save \
    --static-root "${SAVE_STATIC_DIR}" \
    "${DOCS_API_NAME}" "${DOCS_SAVE_CONTENTS_DIR}" "${DOCS_SAVE_IMAGES_DIR}" \
    --page-size "${PAGE_SIZE}" \
    --position-start "$((POSITION_START + 1))" \
    --vars "locale=${SAVE_LOCALE}" "slug=${DOCS_COLLECTION_ID}" "${DOCS_PREVIEW}"
}
