class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    # Calls when a player stands on a valid hand
    @model.get('playerHand').on 'playerEnd', => 
      @disableButtons()

    # Always happens when player goes over 21
    @model.get('playerHand').on 'gameEnd', =>
      @disableButtons()
      alert('you lose')

    @model.get('dealerHand').on 'gameEnd', =>
      if @model.get('dealerHand').finalScore() > 21
        alert('you win!')
      else if @model.get('dealerHand').finalScore() < @model.get('playerHand').finalScore()
        alert('you win!')
      else if @model.get('dealerHand').finalScore() > @model.get('playerHand').finalScore()
        alert('you lose')
      else
        alert('tie')
      
      # if @model.get('playerHand').finalScore() > @model.get('dealerHand').finalScore()
      #   alert('you win!')
      # else if @model.get('playerHand').finalScore() < @model.get('dealerHand').finalScore()

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  disableButtons: ->
    # disable buttons
    @$el.find('.hit-button').attr 'disabled', true
    @$el.find('.stand-button').attr 'disabled', true