class TrackMyCourses.Views.ChaptersView extends Backbone.View
  el: '#chapters'

  initialize: ->
    _.bindAll @

  render: (collection) ->
    @.$el.html ''
    collection.each @renderChapter

  renderChapter: (chapter) ->
    console.log chapter.get('lectures')
    @.$el.append new TrackMyCourses.Views.ChapterView(model: chapter).render().el
