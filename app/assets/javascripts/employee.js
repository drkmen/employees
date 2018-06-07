$(document).ready(function() {
    $('#addAdditionalField').on('click', addFields);
});

function addFields(e) {
    $('#additionalFields').append(
        "<div class='row'>" +
        "<div class='col-4'>" +
        "<input class='form-control' placeholder='Key' type='text' onchange='change(this)'>" +
        "</div>" +
        "<div class='col-4'>" +
        "<input class='form-control value' placeholder='Value' type='text' name='employee[additional][value]'>" +
        "</div>" +
        "<div class='col-4'>" +
        "<btn class='btn btn-outline-danger' onClick='remove(this)'>Remove</btn>" +
        "</div>" +
        "</div>");
}

function change(node) {
    $(node).parents('.row').find('input.value').attr('name', 'employee[additional][' + $(node).val() + ']');
}

function remove(node) {
    $(node).parents('.row').remove();
}