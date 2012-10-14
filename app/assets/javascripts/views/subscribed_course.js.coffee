class TrackMyCourses.Views.SubscribedCourse extends Backbone.View
  tagName: 'article'
  template: JST['subscribed_course']

  render: ->
    @.$el.html @template course: @model
    this
