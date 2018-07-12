$( document ).on('turbolinks:load', function() {
    $('#addAdditionalField').on('click', addFields);
    $( "#skillsSelector, #managersSelector, #developersSelector" ).select2();
    $(".select2-field").select2();

    $('#toggleFilters, #toggleEmployees').on('click', function(){
        var $section = $(this).parents('.section');
        $section.toggleClass('col-3').toggleClass('col-1');
        $section.find('.content').toggleClass('d-none');
        $(this).toggleClass('fa-long-arrow-left').toggleClass('fa-long-arrow-right');
    });

    const $checkAll = $('#pdfEmployeeAll');
    const $linkToPdf = $('#linkToPdf');
    const $allCheckboxesAtModal = $('#pdfModal .fields input[type=checkbox]');
    const baseHrefToPdf = $linkToPdf.attr('href');

    $checkAll.on('change', function(){
        const isChecked = this.checked;
        $allCheckboxesAtModal.each(function(index, element){
            element.checked = isChecked;
        });
        generateNewUrl()
    });

    $allCheckboxesAtModal.on('change', function(){
        let allChecked = true;
        for (let i = 0; i < $allCheckboxesAtModal.length; i++) {
            allChecked = $allCheckboxesAtModal[i].checked;
            if (!allChecked){
                break;
            }
        }
        $checkAll.prop('checked', allChecked);
        generateNewUrl()
    });

    function generateNewUrl() {
        let newUrlToPdf = baseHrefToPdf;
        let wasAddedFirst = false;
        for (let i = 0; i < $allCheckboxesAtModal.length; i++) {
            let tempElement = $allCheckboxesAtModal[i];
            if (wasAddedFirst){
                newUrlToPdf += '&';
            } else {
                newUrlToPdf += '?';
                wasAddedFirst = true;
            }
            newUrlToPdf += tempElement.id + '=' + tempElement.checked;
        }
        $linkToPdf.attr('href', newUrlToPdf);
    }
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