class TrackMyCourses.Collections.Courses extends Backbone.Collection
  url: "/courses"
  model: TrackMyCourses.Models.Course

  setSubscription: (subscription) ->
    @.each (course) ->
      course.set 'subscribed', _.include(subscription.get('course_ids'), course.id)

  subscribed: ->
    @.filter (course) ->
      course.get 'subscribed'
