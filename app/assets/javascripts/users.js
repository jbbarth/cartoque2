//token-related actions in users/new & users/X/edit
$(document).on('ready page:change', function() {
  //token generation
  $("#generate-token").on("click", function(e) {
    e.preventDefault()
    $(this).disabled = true
    $.getJSON($(this).data("url"), function(data) {
      $("#authentication_token").html(data.token)
      $("#user_authentication_token").val(data.token)
      $("#generate-token").hide()
      $("#remove-token").show()
    })
  })
  //token removal
  $("#remove-token").on("click", function(e) {
    e.preventDefault()
    if ($.rails.confirm("Are you sure ?")) {
      $("#authentication_token").html("")
      $("#user_authentication_token").attr("value", "")
      $("#remove-token").hide()
      $("#generate-token").show()
    }
  })
})
