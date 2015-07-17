# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'gameEnd', => @playerBust()
    @get('playerHand').on 'playerEnd', => @dealerStart()

  playerBust: ->
    @get('dealerHand').first().flip()

  dealerStart: ->
    @get('dealerHand').first().flip()
    @get('dealerHand').checkScore()
