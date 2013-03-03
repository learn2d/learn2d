define ->
  template =
    header: """
      var __hasProp = {}.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

      return (function(_super) {

      __extends(Module, _super);

      function Module() {
        Module.__super__.constructor.apply(this, arguments);
      }
      Module.prototype.onCreated = function () {
      """

    footer: """
      };

      return Module;

      })(PlayerModule);
      """

  buildModule = (text) ->
    moduleIife = new Function(template.header + text + template.footer)
    return moduleIife()

  return buildModule
