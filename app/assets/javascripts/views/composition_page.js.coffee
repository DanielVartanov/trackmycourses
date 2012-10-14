class TrackMyCourses.Views.CompositionPage extends Backbone.View

  initialize: ->
    _.bindAll @

    @courses = new TrackMyCourses.Collections.Courses()
    new TrackMyCourses.Views.Courses(collection: @courses)

    @courses.fetch()
