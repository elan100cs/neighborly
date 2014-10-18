var uservoiceKey = $('meta[name="uservoice_key"]').attr('content');
var uservoiceSSO = $('meta[name="uservoice_sso"]').attr('content');
var hasUservoiceKey = [null, ''].indexOf(uservoiceKey) === -1
var hasUservoiceSSO = [null, ''].indexOf(uservoiceSSO) === -1

if (hasUservoiceKey && !$.browser.mobile) {
  (function(){
    var uv=document.createElement('script');
    uv.type='text/javascript';
    uv.async=true;
    uv.src='//widget.uservoice.com/' + uservoiceKey + '.js';
    var s=document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(uv,s)
  })()

  UserVoice = window.UserVoice || [];

  if(hasUservoiceSSO) {
    UserVoice.push(['setSSO', uservoiceSSO]);
  }

  // Set colors
  UserVoice.push(['set', {
    accent_color: '#448dd6',
    trigger_color: 'white',
    trigger_background_color: 'rgba(46, 49, 51, 0.6)'
  }]);

  // Identify the user and pass traits
  // To enable, replace sample data with actual user traits and uncomment the line
  UserVoice.push(['identify', {}]);

  // Add default trigger to the bottom-right corner of the window:
  UserVoice.push(['addTrigger', { mode: 'contact', trigger_position: 'bottom-right' }]);

  // Or, use your own custom trigger:
  //UserVoice.push(['addTrigger', '#id', { mode: 'contact' }]);

  // Autoprompt for Satisfaction and SmartVote (only displayed under certain conditions)
  UserVoice.push(['autoprompt', {}]);
}
