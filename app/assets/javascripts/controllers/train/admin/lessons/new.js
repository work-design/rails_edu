
$('#lesson_type').dropdown();
$('#lesson_lesson_taxon_id').dropdown();
$('#lesson_lecturer_id').dropdown({
  apiSettings: {
    url: '/train/teachers/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
$('#lesson_author_id').dropdown({
  apiSettings: {
    url: '/train/teachers/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
$('#lesson_department_ids').dropdown({
  apiSettings: {
    url: '/hr/departments/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
