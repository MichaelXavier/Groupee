$('a[data-confirm], input[data-confirm]').live('click', function() {
  return confirm($(this).attr('data-confirm'));
});
