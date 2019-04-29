//= require rails_booking/time_plan

var id = window.location.href.match(/course_crowds\/\d+\/course_plans/).toString().replace('course_crowds/', '').replace('/course_plans', '');
var request_url = '/CourseCrowd/' + id +'/time_plans';

remote_js_load(request_url);

$('.ui.floating.dropdown.labeled').dropdown();
