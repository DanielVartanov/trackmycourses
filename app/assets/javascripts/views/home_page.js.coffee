class TrackMyCourses.Views.HomePage extends Backbone.View

  initialize: ->
    _.bindAll @

    $("#slider").orbit
      animation: 'horizontal-push',
      animationSpeed: 800,
      timer: false,
      resetTimerOnClick: false,
      advanceSpeed: 4000,
      pauseOnHover: true,
      startClockOnMouseOut: true,
      startClockOnMouseOutAfter: 1000,
      directionalNav: true,
      captions: true,
      captionAnimation: 'fade',
      captionAnimationSpeed: 800,
      bullets: false,
      bulletThumbs: false,
      bulletThumbLocation: '',
      fluid: true
