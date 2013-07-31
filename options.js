window.onload = function(){
  document.getElementById("form").value = localStorage["user_key"] ? localStorage["user_key"] : "";

  document.getElementById("save").onclick = function(){
    localStorage["user_key"] = document.getElementById("form").value;
  }
}
