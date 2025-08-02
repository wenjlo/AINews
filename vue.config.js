module.exports = {
  chainWebpack: config => {
    config.plugin('define').tap(args => {
      const newArgs = { ...args[0],
        '__VUE_PROD_HYDRATION_MISMATCH_DETAILS__': 'false'
      };
      return [newArgs];
    });
  }
};