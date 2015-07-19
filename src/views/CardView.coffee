class window.CardView extends Backbone.View
  
  # className: 'card ' + @model.attributes.rankName + '-' + @model.attributes.suitName
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  cardTemplate: _.template '<%= rankName %>-<%= suitName %>.png'

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    # @$el.html @template @model.attributes

    @$el.addClass 'covered' unless @model.get 'revealed'
    @$el.not('.covered').css 'background-image', "url(img/cards/#{ @cardTemplate @model.attributes })"


