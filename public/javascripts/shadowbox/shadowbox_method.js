// shadowbox function

function get_shadowbox_page(link_url){
    var options = {
        handleOversize: 'drag',
        enableKeys: false,
        animate: true,
        displayNav: false,
        modal: true,
        handleUnsupported: 'remove',
        autoplayMovies: false,
        inner_h: 505
    };
    
    Shadowbox.init(options);
    var options = {
        overlayOpacity: 0.4
    };
    
    Shadowbox.open({
        player: 'iframe',
        title: '',
        content: link_url,
        height: 502,
        width: 652
    
    }, options);
}
