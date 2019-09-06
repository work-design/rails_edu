json.extract! lesson,
              :id,
              :title,
              :video_urls,
              :document_urls
json.course lesson.course, :id, :title
