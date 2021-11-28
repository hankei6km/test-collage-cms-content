#!/bin/bash

set -e

SAVE_CMD=rcc

SCRIPTS_DIR="scripts"
CONTENT_DIR="content"
STATIC_DIR="static"
STATIC_IMAGES_DIR="${STATIC_DIR}/images"

SAVE_DIR="tmp/save"
SAVE_CONTENT_DIR="${SAVE_DIR}/content"
SAVE_STATIC_DIR="${SAVE_DIR}/static"
SAVE_STATIC_IMAGES_DIR="${SAVE_STATIC_DIR}/images"

if test -d "${SAVE_DIR}" ; then
  rm -r "${SAVE_DIR}"
fi

if test ! -d "${STATIC_IMAGES_DIR}" ; then
  mkdir -p "${STATIC_IMAGES_DIR}" 
fi

source "${SCRIPTS_DIR}/save_ctf_content.sh"
source "${SCRIPTS_DIR}/save_gcms_content.sh"
source "${SCRIPTS_DIR}/save_microcms_content.sh"
source "${SCRIPTS_DIR}/save_prismic_content.sh"

# SAVE_LOCALSE=("ja" "en-US")
SAVE_LOCALES=("ja" )
for SAVE_LOCALE in "${SAVE_LOCALES[@]}"; do
  echo "${SAVE_LOCALE}"
  DOCS_CONTENTS_DIR="${CONTENT_DIR}/${SAVE_LOCALE/-[A-Z][A-Z]/}"
  DOCS_IMAGES_DIR="${STATIC_IMAGES_DIR}/${SAVE_LOCALE/-[A-Z][A-Z]/}"

  DOCS_SAVE_CONTENTS_DIR="${SAVE_CONTENT_DIR}/pages"
  DOCS_SAVE_IMAGES_DIR="${SAVE_STATIC_IMAGES_DIR}/pages"

  mkdir -p "${DOCS_SAVE_CONTENTS_DIR}"
  mkdir -p "${DOCS_SAVE_IMAGES_DIR}"

  echo "=== Overview(GraphCMS) ==="
  save_gcms_content_overview

  echo "=== Contentful ==="
  save_ctf_content
  echo "=== GraphCMS ==="
  save_gcms_content
  echo "=== microCMS ==="
  save_microcms_content
  echo "=== Prismic ==="
  save_prismic_content

  rsync -a --delete "${DOCS_SAVE_CONTENTS_DIR}/" "${DOCS_CONTENTS_DIR}"
  rsync -a --delete "${DOCS_SAVE_IMAGES_DIR}/" "${DOCS_IMAGES_DIR}"
done