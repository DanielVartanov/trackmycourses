class TrackMyCourses.Views.CompositionPage extends Backbone.View
  el: '#composition-page'

  initialize: ->
    _.bindAll @

    @courses = new TrackMyCourses.Collections.Courses()
    @courses.on('reset', @coursesFetched).fetch()
    @coursesView = new TrackMyCourses.Views.Courses(collection: @courses)
    @subscribedCoursesView = new TrackMyCourses.Views.SubscribedCourses(collection: @courses)

    @coursesView.onSubscribe = @onSubscribe
    @subscribedCoursesView.onUnsubscribe = @onUnsubscribe
    @subscription = new TrackMyCourses.Models.Subscription()
    @coursesView.subscription = @subscription
    @subscribedCoursesView.subscription = @subscription

  coursesFetched: (courses) ->
    @subscription.fetch(success: @subscriptionFetched)

  subscriptionFetched: (subscription) ->
    @courses.setSubscription subscription
    @coursesView.render()
    @subscribedCoursesView.render()
    subscription.on 'change', @subscribtionChanged

  subscribtionChanged: (subscription) ->
    @coursesView.updateCourses(subscription.get('lastChangedCourse'))
    @subscribedCoursesView.updateCourses(subscription.get('lastChangedCourse'))
