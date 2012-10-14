class TrackMyCourses.Collections.Courses extends Backbone.Collection
  url: "/courses"
  model: TrackMyCourses.Models.Course

  setSubscription: (subscription) ->
    @subscription = subscription
    @.each (course) ->
      if _.include subscription.get('course_ids'), course.id
        course.set 'subscribed', true
        course.set 'subscriptionClass', 'subscribed'

  subscribed: ->
    @.filter (course) ->
      course.get 'subscribed'
