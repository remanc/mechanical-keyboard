KeyboardListener = require './keyboard-listener'

module.exports =

  toggleState: false
  keyboardListeners: null

  activate: (state) ->
    atom.workspaceView.command 'mechanical-keyboard:toggle', => @toggle()
    @keyboardListeners = [];
    atom.workspaceView.eachEditorView (editorView) =>
      @keyboardListeners.push new KeyboardListener editorView

  toggle: ->
    @toggleState = !@toggleState
    if @toggleState
      @keyboardListeners.forEach (listener) -> listener.subscribe()
    else
      @keyboardListeners.forEach (listener) -> listener.unsubscribe()

  deactivate: ->
    # nothing to do here
