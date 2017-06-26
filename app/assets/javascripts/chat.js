
$(function(){
   if ($('#ms-menu-trigger')[0]) {
        $('body').on('click', '#ms-menu-trigger', function() {
            $('.ms-menu').toggleClass('toggled'); 
        });
    }
});


$(function(){
    $(".chat-list-wrapper, .message-list-wrapper").niceScroll();
})