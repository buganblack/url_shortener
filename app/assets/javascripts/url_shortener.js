$(document).ready(function(){
  var clipboard = new Clipboard(".clipboard-btn");
  $("#btnShorten").click(function() {
    if ($("#inputUrl").val() != "") {
      getShortUrl();
    }
  });

  $(".clipboard-btn").tooltip({
    placement: "right",
    trigger: "hover",
    title: "Copy"
  });
});

function getShortUrl() {
  $.ajax({
    url: "/",
    data: { "url": $("#inputUrl").val() },
    type: "GET",
    dataType: "JSON",
    success: function(data){
      console.log()
      $("#urlShortenModal").modal("show");
      setUrls(data["shorten_url"], data["original_url"])
    },
    error: function(e){console.log("Cannot load view: "+e)}
  });
}

function setUrls (shortUrl, originalUrl) {
  var root = document.location.host;
  $("#short-url-label").html(root + "/" + shortUrl);
  $("#original-url-label").attr("href", originalUrl);
  $("#original-url-label").text(originalUrl);
}
