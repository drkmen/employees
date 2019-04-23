$(document).on('turbolinks:load', function(){
    $form = $('#filtersForm');

    $form.on('change', function(){
        $form.find('input[type=submit]').trigger('click');
    })
});