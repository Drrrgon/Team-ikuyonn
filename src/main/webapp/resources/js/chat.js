$(".chatBtn").click(function() {
  $("#chatMenu,.page_cover,html").addClass("open");
  window.location.hash = "#open";
});

window.onhashchange = function() {
  if (location.hash != "#open") {
    $("#chatMenu,.page_cover,html").removeClass("open");
  }
};