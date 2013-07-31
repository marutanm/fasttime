chrome.browserAction.onClicked.addListener(function(tab){
  console.log('fasttime');
  if (localStorage["working"] == 'on') {
    console.log("turn off");
    localStorage["working"] = 'off';
  } else{
    console.log("turn on");
    localStorage["working"] = 'on';
  }
});

