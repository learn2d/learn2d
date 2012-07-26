require.config({
  urlArgs: "bust=" + (new Date()).getTime(),
  shim: {
    'flywheel': {
      exports: 'flywheel'
    }
  }
});
require({
  paths: {
    cs: 'cs',
    'coffee-script': 'coffee-script'
  }
}, ['cs!entry']);