$ ->
  $('.create_comment').on 'click', ->
    post_id = $('#post_id').val()
    comment_body = $('#comment_body').val()
    $.ajax
      type: 'POST'
      url: "/posts/#{post_id}/comments"
      data: { comment: { body: comment_body } }
      dataType: "json"
      success: (data) ->
        $('.comments').append("<a class='list-group-item'>#{comment_body}</a>")
        $('#comment_body').val('')
      error: (data) ->
        alert('Нельзя отправлять пустой комментарий. Пожалуйста, введите текст в поле комментария.')
  $('.delete_comment').on 'click', ->
    $button = $(this)
    post_id = $('#post_id').val()
    comment_id = $('#comment_id').val()
    $.ajax
      type: 'DELETE'
      url: "/posts/#{post_id}/comments/#{comment_id}"
      data: { comment: { id: comment_id } }
      dataType: "json"
      success: (data) ->
        $button.parent().remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
