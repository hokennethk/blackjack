class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @add array

  hit: ->
    @add(@deck.pop())
    # return the last card (model) in the hand
    @checkScore()
    @last()

  stand: ->
    @trigger 'stand', @

  bust: ->
    @trigger 'bust', @

  # if hand has an ace, returns 1. if not, returns 0
  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  # calculates the minimum score with ace value = 1
  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


  checkScore: ->
    # Check if dealer
    if @isDealer
      if @finalScore() < 17
        # Dealer always plays if min score less than 17
        @hit()
      else if @scores()[1] == 17 and @hasAce()
        # this is a soft 17. Dealer must hit
        @hit()
      else
        # score hard 17 or greater
        @gameEnd()
    else
      # If users min score is > 21, end the game
      if @minScore() > 21 then @bust()

  finalScore: ->
    finalScore = if @scores()[1] < 22
      @scores()[1]
    else
      @scores()[0]
    finalScore

  gameEnd: ->
    @trigger 'gameEnd', @