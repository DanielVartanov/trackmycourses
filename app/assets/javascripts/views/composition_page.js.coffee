class TrackMyCourses.Views.CompositionPage extends Backbone.View

  initialize: ->
    _.bindAll @

    @courses = new TrackMyCourses.Collections.Courses()
    @courses.on('reset', @coursesFetched).fetch()

  coursesFetched: (courses) ->
    console.log @
    @subscription = new TrackMyCourses.Models.Subscription()
    @subscription.on 'sync', @subscriptionFetched
    @subscription.fetch()

  subscriptionFetched: (subscription) ->
    console.log subscription
