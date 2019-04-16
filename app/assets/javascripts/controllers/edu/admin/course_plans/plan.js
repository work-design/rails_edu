var url = new URL(window.location.href);
var id = url.href.match(/course_crowds\/\d\/course_plans/).toString().replace('course_crowds/', '').replace('/course_plans', '');
var request_url = '/CourseCrowd/' + id +'/time_plans';

$('#time_plan_room_id').dropdown();

$('#time_plan_time_list_id').dropdown({
  onChange: function(value, text, $selectedItem){
    var repeat_url = new URL(window.location);
    repeat_url.pathname = repeat_url + '/calendar';
    repeat_url.searchParams.set('time_list_id', value);
    repeat_url.searchParams.set('repeat_type', document.getElementById('time_plan_repeat_type').value);

    Rails.ajax({url: repeat_url, type: 'GET', dataType: 'script'});
  }
});
$('#time_plan_repeat_type').dropdown({
  onChange: function(value, text, $selectedItem){
    var repeat_url = new URL(window.location);
    repeat_url.pathname = request_url + '/calendar';
    repeat_url.searchParams.set('repeat_type', value);
    repeat_url.searchParams.set('time_list_id', document.getElementById('time_plan_time_list_id').value);

    Rails.ajax({url: repeat_url, type: 'GET', dataType: 'script'});
  }
});


remote_js_load(request_url);

$('.ui.floating.dropdown.labeled').dropdown();
