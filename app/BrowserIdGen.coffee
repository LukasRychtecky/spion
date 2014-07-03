goog.require 'goog.crypt'
goog.require 'goog.crypt.Sha256'
goog.require 'goog.net.Cookies'

class spn.BrowserIdGen

  ###*
    @type {string}
  ###
  @COOKIES_KEY = 'knj_id'

  ###*
    @param {Window} win
  ###
  constructor: (@win) ->
    @cookies = new goog.net.Cookies @win.document

  ###*
    @return {string}
  ###
  get: ->
    browserId = @cookies.get spn.BrowserIdGen.COOKIES_KEY

    unless browserId
      token = [@win.navigator.userAgent, new Date(), @win.screen.width, @win.screen.height].join ''
      crypt = new goog.crypt.Sha256()
      crypt.update token
      browserId = goog.crypt.byteArrayToHex crypt.digest()
      @cookies.set spn.BrowserIdGen.COOKIES_KEY, browserId, -1, '/'

    browserId
