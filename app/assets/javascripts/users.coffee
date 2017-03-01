$ ->
  $('.update_user').on 'click' , ->
    $parent = $(this).parent()
    user_id = $parent.find('.user_id').val()
    role = $parent.find("#user_role option:selected").val()
    $.ajax
      type: 'PUT'
      url: "/users/#{user_id}"
      data: { user: { role: role } }
      dataType: "json"
  $('.delete_user').on 'click' , ->
    $parent = $(this).parent()
    user_id = $parent.find('.user_id').val()
    $.ajax
      type: 'DELETE'
      url: "/users/#{user_id}"
      dataType: "json"
      success: ->
        $parent.remove()
