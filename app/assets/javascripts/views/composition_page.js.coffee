class TrackMyCourses.Views.CompositionPage extends Backbone.View

  initialize: ->
    _.bindAll @

    @courses = new TrackMyCourses.Collections.Courses()
    @courses.on('reset', @coursesFetched).fetch()

  coursesFetched: (courses) ->
    @subscription = new TrackMyCourses.Models.Subscription()
    @subscription.on 'change', @subscriptionFetched
    @subscription.fetch()

  subscriptionFetched: (subscription) ->
    console.log 'oaeuaoeuaoeu'
    @courses.setSubscription(subscription)
    @coursesView = new TrackMyCourses.Views.Courses(collection: @courses).render()
    @subscribedCoursesView = new TrackMyCourses.Views.SubscribedCourses(collection: @courses).render()

    @coursesView.onSubscribe = @onSubscribe

  onSubscribe: (course) ->
    course_ids = @subscription.get('course_ids')
    course_ids.push(course.id)
    
    @subscription.set 'course_ids', course_ids
    @subscription.save()
    console.log @subscription
    @subscribedCoursesView.subscribe(course)

