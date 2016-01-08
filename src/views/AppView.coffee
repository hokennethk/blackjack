class window.AppView extends Backbone.View

  el: '#game',

  template: _.template '

    <div id="log" class="log">
      <div class="log__message"></div>
    </div>

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
    'click .log': ->
      @model.newGame()
      @initialize()
      @render()


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
        $('#log .log__message').text('Tie game!')
        $('#log').addClass('is-visible')

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  gameOver: ->
    console.log 'game is over'

  playerWins: ->
    $('#log .log__message').text('You win!')
    $('#log').addClass('is-visible')

  playerLoses: ->
    $('#log .log__message').text('You lose!')
    $('#log').addClass('is-visible')
  
  disableButtons: ->
    # disable buttons
    @$el.find('.hit-button').attr 'disabled', true
    @$el.find('.stand-button').attr 'disabled', true

  enableButtons: ->
    # disable buttons
    @$el.find('.hit-button').attr 'disabled', false
    @$el.find('.stand-button').attr 'disabled', false