$(function() {

    $('.longtext .expand').click(function(e) {
        var $lt = $(e.target).parents('.longtext');
        console.log($lt);
        $lt.find('.full').slideDown('fast');
        $lt.find('.snippet').hide();
        return false;
    });
    
});
