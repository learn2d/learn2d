require.config({
    urlArgs: "bust=" + (new Date()).getTime()
});
require({
  paths: {
    cs: 'cs',
    'coffee-script': 'coffee-script'
  }
}, ['cs!entry']);