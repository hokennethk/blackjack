class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', => @playerBust()
    @get('playerHand').on 'stand', => @dealerStart()

  playerBust: ->
    @get('dealerHand').first().flip()

  dealerStart: ->
    @get('dealerHand').first().flip()
    @get('dealerHand').checkScore()

  newGame: ->
    # use new deck if cards get low
    if @get('deck').length < 26
      @set 'deck', deck = new Deck()

    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

    @get('playerHand').on 'bust', => @playerBust()
    @get('playerHand').on 'stand', => @dealerStart()
