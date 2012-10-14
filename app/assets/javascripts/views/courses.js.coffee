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
    unless course.get('subscribed')
      @.$el.append new TrackMyCourses.Views.Course(model: course).render().el

  subscribeToCourseClicked: (event) ->
    eventElement = $(event.currentTarget)
    modelElement = $(eventElement).closest('li')

    courseView = modelElement.data('view')
    course = courseView.model

    course.set('subscribed', true)

    courseView.$el.hide 'show', ->
      courseView.remove()

    course_ids = @subscription.get 'course_ids'
    course_ids.push course.id
    course_ids = _.unique(course_ids)
    
    @subscription.set 
      'course_ids': course_ids
      'lastChangedCourse': course

    @subscription.save()

  updateCourses: (course) ->
    unless course.get('subscribed') 
      @addCourse(course)
