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
  //hide alert messages after 6s
  $('#flash').delay(6000).fadeOut(300)

  //actions that should be triggered on page load, see below
  triggerOnLoadEvents()
})

//turbolink events
$(document).on('page:change', function() {
  triggerOnLoadEvents()
})

//events that should be triggered in full loads AND turbolinks loads
function triggerOnLoadEvents() {
  //focus on the first visible field of form
  $('form').find('input:visible,textarea:visible,select:visible').first().focus()
}
