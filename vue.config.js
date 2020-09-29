module.exports = {
  devServer: {
    proxy: {
      '^/api': {
        target: 'http://localhost:7071/api',
        ws: true,
        changeOrigin: true
      }
    }
  }
}