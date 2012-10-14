class TrackMyCourses.Views.SubscribedCourses extends Backbone.View
  el: '#selected_courses'
  events:
    'click .remove': 'unsubscribeClick'

  initialize: ->
    _.bindAll @

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

  unsubscribeClick: (event) ->
    eventElement = $(event.currentTarget)
    modelElement = $(eventElement).closest('article')

    courseView = modelElement.data('view')
    course = courseView.model

    course.set('subscribed', false)

    courseView.$el.hide 'show', ->
      courseView.remove()

    course_ids = @subscription.get('course_ids')
    course_ids = _.without(course_ids, course.id)
    @subscription.set
      'course_ids': course_ids
      'lastChangedCourse': course
    
    @subscription.save()

  updateCourses: (course) ->
    console.log course
    if course.get('subscribed')
      @subscribe(course)
