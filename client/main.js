require.config({
  urlArgs: "bust=" + (new Date()).getTime(),
  shim: {
    'canvastext': {
      exports: 'CanvasText'
    },
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
    bean: 'components/bean/bean',
    canvastext: 'components/canvastext/CanvasText-0.4.1',
    cs: 'components/require-cs/cs',
    'coffee-script': 'components/coffee-script/extras/coffee-script',
    flywheel: 'components/flywheel/src/flywheel',
    text: 'components/requirejs-text/text',
    json: 'components/requirejs-plugins/src/json',
    lodash: 'components/lodash/lodash',
    uuid: 'components/node-uuid/uuid'
  }
}, ['cs!entry']);
