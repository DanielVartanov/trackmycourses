class TrackMyCourses.Views.DashboardPage extends Backbone.View

  initialize: ->
    _.bindAll @

    $("article h1").click ->
      $(this).parent().toggleClass "collapsed"
