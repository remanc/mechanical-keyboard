VENDOR_DIR = __dirname + '/../sounds'
NUM_BUFFERS = 10

module.exports =
class KeySound

  index: 0
  buffers: null

  # Need multiple buffers to handle keypresses that occur before a previous
  # keystroke of the same type has stopped playing
  constructor: (fileName) ->
    i = 0
    @buffers = while i++ < NUM_BUFFERS
      new Audio(VENDOR_DIR + '/' + fileName)

  play: ->
    @buffers[@index++ % NUM_BUFFERS].play()
