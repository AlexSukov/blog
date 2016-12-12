$ ->
  hide_and_show = (parent) ->
    parent.find('.body_edit').hide()
    parent.find('.comment_body').show()
    parent.find('.edit_comment').show()
    parent.find('.delete_comment').show()
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
    $parent = $(this).parent()
    $parent.find('.comment_body').hide()
    $parent.find('.body_edit').show()
    $parent.append("<button class='btn update_comment'>Update</button>
    <button class='btn cancel_update'>Cancel</button>")
    $parent.find('.delete_comment').hide()
    $(this).hide()
  $(document).on 'click', '.cancel_update', ->
    $parent = $(this).parent()
    hide_and_show($parent)
    $parent.find('.update_comment').remove()
    $(this).remove()
  $(document).on 'click', '.update_comment', ->
    $parent = $(this).parent()
    $button = $(this)
    post_id = $('#post_id').val()
    $comment_id = $parent.find('.comment_id').val()
    $updated_comment_body = $parent.find('.body_edit').val()
    $.ajax
      type: 'PUT'
      url: "/posts/#{post_id}/comments/#{$comment_id}"
      data: { comment: { body: $updated_comment_body } }
      dataType: "json"
      success: (data) ->
        hide_and_show($parent)
        $("#comment_body_#{$comment_id}")[0].innerHTML = $updated_comment_body
        $parent.find('.cancel_update').remove()
        $button.remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
  $(document).on 'click', '.delete_comment', ->
    $parent = $(this).parent()
    post_id = $('#post_id').val()
    comment_id = $parent().find('.comment_id').val()
    $.ajax
      type: 'DELETE'
      url: "/posts/#{post_id}/comments/#{comment_id}"
      data: { comment: { id: comment_id } }
      dataType: "json"
      success: (data) ->
        $parent.remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
