#!/bin/bash
set -e

if test ! -s "${BASE_URL}" && test ! -s "${BASE_URL}" ; then
  # content/settings を切り替える方法が不明だったので、
  # jq で書き換える.
  # logo は basePath 等を考慮しないようなので値を直接書き換える.
  jq '.url = env.BASE_URL + env.BASE_PATH' content/settings_src.json \
    | jq '.logo.light |= sub("^/"; env.BASE_PATH)' -- \
    | jq '.logo.dark |= sub("^/"; env.BASE_PATH)' -- \
      > content/settings.json
fi

# Native EMS のモジュールを利用するためのブリッジ.
# ~~/plugins/bridge/src の下に対象のモジュールを import/export する *.mjs を追加.
# nuxt.config.js では ~~/plugins/bridge/dist/*.cjs を指定する.
BRIDGE_DIST="plugins/brdige/dist" 
if test -d "${BRIDGE_DIST}" ; then
  rm -r "${BRIDGE_DIST}" 
fi

node "plugins/bridge/index.js"