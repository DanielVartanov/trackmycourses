class TrackMyCourses.Views.ChaptersView extends Backbone.View
  el: '#chapters'

  initialize: ->
    _.bindAll @

  render: ->
    @.$el.html ''
    @
