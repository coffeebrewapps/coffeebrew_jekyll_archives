// Reference: https://www.w3schools.com/howto/howto_js_topnav_responsive.asp
function toggleMenu() {
  var x = document.getElementById("top-nav");
  if (x.className === "top-nav") {
    x.className += " responsive";
  } else {
    x.className = "top-nav";
  }
}

function selectVersion() {
  var s = document.getElementById("select-version");
  window.location.href = s.value;
}
