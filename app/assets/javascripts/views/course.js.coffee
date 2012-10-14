class TrackMyCourses.Views.Course extends Backbone.View
  tagName: "li"
  template: JST['course']

  render: ->
    @.$el.html @template({course: @model})
    this
