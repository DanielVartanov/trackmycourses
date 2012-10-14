class TrackMyCourses.Views.DashboardPage extends Backbone.View

  initialize: ->
    _.bindAll @

    @weekPickerView = new TrackMyCourses.Views.WeekPickerView()
    @weekPickerView.render()
    
    $("article h1").click ->
      $(this).parent().toggleClass "collapsed"