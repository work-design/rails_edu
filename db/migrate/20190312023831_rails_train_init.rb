class RailsTrainInit < ActiveRecord::Migration[5.0]

  def change
    create_table "lesson_grants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.bigint "lesson_id"
      t.bigint "department_id"
      t.bigint "band_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["band_id"], name: "index_lesson_grants_on_band_id"
      t.index ["department_id"], name: "index_lesson_grants_on_department_id"
      t.index ["lesson_id"], name: "index_lesson_grants_on_lesson_id"
    end

    create_table "lesson_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.bigint "lesson_id"
      t.bigint "member_id"
      t.string "state"
      t.string "watch_ids"
      t.boolean "attended", default: false
      t.integer "score"
      t.string "comment", limit: 4096
      t.string "quit_note"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "assigned_status"
      t.string "job_id"
      t.string "old_assigned_status"
      t.string "old_status"
      t.index ["lesson_id"], name: "index_lesson_members_on_lesson_id"
      t.index ["member_id"], name: "index_lesson_members_on_member_id"
    end

    create_table "lesson_papers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.bigint "lesson_id"
      t.string "title"
      t.text "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "link"
      t.string "entity_id"
      t.string "type"
      t.index ["lesson_id"], name: "index_lesson_papers_on_lesson_id"
    end

    create_table "lesson_taxons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "lessons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.string "type"
      t.bigint "lesson_taxon_id"
      t.string "title"
      t.string "description", limit: 4096
      t.integer "position", default: 1
      t.bigint "author_id"
      t.bigint "lecturer_id"
      t.string "repeat_type"
      t.string "repeat_days"
      t.datetime "start_at"
      t.datetime "finish_at"
      t.string "meeting_room"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "lesson_members_count", default: 0
      t.integer "limit_people"
      t.string "video_link"
      t.string "en_video_link"
      t.string "document_link"
      t.boolean "compulsory", default: false
      t.index ["author_id"], name: "index_lessons_on_author_id"
      t.index ["lecturer_id"], name: "index_lessons_on_lecturer_id"
      t.index ["lesson_taxon_id"], name: "index_lessons_on_lesson_taxon_id"
    end

    create_table "teachers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.bigint "user_id"
      t.string "name"
      t.string "description", limit: 4096
      t.bigint "member_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["member_id"], name: "index_teachers_on_member_id"
      t.index ["user_id"], name: "index_teachers_on_user_id"
    end

    create_table "exam_reviewers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.bigint "exam_id"
      t.bigint "member_id"
      t.bigint "reviewer_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["exam_id"], name: "index_exam_reviewers_on_exam_id"
      t.index ["member_id"], name: "index_exam_reviewers_on_member_id"
      t.index ["reviewer_id"], name: "index_exam_reviewers_on_reviewer_id"
    end

    create_table "exams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.bigint "lesson_paper_id"
      t.bigint "member_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "lesson_id"
      t.string "onedrive_item"
      t.string "link"
      t.datetime "start_at"
      t.datetime "finish_at"
      t.string "entity_id"
      t.string "state"
      t.string "answer_id"
      t.string "answer_detail", limit: 4096
      t.boolean "referenced", default: false
      t.string "answer_mark"
      t.integer "reviewer_id"
      t.integer "spent_minutes"
      t.string "comment", limit: 1024
      t.index ["lesson_id"], name: "index_exams_on_lesson_id"
      t.index ["lesson_paper_id"], name: "index_exams_on_lesson_paper_id"
      t.index ["member_id"], name: "index_exams_on_member_id"
    end



  end

end
