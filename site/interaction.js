window.onload = function(){
  document.getElementById("buttons").onclick = function(e){
    toggle_display(e.target.attributes[0].nodeValue)
  }
  getJSON("/data/get_team_list",loadTeamList)
  getJSON("/data/get_season_list",loadSeasonList)
  getJSON("/data/get_general_stats",insertResponse)
  document.getElementById("team_id").onchange = function(e){
    getJSON("/data/get_team_details?team_id=" + e.target.value, insertResponse);
  }
  document.getElementById("season_id").onchange = function(e){
    getJSON("/data/get_season_details?season_id=" + e.target.value, insertResponse);
  }
}

function toggle_display(target){
  if (target != "buttons"){
    var sections = ["team", "season", "general"]
    for (var i in sections){
      if (sections[i] == target){
        document.getElementById(sections[i]).classList.add("shown");
      } else {
        document.getElementById(sections[i]).classList.remove("shown");
      }
    }
  }
}

function getJSON(url, callback, elm = undefined) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.responseType = 'json';
    xhr.onload = function() {
      var status = xhr.status;
      if (status === 200) {
        if (elm != undefined){
          callback(null, xhr.response, elm);
        } else {
          callback(null, xhr.response);
        }
      } else {
        if (elm != undefined){
          callback(status, xhr.response, elm);
        } else {
          callback(status, xhr.response);
        }
      }
    };
    xhr.send();
};

function loadTeamList(error,data){
  if(error){
    console.dir(error)
  } else {
    parent = document.getElementById("team_id")
    for (var i in data){
      elm = document.createElement("option")
      elm.value = i
      elm.innerHTML = data[i]
      parent.appendChild(elm)
    }
  }
}

function loadSeasonList(error, data){
  if(error){
    console.dir(error)
  } else {
    parent = document.getElementById("season_id")
    for (var i in data){
      elm = document.createElement("option")
      elm.value = i
      elm.innerHTML = data[i]
      parent.appendChild(elm)
    }
  }
}

function insertResponse(error, data){
  if(error){
    console.dir(error)
  } else {
    for (var i in data){
      elm = document.getElementById(i)
      if (typeof(data[i]) == "object"){
        if (Array.isArray(data[i])){
          if (data[i].length == 0){
            elm.value = "None!"
          } else {
            elm.value = data[i].join(", ")
          }
        } else {
          str = pretty_print(data[i], 0)
          elm.innerHTML = str.trim()
        }
      } else {
        elm.value = data[i]
      }
    }
  }
}

function pretty_print(data, level){
  str = ""
  for (var i in data){
    str += " ".repeat(level*2) + i + " => "
    if (typeof(data[i]) == "object"){
      str += "{\n" + pretty_print(data[i], level + 1) + " ".repeat(level*2) + "}\n"
    } else {
      str += data[i] + "\n"
    }
  }
  return str
}
