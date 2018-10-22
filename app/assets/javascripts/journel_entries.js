$(function(){
    if($("body").hasClass("journels-show")){
        submitChartForm();
    }
})

function submitChartForm(){
    $("body").on('change', '#graph_filter', function(){
        $.ajax({
            url: $('#graph_form').attr('action'),
            data: $('#graph_form').serialize(),
            method: 'GET'
        })
    })
}