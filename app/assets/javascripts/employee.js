$( document ).on('turbolinks:load', function() {
    $('#addAdditionalField').on('click', addFields);
    $( "#skillsSelector" ).select2();
    $(".select2-field").select2();
});

function addFields(e) {
    $('#additionalFields').append(
        "<div class='form-row'>" +
            "<div class='col-5 form-group'>" +
                "<input class='form-control' placeholder='Field name' type='text' onchange='change(this)'>" +
            "</div>" +
            "<div class='col-5 form-group'>" +
                "<input class='form-control value' placeholder='Value' type='text' name='employee[additional][value]'>" +
            "</div>" +
            "<div class='col-2 form-group'>" +
                "<btn class='btn btn-outline-danger' onClick='remove(this)'>Remove</btn>" +
            "</div>" +
        "</div>");
}

function change(node) {
    $(node).parents('.form-row').find('input.value').attr('name', 'employee[additional][' + $(node).val() + ']');
}

function remove(node) {
    $(node).parents('.form-row').remove();
}