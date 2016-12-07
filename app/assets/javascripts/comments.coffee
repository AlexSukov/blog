$ ->
  $('.create_comment').on 'click' , ->
    post_id = $('#post_id').val()
    user_id = $('#author_id').val()
    comment_body = $('#comment_body').val()
    $.ajax
      type: 'POST'
      url: "/posts/#{post_id}/comments"
      data: { comment: { body: comment_body, user_id: user_id } }
      dataType: "json"
      success: (data) ->
        $('.comments').append("<a class='list-group-item'>
        <input class='body_edit' hidden value='#{data.body}'>
        <div class='comment_body inline' id='comment_body_#{data.id}'>#{data.body}</div>
        <input class='comment_id' hidden value='#{data.id}'>
        <button class='btn btn-primary mt-10 delete_comment'>Удалить</button>
        <button class='btn btn-primary mt-10 edit_comment'>Редактировать</button>
        </a>")
        $('#comment_body').val('')
      error: (data) ->
        alert('Нельзя отправлять пустой комментарий. Пожалуйста, введите текст в поле комментария.')
  $(document).on 'click', '.edit_comment', ->
    $(this).parent().find('.comment_body').hide()
    $(this).parent().find('.body_edit').show()
    $(this).parent().append("<button class='btn update_comment'>Update</button>
    <button class='btn cancel_update'>Cancel</button>")
    $(this).parent().find('.delete_comment').hide()
    $(this).hide()
  $(document).on 'click', '.cancel_update', ->
      $(this).parent().find('.comment_body').show()
      $(this).parent().find('.body_edit').hide()
      $(this).parent().find('.edit_comment').show()
      $(this).parent().find('.delete_comment').show()
      $(this).parent().find('.update_comment').remove()
      $(this).remove()
  $(document).on 'click', '.update_comment', ->
    $button = $(this)
    post_id = $('#post_id').val()
    comment_id = $(this).parent().find('.comment_id').val()
    updated_comment_body = $(this).parent().find('.body_edit').val()
    $.ajax
      type: 'PUT'
      url: "/posts/#{post_id}/comments/#{comment_id}"
      data: { comment: { body: updated_comment_body } }
      dataType: "json"
      success: (data) ->
        $button.parent().find('.body_edit').hide()
        comment_id = $button.parent().find('.comment_id').val()
        $button.parent().find('.comment_body').show()
        document.getElementById("comment_body_#{comment_id}").innerHTML = $button.parent().find('.body_edit').val()
        $button.parent().find('.edit_comment').show()
        $button.parent().find('.delete_comment').show()
        $button.parent().find('.cancel_update').remove()
        $button.remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
  $(document).on 'click', '.delete_comment', ->
    $button = $(this)
    post_id = $('#post_id').val()
    comment_id = $(this).parent().find('.comment_id').val()
    $.ajax
      type: 'DELETE'
      url: "/posts/#{post_id}/comments/#{comment_id}"
      data: { comment: { id: comment_id } }
      dataType: "json"
      success: (data) ->
        $button.parent().remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
