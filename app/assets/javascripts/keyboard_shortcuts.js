// Keyboard shortcuts
$(function() {
  //back to index when a show/edit window is open
  key('esc', function(e) {
    if ($('.show').length) {
      clickFirst($('h1 a, ul.nav li.active a'))
    }
    if ($('.modal').length) {
      $('.modal').modal('hide')
    }
  }) 
  //shortcuts for some links
  key('n', function(e) {
    clickFirst($('#new'))
  })
  //navigate between tabs
  key('right', function(e) {
    if ($('.nav-tabs li.active').length) {
      var selectedTab = $('.nav-tabs li.active')
      var nextTab = selectedTab.next('li')
      if (!nextTab.length) { nextTab = $('.nav-tabs li').first() }
      clickFirst(nextTab.find('a'))
    }
  })
  key('left', function(e) {
    if ($('.nav-tabs li.active').length) {
      var selectedTab = $('.nav-tabs li.active')
      var nextTab = selectedTab.prev('li')
      if (!nextTab.length) { nextTab = $('.nav-tabs li').last() }
      clickFirst(nextTab.find('a'))
    }
  })
  //shortcuts help modal
  //doesn't work in keymaster so... see: https://github.com/madrobby/keymaster/issues/59
  $(document).on('keyup',function(e) {
    var $target = $(e.target)
    if (e.keyCode == 191 && !$target.is("input") && !$target.is("textarea") && !$target.is("select")) {
      $.getScript("/help/keyboard")
    }
  })
})
