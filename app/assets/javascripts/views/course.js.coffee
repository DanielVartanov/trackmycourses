class TrackMyCourses.Views.Course extends Backbone.View
  tagName: "li"
  template: JST['course']

  render: ->
    @.$el.data('model', @model)
    @.$el.addClass @model.get('subscriptionClass')
    @.$el.html @template({course: @model})
    this
