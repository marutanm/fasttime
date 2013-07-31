chrome.browserAction.onClicked.addListener (tab) ->
  console.log 'fasttime'
  if localStorage["working"] == 'on'
    console.log "turn off"
    localStorage["working"] = 'off'
  else
    console.log "turn on"

    xhr = new XMLHttpRequest()
    xhr.onreadystatechange = ->
      if xhr.readyState == 4
        if xhr.status == 200
          console.log xhr.responseText
        else
          console.log("status = " + xhr.status)
    xhr.open("POST", "http://fast-time.dev/")

    localStorage["working"] = 'on'
