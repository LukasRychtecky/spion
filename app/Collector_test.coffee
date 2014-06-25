suite 'spn.Collector', ->

  collector = null
  input = null
  el = null
  doc = null
  win = null
  body = null
  browserIdGen = null

  mockWin = ->
    screen:
      width: 1400
      height: 900
    location:
      href: ''
    navigator:
      userAgent: ''

  mockBrowserIdGen = ->
    get: ->
      ''

  fireKeyup = (el) ->
    e =
      target: input
    el.events['keyup'] e

  mockInput = (type) ->
    el = mockEl()
    el.type = type
    el

  mockEl = ->
    el =
      events: {}
      addEventListener: (type, listener) ->
        el.events[type] = listener
    el

  setup ->
    browserIdGen = mockBrowserIdGen()
    win = mockWin()

  test 'Should not collect an event on a password input', ->
    input = mockInput 'password'
    collector = new spn.Collector browserIdGen, win, input, ''

    assert.isTrue collector.isEmpty()
    fireKeyup input
    assert.isTrue collector.isEmpty()

  test 'Should collect an event on a text input', ->
    input = mockInput 'text'
    collector = new spn.Collector browserIdGen, win, input, ''

    assert.isTrue collector.isEmpty()
    fireKeyup input
    assert.isFalse collector.isEmpty()
