class TrackMyCourses.Views.DashboardPage extends Backbone.View

  initialize: ->
    _.bindAll @

    @week = new TrackMyCourses.Models.Week()
    @weekPickerView = new TrackMyCourses.Views.WeekPickerView()
    @weekPickerView.onChange = @weekChanged
    @weekPickerView.render()

    @weekSummaryView = new TrackMyCourses.Views.WeekSummaryView()

    
    $("article h1").click ->
      $(this).parent().toggleClass "collapsed"

  weekChanged: (week) ->
    @week.fetch data: {week: week}, success: @weekFetched

  weekFetched: (week) ->
    @weekSummaryView.render(week)

    @weekCourses = new TrackMyCourses.Collections.Chapters(week.chapters)
    
