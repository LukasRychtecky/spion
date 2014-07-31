goog.require 'goog.Timer'
goog.require 'goog.json'

class spn.Emitter

  ###*
    @param {goog.net.Jsonp} jsonp
    @param {spn.Collector} collector
    @param {number=} interval
  ###
  constructor: (@jsonp, @collector, @interval = 3000) ->
    @timer = new goog.Timer @interval

  emit: ->
    @collector.collects()
    @timer.start()
    goog.events.listen @timer, goog.Timer.TICK, @send

  ###*
    @protected
    @param {goog.events.Event} e
  ###
  send: (e) =>
    unless @collector.isEmpty()
      @jsonp.send {'d': goog.json.serialize(@collector.getData())}
      @collector.reset()
