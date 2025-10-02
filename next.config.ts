// next.config.js
const withSvgr = require("next-plugin-svgr");
const isExportMode = process.env.NEXT_PUBLIC_EXPORT_MODE === "true";
/** @type {import('next').NextConfig} */
let nextConfig: import('next').NextConfig = {
    
    reactStrictMode: true,
    compiler: {
        styledComponents: true,
    },
    experimental: {
        optimizeCss: false, 
    },
    distDir: "build",
};
nextConfig = isExportMode 
  ? { ...nextConfig, output: "export" } 
  : { ...nextConfig, output: "standalone" };

module.exports = withSvgr(nextConfig);
