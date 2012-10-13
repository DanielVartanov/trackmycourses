window.TrackMyCourses =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    @courses = new @.Collections.Courses()
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

$(document).ready ->
  TrackMyCourses.init()
