class TrackMyCourses.Views.WeekPickerView extends Backbone.View
  el: '#weeks'
  events:
    'click #prev-week': 'prevWeekClicked'
    'click #next-week': 'nextWeekClicked'
    'click #current-week': 'currWeekClicked'

  initialize: ->
    _.bindAll @
    @$prevWeek = @.$el.find('#prev-week span.date')
    @$nextWeek = @.$el.find('#next-week span.date')
    @$currWeek = @.$el.find('#current-week ').parent().find('span.date')
    @onChange = (week) ->
      console.log week

    @week = Date.today().getWeek()

  render: ->
    @onChange(@week)
    currWeekMondayDate = Date.monday().setWeek(@week)
    currWeekSundayDate = currWeekMondayDate.clone().sunday()

    prevWeekMondayDate = currWeekMondayDate.clone().previous().week()
    prevWeekSundayDate = prevWeekMondayDate.clone().sunday().clone()

    nextWeekMondayDate = currWeekMondayDate.clone().week().clone()
    nextWeekSundayDate = nextWeekMondayDate.clone().sunday().clone()

    @$prevWeek.html "#{prevWeekMondayDate.toString('dd.MM')} - #{prevWeekSundayDate.toString('dd.MM')}"
    @$nextWeek.html "#{nextWeekMondayDate.toString('dd.MM')} - #{nextWeekSundayDate.toString('dd.MM')}"
    @$currWeek.html "#{currWeekMondayDate.toString('dd.MM')} - #{currWeekSundayDate.toString('dd.MM')}"

  prevWeekClicked: ->
    @week -= 1
    @render()
    
  nextWeekClicked: ->
    @week += 1
    @render()

  currWeekClicked: ->
    @week = Date.today().getWeek() 
    @render()
