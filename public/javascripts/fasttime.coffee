$ ->
  working = ->
    $.post '/time', (data) ->
      $('#today').children('.start_time').html(data.start_time)
        .parent().children('.end_time').html(data.end_time)
        .parent().children('.working_time').html(data.working_time)
    , 'json'

  timerId = null
  $('#tracking').find('.switch-right').click ->
    working()
    timerId = setInterval(working, 60000)
    @
  .parent().find('.switch-left').click ->
    clearInterval timerId
    @

  $('#edit').find('input').keypress (e) ->
      if e.which == 13
        data = {}
        data['day'] = @.className
        data['time'] = @.value
        data['kind'] = @.name
        $.post '', (data)
        @

