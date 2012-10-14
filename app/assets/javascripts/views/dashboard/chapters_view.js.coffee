class TrackMyCourses.Views.ChaptersView extends Backbone.View
  el: '#chapters'

  initialize: ->
    _.bindAll @

  render: (collection) ->
    @.$el.html ''
    collection.each @renderChapter
    $("article h1").click ->
      $(this).parent().toggleClass "collapsed"

  renderChapter: (chapter) ->
    @.$el.append new TrackMyCourses.Views.ChapterView(model: chapter).render().el