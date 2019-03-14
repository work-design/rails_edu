
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
$('#course_author_id').dropdown({
  apiSettings: {
    url: '/edu/teachers/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
$('#course_department_ids').dropdown({
  apiSettings: {
    url: '/hr/departments/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
