class TrackMyCourses.Views.SubscribedCourses extends Backbone.View
  el: '#selected_courses'

  render: ->
    _.bindAll @
    @.$el.html ''
    _.each @collection.subscribed(), @addSubscribedCourse
    this

  addSubscribedCourse: (course) ->
    @.$el.append new TrackMyCourses.Views.SubscribedCourse(model: course).render().el

  subscribe: (course) ->
    course_element = new TrackMyCourses.Views.SubscribedCourse(model: course).render().el
    $(course_element).hide()
    @.$el.prepend course_element
    $(course_element).show('slow')

