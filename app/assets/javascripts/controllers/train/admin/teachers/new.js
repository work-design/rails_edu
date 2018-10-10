//= require rails_com/fetch_xhr_script

$('#teacher_member_id').dropdown({
  apiSettings: {
    url: '/my/member/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
