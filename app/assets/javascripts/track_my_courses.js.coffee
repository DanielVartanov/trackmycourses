window.TrackMyCourses =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    views = 
      '/': TrackMyCourses.Views.HomePage
      '/account/subscriptions': TrackMyCourses.Views.CompositionPage
      '/dashboard': TrackMyCourses.Views.DashboardPage

     viewClass = views[window.location.pathname]
     @currentView = new viewClass()

$(document).ready ->
  TrackMyCourses.init()
