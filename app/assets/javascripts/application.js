// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//
//Loads all Bootstrap javascripts
//= require bootstrap
//
//Loads madrobby's keymaster.js (http://github.com/madrobby/keymaster.js
//= require keymaster
//
//Loads every local js next
//= require_tree .

$(function() {
  //helper methods
  function clickFirst(selector) {
    $(selector).length && $(selector)[0].click()
  }

  //hide alert messages after 6s
  $('#flash').delay(6000).fadeOut(300)

  //back to index when a show/edit window is open
  key('esc', function(e) {
    if ($('.show').length) {
      clickFirst('h1 a, ul.nav li.active a')
    }
  }) 
  //shortcuts for some links
  key('n', function(e) {
    clickFirst('#new')
  })
})
