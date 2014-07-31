suite 'spn.Emitter', ->

  emitter = null
  collector = null
  jsonp = null

  mockCollector = (empty, data = []) ->
    isEmpty: ->
      empty
    getData: ->
      data
    reset: ->
    collects: ->

  runEmitter = ->
    emitter = new spn.Emitter jsonp, collector, 50
    emitter.emit()

  test 'Should not send any data', ->
    collector = mockCollector true
    jsonp =
      send: ->
        assert.fail 'Can not send any data!'

    runEmitter()

  test 'Should send data', (done) ->
    collector = mockCollector false, [{}]
    jsonp =
      send: ->
        done()

    runEmitter()
