{WorkspaceView} = require 'atom'
MechanicalKeyboard = require '../lib/mechanical-keyboard'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "MechanicalKeyboard", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('mechanical-keyboard')

  describe "when the mechanical-keyboard:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.mechanical-keyboard')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'mechanical-keyboard:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.mechanical-keyboard')).toExist()
        atom.workspaceView.trigger 'mechanical-keyboard:toggle'
        expect(atom.workspaceView.find('.mechanical-keyboard')).not.toExist()
