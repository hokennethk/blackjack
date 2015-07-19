class window.AppView extends Backbone.View

  el: '#game',

  template: _.template '
    <div class="game__content">
    <div class="game__buttons">
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    </div>
    <div class="hand-container player-hand-container"></div>
    <div class="hand-container dealer-hand-container"></div>
    </div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    # Calls when a player stands on a valid hand
    @model.get('playerHand').on 'stand', => 
      @disableButtons()

    # Always happens when player goes over 21
    @model.get('playerHand').on 'bust', =>
      @disableButtons()
      @playerLoses()

    @model.get('dealerHand').on 'gameEnd', =>
      if @model.get('dealerHand').finalScore() > 21
        @playerWins()
      else if @model.get('dealerHand').finalScore() < @model.get('playerHand').finalScore()
        @playerWins()
      else if @model.get('dealerHand').finalScore() > @model.get('playerHand').finalScore()
        @playerLoses()
      else
        console.log 'tie'

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  gameOver: ->
    console.log 'game is over'

  playerWins: ->
    console.log 'player wins'

  playerLoses: ->
    console.log 'player loses'
  
  disableButtons: ->
    # disable buttons
    @$el.find('.hit-button').attr 'disabled', true
    @$el.find('.stand-button').attr 'disabled', true