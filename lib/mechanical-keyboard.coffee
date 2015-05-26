KeyboardListener = require './keyboard-listener'

module.exports =

  toggleState: false
  keyboardListeners: null

  activate: (state) ->
    atom.commands.add 'atom-workspace','mechanical-keyboard:toggle', => @toggle()
    @keyboardListeners = [];
    that = @;
    atom.workspace.observeTextEditors(
      (editor) -> that.keyboardListeners.push new KeyboardListener editor
    )

  toggle: ->
    @toggleState = !@toggleState
    if @toggleState
      @keyboardListeners.forEach (listener) -> listener.subscribe()
    else
      @keyboardListeners.forEach (listener) -> listener.unsubscribe()

  deactivate: ->
    # nothing to do here
