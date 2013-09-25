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
  key('e', 'other', function(e) {
    clickFirst($('#edit, .selected .action-buttons .edit'))
  })
  key('d', 'other', function(e) {
    clickFirst($('#delete, .selected .action-buttons .delete'))
  })
  key('enter', 'other', function(e) {
    clickFirst($('.selected a'))
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
  //up/down keys for selecting table lines
  key('down', function(e) {
    if ($('table > tbody').length) {
      var table = $('table > tbody').first()
      var selectedRow = table.find('tr.selected')
      var nextRow = selectedRow.next('tr').first()
      if (!nextRow.length) { nextRow = table.find('tr').first() }
      selectedRow.removeClass('selected')
      nextRow.addClass('selected')
      $("body").scrollTop(nextRow.offset().top - $(window).height() / 2)
      return false
    }
  })
  key('up', function(e) {
    if ($('table > tbody').length) {
      var table = $('table > tbody').first()
      var selectedRow = table.find('tr.selected')
      var prevRow = selectedRow.prev('tr').first()
      if (!prevRow.length) { prevRow = table.find('tr').last() }
      selectedRow.removeClass('selected')
      prevRow.addClass('selected')
      $("body").scrollTop(prevRow.offset().top - $(window).height() / 2)
      return false
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
