define ->
  # Module is really basic and just included directly here to be extended by
  # the `buildModule` function below. We need to return a new one each time
  # because we are directly augmenting the resulting constructor function in
  # `buildModule`.
  template = ->
    return class Module extends PlayerModule
      onCreated: ->

  # Builds a new scripting module from the JavaScript source code provided.
  buildModule = (text) ->
    # Delete first line of script so Chrome reports line numbers correctly
    # Append sourceURL comment to associate the script filename
    text = "#{text.replace(/.*\n/, '')}\n\/\/@ sourceURL=foo.js"
    customScript = new Function(text)

    # Execute custom script to create dynamic functions
    eventHandlers = {}
    scriptVars = customScript.call(eventHandlers)

    # Create new module and attach dynamic event handler functions
    Module = template()
    for idx, script of eventHandlers
      # @TODO:
      Module.prototype[idx] = script

    # Return constructor function
    return Module

  # Public API
  return {
    build: buildModule
  }
