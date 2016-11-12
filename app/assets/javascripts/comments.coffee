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
        $('.comments').append("<a href='' class='list-group-item'>#{comment_body}</a>")
