suite 'spn.Collector', ->

  collector = null
  input = null
  el = null
  doc = null
  win = null
  body = null
  browserIdGen = null
  selectors = null

  mockWin = ->
    screen:
      width: 1400
      height: 900
    location:
      href: ''
    navigator:
      userAgent: ''
    document: mockDocument()
    attachEvent: ->

  mockDocument = ->
    querySelectorAll: ->
      [input]

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
    selectors = ['.form-control']
    browserIdGen = mockBrowserIdGen()
    win = mockWin()

  test 'Should not collect an event on a password input', ->
    input = mockInput 'password'
    collector = new spn.Collector browserIdGen, win, '', selectors
    collector.collects()

    assert.isTrue collector.isEmpty()
    fireKeyup input
    assert.isTrue collector.isEmpty()

  test 'Should collect an event on a text input', ->
    input = mockInput 'text'
    collector = new spn.Collector browserIdGen, win, '', selectors
    collector.collects()

    assert.isTrue collector.isEmpty()
    fireKeyup input
    assert.isFalse collector.isEmpty()

  test 'Timestamp should be in a proper format', ->
    input = mockInput 'text'
    collector = new spn.Collector browserIdGen, win, '', selectors
    collector.collects()

    fireKeyup input
    timestamp = collector.getData()[0].timestamp

    # format: 2014-07-06 09:07:06
    assert.equal timestamp[4], '-'
    assert.equal timestamp[7], '-'
    assert.equal timestamp[10], ' '
    assert.equal timestamp[13], ':'
    assert.equal timestamp[16], ':'
