define ->
  template = ->
    return class Module extends PlayerModule
      onCreated: ->

  buildModule = (text) ->
    customScript = new Function(template.header + text + template.footer)
    eventHandlers = {}
    scriptVars = customScript.call(eventHandlers)
    Module = template()
    for idx, script of eventHandlers
      Module.prototype[idx] = script
    console.log(Module.prototype);
    return Module

  return buildModule
