require.config({
  urlArgs: "bust=" + (new Date()).getTime(),
  shim: {
    'flywheel': {
      exports: 'flywheel'
    },
    'uuid': {
      exports: 'uuid'
    }
  }
});
require({
  paths: {
    cs: 'cs',
    'coffee-script': 'coffee-script'
  }
}, ['cs!entry']);