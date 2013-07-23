$ ->
  $('#stamp').click ->
    $.post '/time', (data) ->
      $('#today').children('.start_time').html(data.start_time)
        .parent().children('.end_time').html(data.end_time)
        .parent().children('.working_time').html(data.working_time)
    , 'json'

