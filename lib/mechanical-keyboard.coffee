KeyboardListener = require './keyboard-listener'

module.exports =

  toggleState: false
  keyboardListeners: null

  activate: (state) ->
    atom.commands.add 'atom-workspace','mechanical-keyboard:toggle', => @toggle()
    @keyboardListeners = [];
    that = @; #TODO: how does this work in coffeescript?
    atom.workspace.observeTextEditors (editor) ->
      that.keyboardListeners.push new KeyboardListener editor
      # immediately attach listeners to new editors
      that.setupListener()

  setupListener: ->
    if @toggleState
      @keyboardListeners.forEach (listener) -> listener.subscribe()
    else
      @keyboardListeners.forEach (listener) -> listener.unsubscribe()

  toggle: ->
    @toggleState = !@toggleState
    @setupListener()

  deactivate: ->
    # nothing to do here
