import * as path from "path";
import theme from "@nuxt/content-theme-docs";

export default theme({
  docs: {
    primaryColor: "#3B82F6",
  },
  i18n: {
    locales: () => [
      {
        code: "ja",
        iso: "ja-JP",
        file: "ja-JP.js",
        name: "日本語",
      },
    ],
    defaultLocale: "ja",
  },
  buildModules: ["@nuxt/image"],
  modules: ["@nuxt/image"],
  image: {
    // domains: [ ],
    contentful: {
      baseURL: "https://images.ctfassets.net/",
    },
    imgix: {
      baseURL: "https://images.microcms-assets.io/",
    },
    providers: {
      // imgix で prismic 用の baseURL を指定する用 provider.
      // 中身は imgix provider を import して export しているだけ.
      imgixp: {
        name: "imgixp",
        provider: "~~/providers/imgixp", // ~ だと Docs Theme のディレクトリを指す.
        options: {
          baseURL: "https://images.prismic.io/", // prismic の asset.
        },
      },
    },
  },
  content: {
    markdown: {
      remarkPlugins: [["~~/plugins/bridge/dist/remark-emoji.cjs"]],
      rehypePlugins: [
        ["~~/plugins/bridge/dist/rehype-slug.cjs"],
        [
          "@hankei6km/rehype-image-salt",
          [
            {
              baseURL: "https://images.ctfassets.net/",
              rebuild: {
                tagName: "nuxt-img",
                baseAttrs:
                  'provider="contentful" data-salt-q="" data-salt-max-w="1200"',
              },
            },
            {
              baseURL: "https://media.graphcms.com/",
              rebuild: {
                keepBaseURL: true,
                baseAttrs: 'data-salt-max-w="1200"',
              },
            },
            {
              baseURL: "https://images.microcms-assets.io/",
              rebuild: {
                tagName: "nuxt-img",
                baseAttrs:
                  'provider="imgix" data-salt-q="" data-salt-max-w="1200"',
              },
            },
            {
              baseURL: "https://images.prismic.io/",
              rebuild: {
                tagName: "nuxt-img",
                baseAttrs:
                  'provider="imgixp" data-salt-q="" data-salt-max-w="1200"',
              },
            },
          ],
        ],
      ],
    },
  },
  server: {
    // host: 0,
    host: process.env.NODE_ENV !== "production" ? "0" : "localhost", // デフォルト: localhost
  },
  router: {
    base: process.env.BASE_PATH || "/",
  },
  // https://github.com/nuxt/content/issues/376
  hooks: {
    "vue-renderer:ssr:templateParams": function (params) {
      if (process.env.BASE_PATH) {
        params.HEAD = params.HEAD.replace(
          `<base href="${process.env.BASE_PATH}">`,
          ""
        );
      }
    },
  },
  publicRuntimeConfig: {
    baseURL: process.env.BASE_URL || "http://localhost:3000",
  },
});
