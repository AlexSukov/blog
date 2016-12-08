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
        $('.comments').append("<a class='list-group-item'>#{comment_body}
        <input class='comment_id' type='hidden' value='#{data.id}'>
        <button class='btn btn-primary mt-10 delete_comment'>Удалить</button>
        <button class='btn btn-primary mt-10 edit_comment'>Редактировать</button>
        </a>")
        $('#comment_body').val('')
      error: (data) ->
        alert('Нельзя отправлять пустой комментарий. Пожалуйста, введите текст в поле комментария.')
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
