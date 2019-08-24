import 'rails_com/checkbox'

$('#q_office_id').dropdown();

listenCheckedIds('course_student_id');

$('input[name=course_student_id]').change(function(){
  var path_url = window.location.pathname;
  var check_url;
  if (this.checked) {
    check_url = path_url + '/attend?add_ids=' + this.value;
  } else {
    check_url = path_url + '/attend?remove_ids=' + this.value;
  }
  var params = {
    method: 'POST',
    credentials: 'include',
    headers: {
      'Accept': 'application/javascript',
      'X-CSRF-Token': document.head.querySelector("[name=csrf-token]").content
    }
  };
  fetch_xhr_script(check_url, params)
});

$('input[name=course_student_all]').change(function(){
  var path_url = window.location.pathname;
  var check_url;
  if (this.checked) {
    check_url = path_url + '/attend?add_ids=' + getAddIds('course_student_id');
  } else {
    check_url = path_url + '/attend?remove_ids=' + getRemoveIds('course_student_id');
  }
  var params = {
    method: 'POST',
    credentials: 'include',
    headers: {
      'Accept': 'application/javascript',
      'X-CSRF-Token': document.head.querySelector("[name=csrf-token]").content
    }
  };
  fetch_xhr_script(check_url, params)
});
