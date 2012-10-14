class TrackMyCourses.Views.CompositionPage extends Backbone.View
  el: '#composition-page'
  button: '#to_dashboard'
  searchForm: '#search'

  events:
    'mouseenter #to_dashboard': 'toDashboardMouseEnter'
    'click #to_dashboard': 'toDashboardClicked'
    'submit #search': 'searchSubmitted'

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

  toDashboardMouseEnter: ->
    if @courses.subscribed().length is 0
      $(@button).addClass "has-tip"
    else
      $(@button).removeClass "has-tip"

  toDashboardClicked: (event) ->
    if @courses.subscribed().length is 0
      event.preventDefault()

  searchSubmitted: (event)->
    event.preventDefault()
