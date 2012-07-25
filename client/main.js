require.config({
  urlArgs: "bust=" + (new Date()).getTime(),
  use: {
    'flywheel': {
      attach: 'flywheel'
    }
  }
});
require({
  paths: {
    cs: 'cs',
    'coffee-script': 'coffee-script'
  }
}, ['cs!entry']);