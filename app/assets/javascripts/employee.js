$( document ).on('turbolinks:load', function() {
    $('#addAdditionalField').on('click', addFields);
    $( "#skillsSelector, #managersSelector" ).select2();
    $(".select2-field").select2();
});

function addFields(e) {
    $('#additionalFields').append(
        "<div class='form-row with-remove'>" +
            "<div class='col-3 form-group'>" +
                "<input class='form-control' placeholder='Field name' type='text' onchange='change(this)'>" +
            "</div>" +
            "<div class='col-8 form-group'>" +
                "<textarea class='form-control value' placeholder='Value' type='text' name='employee[additional][value]'/>" +
            "</div>" +
            "<div class='col-1 form-group'>" +
                "<i class='fa fa-times text-danger pointable' onClick='remove(this)'></i>" +
            "</div>" +
        "</div>");
}

function change(node) {
    $(node).parents('.form-row').find('textarea.value').attr('name', 'employee[additional][' + $(node).val() + ']');
}

function remove(node) {
    $(node).parents('.form-row').remove();
}