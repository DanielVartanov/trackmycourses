class TrackMyCourses.Views.SubscribedCourses extends Backbone.View
  el: '#selected_courses'

  render: ->
    @.$el.html ''
    _.each @collection.subscribed(), (course) ->
      @.$el.append new TrackMyCourses.Views.SubscribedCourse(model: course).render().el
    this

  subscribe: (course) ->
    @.$el.prepend new TrackMyCourses.Views.SubscribedCourse(model: course).render().el
