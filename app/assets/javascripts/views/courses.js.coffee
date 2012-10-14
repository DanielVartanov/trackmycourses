class TrackMyCourses.Views.Courses extends Backbone.View
  el: '#course-list'

  initialize: ->
    _.bindAll @
    @collection.on 'reset', @collectionReset

  collectionReset: (courses) ->
    @.$el.html ''
    courses.each (course) ->
      @.$el.append new TrackMyCourses.Views.Course(model: course).render().el
