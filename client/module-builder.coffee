define ->
  template = ->
    return class Module extends PlayerModule
      onCreated: ->

  buildModule = (text) ->
    npcTemplate = new Function("NPC", template.header + text + template.footer)
    NPC =
      extend: (extendObj) ->
        NPC.scripts = extendObj
    scriptVars = npcTemplate(NPC)
    Module = template()
    for idx, script of NPC.scripts
      Module.prototype["on_#{idx.toLowerCase()}"] = script
    return Module

  return buildModule
