class TrackMyCourses.Views.WeekSummaryView extends Backbone.View
  el: '#summary'

  render: (week) ->
    @.$el.find('.lectures em').html week.get 'total_lecture_count'
    @.$el.find('.practicies em').html week.get 'total_practice_count'
    @.$el.find('.assigments em').html week.get 'total_assignment_count'
    @.$el.find('.lectures h5').html "#{parseInt(week.get('total_lecture_duration')/60)} minutes"
