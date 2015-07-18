describe 'hand', ->
  deck = null
  hand = null
  hitSpy = null
  checkScoreSpy = null
  playerEndSpy = null
  gameEndSpy = null
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
    deck = new Deck()

    hitSpy = sinon.spy(Hand.prototype, 'hit')
    checkScoreSpy = sinon.spy(Hand.prototype, 'checkScore')
    playerEndSpy = sinon.spy(Hand.prototype, 'playerEnd')
    gameEndSpy = sinon.spy(Hand.prototype, 'gameEnd')

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
    Hand.prototype.checkScore.restore()
    Hand.prototype.playerEnd.restore()
    Hand.prototype.gameEnd.restore()

  describe 'hit', ->
    it 'should check the score', =>
      hand = new Hand([card1, card2], deck)
      hand.hit()
      expect(checkScoreSpy).to.have.been.called;
      return
    it 'should have correct number of cards after hitting', =>
      hand = new Hand([card1, card2], deck)
      expect(hand.length).to.equal(2)
      hand.hit()
      expect(hand.length).to.equal(3)
      hand.hit()
      expect(hand.length).to.equal(4)
      return

  describe 'stand', ->
    it 'should end the players turn if they stand', =>
      hand = new Hand()
      hand.stand()
      expect(playerEndSpy).to.have.been.called;
      return
      

  describe 'aces', ->
    it 'should return true if hand has an ace', ->
      hand = new Hand([card1])
      assert.strictEqual(hand.hasAce(), true)
      return
    it 'should return false if hand has no ace', =>
      hand = new Hand([card2])
      assert.strictEqual(hand.hasAce(), false)
      return

  describe 'player', ->
    it 'should add a new card to players hand if they hit', =>
      hand = new Hand([card10, card6], deck, false)
      hand.hit()
      expect(hand.length).to.equal(3)
      return
    it 'should end the game if the player\'s hand value is over 21', =>
      hand = new Hand([card10, card9, card2], deck, false)
      hand.hit()
      expect(gameEndSpy).to.have.been.called
      return
    

  describe 'dealer', ->
    it 'should hit if score is less than 17', =>
      hand = new Hand([card10, card6], deck, true)
      hand.checkScore()
      expect(hitSpy).to.have.been.called
      return
    it 'should hit if dealer has ace and score is 17', =>
      hand = new Hand([card1, card6], deck, true)
      hand.checkScore()
      expect(hitSpy).to.have.been.called
      return
    it 'should not hit if dealer has ace and score is higher than 17', =>
      hand = new Hand([card1, card7], deck, true)
      hand.checkScore()
      expect(hitSpy).to.not.have.been.called
      return
    it 'should not hit if dealer has 17 with no aces', =>
      hand = new Hand([card10, card7], deck, true)
      hand.checkScore()
      expect(hitSpy).to.not.have.been.called
      return
    it 'should end the game if dealer score is over 21', =>
      hand = new Hand([card10, card7, card5], deck, true)
      hand.checkScore()
      expect(gameEndSpy).to.have.been.called
      return
    it 'should represent the correct value if card is flipped', =>      
      hand = new Hand([card10.flip(), card7], deck, true)
      expect(hand.scores()[0]).to.equal(7)
      hand.first().flip()
      expect(hand.scores()[0]).to.equal(17)






