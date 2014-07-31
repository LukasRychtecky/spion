goog.require 'goog.events'
goog.require 'goog.events.EventType'
goog.require 'goog.date.DateTime'
goog.require 'goog.i18n.DateTimeFormat'

class spn.Collector

  ###*
    @param {spn.BrowserIdGen} browserIdGen
    @param {Window} win
    @param {string} eshop
    @param {Array.<string>} selectors
  ###
  constructor: (@browserIdGen, @win, @eshop, @selectors) ->
    @reset()
    @formatter = new goog.i18n.DateTimeFormat "yyyy'-'MM'-'dd HH:MM:ss"

  collects: ->
    for el in @win.document.querySelectorAll(@selectors.join(', '))
      goog.events.listen el, goog.events.EventType.KEYUP, @handleKey
    goog.events.listen @win, goog.events.EventType.LOAD, @handleLoad

  reset: ->
    @data = []

  ###*
    @return {boolean}
  ###
  isEmpty: ->
    @data.length is 0

  ###*
    @return {Array}
  ###
  getData: ->
    @data

  ###*
    @protected
    @param {goog.events.Event} e
  ###
  handleKey: (e) =>
    return if not e.target? or e.target.type is 'password'

    event =
      'eshop': @eshop
      'element_name': e.target.tagName
      'class_name': e.target.className
      'element_id': e.target.id
      'timestamp': @formatter.format new goog.date.DateTime()
      'key_code': e.keyCode
      'cookie_id': @browserIdGen.get()

    @data.push event

  ###*
    @protected
    @param {goog.events.Event} e
  ###
  handleLoad: (e) =>
    event =
      'eshop': @eshop
      'screen_height': @win.screen.height
      'screen_width': @win.screen.width
      'timestamp': @formatter.format new goog.date.DateTime()
      'user_agent': @win.navigator.userAgent
      'url': @win.location.href
      'cookie_id': @browserIdGen.get()

    @data.push event
