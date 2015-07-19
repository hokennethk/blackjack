describe 'game view', ->
  appView = null
  deck = null
  hand = null
  hitStub = null
  standStub = null
  disableButtonsStub = null
  playerWinsStub = null
  playerLosesStub = null
  card0 = null
  card1 = null
  card2 = null
  card3 = null
  card4 = null
  card5 = null
  card6 = null
  card7 = null
  card8 = null
  card9 = null
  card10 = null
  card11 = null
  card12 = null

  beforeEach ->
    $('<div id=game></div>').appendTo('body')
    appView = new AppView(model: new App())
    deck = new Deck()
    hitStub = sinon.stub(Hand.prototype, 'hit', => return 0)
    standStub = sinon.stub(Hand.prototype, 'stand', => return 0)
    disableButtonsStub = sinon.spy(AppView.prototype, 'disableButtons')
    playerWinsStub = sinon.spy(AppView.prototype, 'playerWins')
    playerLosesStub = sinon.spy(AppView.prototype, 'playerLoses')

    card0 = new Card({value: 0, suit: 0, rank: 0})
    card1 = new Card({value: 1, suit: 0, rank: 1})
    card2 = new Card({value: 2, suit: 0, rank: 2})
    card3 = new Card({value: 3, suit: 0, rank: 3})
    card4 = new Card({value: 4, suit: 0, rank: 4})
    card5 = new Card({value: 5, suit: 0, rank: 5})
    card6 = new Card({value: 6, suit: 0, rank: 6})
    card7 = new Card({value: 7, suit: 0, rank: 7})
    card8 = new Card({value: 8, suit: 0, rank: 8})
    card9 = new Card({value: 9, suit: 0, rank: 9})
    card10 = new Card({value: 10, suit: 0, rank: 10})
    card11 = new Card({value: 11, suit: 0, rank: 11})
    card12 = new Card({value: 12, suit: 0, rank: 12})

  afterEach ->
    Hand.prototype.hit.restore()
    Hand.prototype.stand.restore()
    AppView.prototype.disableButtons.restore()
    AppView.prototype.playerWins.restore()
    AppView.prototype.playerLoses.restore()
    $('body').find('#game').remove()

    
  describe 'hit and stand buttons', ->
    it 'should call hit when the hit button is pressed', =>
      $(appView.el).find('.hit-button').trigger('click')
      expect(hitStub).to.have.been.called
    it 'should call stand when the stand button is pressed', =>
      appView.$el.find('.stand-button').trigger('click')
      expect(standStub).to.have.been.called
    it 'should call a disable buttons method when player turn is over', =>
      appView.model.get('playerHand').trigger('stand')
      expect(disableButtonsStub).to.have.been.called
    it 'should disable buttons when disableButtons method is called', =>
      # initial check for buttons not disabled
      appView.$('button').each (i, el) ->
        expect($(el).attr('disabled')).to.be.not.ok
      # call disableButtons
      appView.disableButtons()
      appView.$('button').each (i, el) ->
        expect($(el).attr('disabled')).to.be.ok
  describe 'game outcomes', =>
    it 'should have the player lose if the player busts', =>
      appView.model.get('playerHand').trigger 'bust'
      expect(playerLosesStub).to.have.been.called