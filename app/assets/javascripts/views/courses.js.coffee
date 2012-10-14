class TrackMyCourses.Views.Courses extends Backbone.View
  el: '#course-list'
  events:
    'click .add': 'subscribeToCourseClicked'

  initialize: ->
    _.bindAll @

  render: ->
    @.$el.html ''
    @collection.each @addCourse
    this

  addCourse: (course) ->
    @.$el.append new TrackMyCourses.Views.Course(model: course).render().el

  subscribeToCourseClicked: (event) ->
    eventElement = $(event.currentTarget)
    modelElement = $(eventElement).closest('li')

    course = modelElement.data('model')
    @collection.remove course

    modelElement.fadeOut()

    @onSubscribe(course)
