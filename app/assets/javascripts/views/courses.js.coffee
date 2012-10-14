class TrackMyCourses.Views.Courses extends Backbone.View
  el: '#course-list'

  initialize: ->
    _.bindAll @

  render: ->
    @.$el.html ''
    @collection.each @addCourse

  addCourse: (course) ->
    @.$el.append new TrackMyCourses.Views.Course(model: course).render().el
