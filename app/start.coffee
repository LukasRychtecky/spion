goog.provide 'app.start'
goog.provide 'spn.start'

goog.require 'goog.net.Jsonp'
goog.require 'spn.Emitter'
goog.require 'spn.BrowserIdGen'
goog.require 'spn.Collector'

spn.start = (win, host, eshop, selectors) ->
  emitter = new spn.Emitter new goog.net.Jsonp(host), new spn.Collector(new spn.BrowserIdGen(win), win, eshop, selectors)
  emitter.emit()

goog.exportSymbol 'spn.start', spn.start
