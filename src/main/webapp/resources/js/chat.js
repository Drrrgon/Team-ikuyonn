hideChat(0);

$('#prime').click(function() {
  toggleFab();
});

  $('#chat_fullscreen_loader').click(function(e) {
      $('.fullscreen').toggleClass('zmdi-window-maximize');
      $('.fullscreen').toggleClass('zmdi-window-restore');
      $('.chat').toggleClass('chat_fullscreen');
      $('.header_img').toggleClass('change_img');
      $('.img_container').toggleClass('change_img');
      $('.chat_header').toggleClass('chat_header2');
      $('.fab_field').toggleClass('fab_field2');
      $('.chat_converse').toggleClass('chat_converse2');
  });

  $('#chat_backspace').click(function(e) {
      if($('.fullscreen').attr('class') == 'fullscreen zmdi zmdi-window-restore'){
            $('.fullscreen').toggleClass('zmdi-window-maximize');
            $('.fullscreen').toggleClass('zmdi-window-restore');
            $('.chat').toggleClass('chat_fullscreen');
            $('.header_img').toggleClass('change_img');
            $('.img_container').toggleClass('change_img');
            $('.chat_header').toggleClass('chat_header2');
            $('.fab_field').toggleClass('fab_field2');
            $('.chat_converse').toggleClass('chat_converse2');
      }
      $('#chat_converse').css('display', 'none');
      $('#chat_body').css('display', 'none');
      $('#chat_form').css('display', 'none');
      $('.chat_login').css('display', 'block');
      $('.chat_fullscreen_loader').css('display', 'none');
      $('#chat_fullscreen').css('display', 'none');
      $('#chat_backspace').css('display', 'none');
      $('.onlineBtn').css('display', 'none');
  });
      //Toggle chat and links
function toggleFab() {
      $('.prime').toggleClass('zmdi-comment-outline');
      $('.prime').toggleClass('zmdi-close');
      $('.prime').toggleClass('is-active');
      $('.prime').toggleClass('is-visible');
      $('#prime').toggleClass('is-float');
      $('.chat').toggleClass('is-visible');
      $('.fab').toggleClass('is-visible');  

      $('#selectProject').css('display', 'block');
      $('.chat_header').css('display', 'block');
      $('.chat_option').css('display', 'block');
      var chatClass = $('#prime').attr('class');
      if(chatClass == 'fab'){
            $('#selectProject').css('display', 'none');
            $('.chat_header').css('display', 'none');
            $('.chat_option').css('display', 'none');
      }
    }
function hideChat(hide) {
    switch (hide) {
      case 0:
            $('#chat_converse').css('display', 'none');
            $('#chat_body').css('display', 'none');
            $('#chat_form').css('display', 'none');
            $('.chat_login').css('display', 'none');
            $('.chat_fullscreen_loader').css('display', 'none');
            $('#chat_fullscreen').css('display', 'none');
            $('#selectProject').css('display', 'none');
            $('.chat_header').css('display', 'none');
            $('.chat_option').css('display', 'none');

            // $('.chat').css('z-index', '-1');
            // $('#chat_converse').css('z-index', '-1');
            // $('#chat_body').css('z-index', '-1');
            // $('#chat_form').css('z-index', '-1');
            // $('.chat_fullscreen_loader').css('z-index', '-1');
            // $('#chat_fullscreen').css('z-index', '-1');
            // $('.chat .chat_converse .chat_msg_item ').css('z-index', '-1');
            // $('.chat .chat_converse .chat_msg_item.chat_msg_item_admin:before').css('z-index', '-1');
            // $('#onlineList').css('z-index', '-1');
            // $('.page_cover').css('z-index', '-1');
            // $('.fab_field2').css('z-index', '-1');
            break;
      // case 1:
      //       $('#chat_converse').css('display', 'block');
      //       $('#chat_body').css('display', 'none');
      //       $('#chat_form').css('display', 'none');
      //       $('.chat_login').css('display', 'none');
      //       $('.chat_fullscreen_loader').css('display', 'block');
      //       break;
      // case 2:
      //       $('#chat_converse').css('display', 'none');
      //       $('#chat_body').css('display', 'block');
      //       $('#chat_form').css('display', 'none');
      //       $('.chat_login').css('display', 'none');
      //       $('.chat_fullscreen_loader').css('display', 'block');
      //       break;
      // case 3:
      //       $('#chat_converse').css('display', 'none');
      //       $('#chat_body').css('display', 'none');
      //       $('#chat_form').css('display', 'block');
      //       $('.chat_login').css('display', 'none');
      //       $('.chat_fullscreen_loader').css('display', 'block');
      //       break;
      // case 4:
      //       $('#chat_converse').css('display', 'none');
      //       $('#chat_body').css('display', 'none');
      //       $('#chat_form').css('display', 'none');
      //       $('.chat_login').css('display', 'none');
      //       $('.chat_fullscreen_loader').css('display', 'block');
      //       $('#chat_fullscreen').css('display', 'block');
      //       break;
    }
}

$(".onlineBtn").click(function() {
  $("#onlineList,.page_cover,html").addClass("open");
  window.location.hash = "#open";
});

window.onhashchange = function() {
  if (location.hash != "#open") {
    $("#onlineList,.page_cover,html").removeClass("open");
  }
};