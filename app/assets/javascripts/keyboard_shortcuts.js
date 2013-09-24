// Keyboard shortcuts
$(function() {
  //set a custom scope for inputs, so that we can
  //bind some shortcuts even in inputs
  key.filter = function(event){
    var tagName = (event.target || event.srcElement).tagName;
    key.setScope(/^(INPUT|TEXTAREA|SELECT)$/.test(tagName) ? 'input' : 'other');
    return true;
  }
  //back to index when a show/edit window is open
  keyEsc = function(e) {
    if ($('.show').length) {
      clickFirst($('h1 a, ul.nav li.active a'))
    }
    if ($('.modal').length) {
      $('.modal').modal('hide')
    }
  }
  key('esc', 'input', keyEsc)
  key('esc', 'other', keyEsc)
  //shortcuts for some links
  key('n', 'other', function(e) {
    clickFirst($('#new'))
  })
  //navigate between tabs
  key('right', 'other', function(e) {
    if ($('.nav-tabs li.active').length) {
      var selectedTab = $('.nav-tabs li.active')
      var nextTab = selectedTab.next('li')
      if (!nextTab.length) { nextTab = $('.nav-tabs li').first() }
      clickFirst(nextTab.find('a'))
    }
  })
  key('left', 'other', function(e) {
    if ($('.nav-tabs li.active').length) {
      var selectedTab = $('.nav-tabs li.active')
      var nextTab = selectedTab.prev('li')
      if (!nextTab.length) { nextTab = $('.nav-tabs li').last() }
      clickFirst(nextTab.find('a'))
    }
  })
  //shortcuts help modal, triggered with '?'
  //doesn't work in keymaster so... see: https://github.com/madrobby/keymaster/issues/59
  $(document).on('keyup', function(e) {
    var $target = $(e.target)
    //key '191' is '?'
    if (e.keyCode == 191 && !$target.is("input") && !$target.is("textarea") && !$target.is("select")) {
      $.getScript("/help/keyboard")
    }
  })
})
