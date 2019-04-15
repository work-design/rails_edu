
$('#course_type').dropdown();
$('#course_course_taxon_id').dropdown();
$('#course_lecturer_id').dropdown({
  apiSettings: {
    url: '/edu/teachers/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
$('#course_teacher_id').dropdown({
  apiSettings: {
    url: '/admin/teachers/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
