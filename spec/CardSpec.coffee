describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 52
    return