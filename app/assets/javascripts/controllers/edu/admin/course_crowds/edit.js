//= require ./new
$('#course_crowd_teacher_id').dropdown({
  apiSettings: {
    url: '/admin/teachers/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
