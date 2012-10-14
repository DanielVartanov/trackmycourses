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
    @courses.setSubscription(subscription)
    @coursesView = new TrackMyCourses.Views.Courses(collection: @courses).render()
    @subscribedCoursesView = new TrackMyCourses.Views.SubscribedCourses(collection: @courses).render()
