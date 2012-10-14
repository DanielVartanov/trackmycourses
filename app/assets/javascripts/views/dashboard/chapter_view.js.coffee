class TrackMyCourses.Views.ChapterView extends Backbone.View
  tagName: 'article'
  template: JST['chapter']

  initialize: ->
    _.bindAll @

  render: ->
    @.$el.addClass @model.get('course')['platform']['name']
    @.$el.html @template(chapter: @model)
    this
