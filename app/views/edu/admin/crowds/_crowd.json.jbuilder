json.extract! crowd,
              :id,
              :name
json.students crowd.students do |student|
  json.extract! student, :id, :name
end
