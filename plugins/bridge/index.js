const fs = require("fs");
const path = require("path");
const rollup = require("rollup");
const commonjs = require("@rollup/plugin-commonjs");
const { nodeResolve } = require("@rollup/plugin-node-resolve");
const json = require("@rollup/plugin-json");

let plugin;

async function build() {
  const files = fs
    .readdirSync(path.join(__dirname, "src"))
    .filter((v) => path.extname(v) === ".mjs");
  for (const file of files) {
    const f = path.parse(file);

    const inputOpts = {
      plugins: [nodeResolve(), commonjs(), json()],
    };
    const outputOpts = {
      format: "cjs",
      exports: "default",
    };

    const bundle = await rollup.rollup({
      input: path.join(__dirname, "src", file),
      ...inputOpts,
    });
    await bundle.write({
      file: path.join(__dirname, "dist", `${f.name}.cjs`),
      ...outputOpts,
    });
  }
}
build();
