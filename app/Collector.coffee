goog.require 'goog.events'
goog.require 'goog.events.EventType'
goog.require 'goog.date.DateTime'

class spn.Collector

  ###*
    @param {spn.BrowserIdGen} browserIdGen
    @param {Window} win
    @param {Element} el
    @param {string} eshop
  ###
  constructor: (@browserIdGen, @win, @el, @eshop) ->
    @reset()
    goog.events.listen @el, [goog.events.EventType.CLICK, goog.events.EventType.KEYUP], @handleEvent

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
  handleEvent: (e) =>
    return if not e.target? or e.target.type is 'password'

    event =
      'eshop': @eshop
      'element_name': e.target.tagName
      'class_name': e.target.className
      'element_id': e.target.id
      'screen_height': @win.screen.height
      'screen_width': @win.screen.width
      'timestamp': new goog.date.DateTime().toIsoString()
      'user_agent': @win.navigator.userAgent
      'key_code': e.keyCode
      'url': @win.location.href
      'cookie_id': @browserIdGen.get()
      'event_type': if e.type is 'keyup' then 2 else 1

    @data.push event
