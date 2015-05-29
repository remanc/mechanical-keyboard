MechanicalKeyboard = require '../lib/mechanical-keyboard'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "MechanicalKeyboard", ->
  activationPromise = null
  workspaceView = null
  defaultEditor = null

  beforeEach ->
    workspaceView = atom.views.getView(atom.workspace)

    activationPromise = atom.packages.activatePackage('mechanical-keyboard')

    #make a default editor
    waitsForPromise ->
      atom.workspace.open()
    runs ->
      defaultEditor = atom.workspace.getActiveTextEditor()

  describe "when the mechanical-keyboard:toggle event is triggered", ->
    it "attaches and then detaches an editor", ->
      #create a text editor
      editorView = atom.views.getView(defaultEditor)

      console.log('First test')
      waitsForPromise ->
        activationPromise
      runs ->
        expect(editorView.classList.contains('mechanical-keyboard')).toBe(false)
        atom.commands.dispatch workspaceView, 'mechanical-keyboard:toggle'
        expect(editorView.classList.contains('mechanical-keyboard')).toBe(true)
        atom.commands.dispatch workspaceView, 'mechanical-keyboard:toggle'

    it "auto attaches to newly created editors", ->
      
      waitsForPromise ->
        activationPromise
      runs ->
        waitsForPromise ->
          atom.workspace.open()
        runs ->
          editors = atom.workspace.getTextEditors()
          #verify that all editors are listening to keyboard
          for editor in editors
            editorView = atom.views.getView(editor)
            expect(editorView.classList.contains('mechanical-keyboard')).toBe(false)

          atom.commands.dispatch workspaceView, 'mechanical-keyboard:toggle'
          for editor in editors
            editorView = atom.views.getView(editor)
            expect(editorView.classList.contains('mechanical-keyboard')).toBe(true)
          atom.commands.dispatch workspaceView, 'mechanical-keyboard:toggle'
