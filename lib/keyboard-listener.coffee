KeySound = require './key-sound'

keyCode =
  DELETE: 8
  SPACEBAR: 32

# Preload sounds here so they can be reused across editorViews.
deleteKey = new KeySound('laptop_notebook_delete_key_press.mp3')
spaceBarKey = new KeySound('laptop_notebook_spacebar_press.mp3')
otherKey = new KeySound('laptop_notebook_return_or_enter_key_press.mp3')

module.exports =
class KeyboardListener

  constructor: (editorView) ->
    @editorView = editorView
    
  subscribe: ->
    @editorView.on 'keydown.mechanicalkeyboard', (e) ->
      keySound = switch e.which
        when keyCode.DELETE then deleteKey
        when keyCode.SPACEBAR then spaceBarKey
        else otherKey
      keySound.play()

  unsubscribe: ->
    @editorView.off 'keydown.mechanicalkeyboard'
