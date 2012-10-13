window.TrackMyCourses =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    @courses = new @.Collections.Courses()

$(document).ready ->
  TrackMyCourses.init()
