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

  constructor: (editor) ->
    @editorView = atom.views.getView(editor)

  subscribe: ->
    #Add a class so it's easy to test, because you can't list down the listeners
    @editorView.classList.add 'mechanical-keyboard'
    @editorView.addEventListener 'keydown', (e) ->
      keySound = switch e.which
        when keyCode.DELETE then deleteKey
        when keyCode.SPACEBAR then spaceBarKey
        else otherKey
      keySound.play()

  unsubscribe: ->
    @editorView.classList.remove 'mechanical-keyboard'
    @editorView.removeEventListener 'keydown'
