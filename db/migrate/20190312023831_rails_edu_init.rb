class RailsEduInit < ActiveRecord::Migration[5.0]

  def change

    create_table :courses do |t|
      t.references :course_taxon
      t.references :author
      t.references :teacher
      t.references :room
      t.string :type
      t.string :title
      t.string :description, limit: 4096
      t.integer :position, default: 1
      t.string :repeat_type
      t.string :repeat_days
      t.integer :limit_number
      t.integer :course_students_count, default: 0
      t.integer :lessons_count, default: 0
      t.timestamps
    end

    create_table :lessons do |t|
      t.references :course
      t.string :title
      t.references :author
      t.references :teacher
      t.timestamps
    end

    create_table :course_crowds do |t|
      t.references :course
      t.references :crowd
      t.references :room
      t.references :teacher
      t.integer :limit_number
      t.integer :present_number
      t.timestamps
    end

    create_table :course_grants do |t|
      t.references :course
      t.string :grant_kind
      t.string :grant_column
      t.jsonb :filter, default: {}
      t.timestamps
    end

    create_table :crowds do |t|
      t.string :name
      t.integer :crowd_students_count, default: 0
      t.timestamps
    end

    create_table :crowd_students do |t|
      t.references :crowd
      t.references :student, polymorphic: true
      t.references :tutelage
      t.string :state
      t.timestamps
    end

    create_table :course_students do |t|
      t.references :course
      t.references :student, polymorphic: true
      t.references :course_crowd
      t.string :state
      t.string :watch_ids
      t.integer :score
      t.string :comment, limit: 4096
      t.string :quit_note
      t.string :assigned_status
      t.string :job_id
      t.timestamps
    end

    create_table :lesson_students do |t|
      t.references :lesson
      t.references :course
      t.references :course_student
      t.references :course_crowd
      t.references :course_plan
      t.references :student, polymorphic: true
      t.string :state
      t.boolean :attended, default: false
      t.timestamps
    end

    create_table :course_papers do |t|
      t.references :course
      t.string :title
      t.text :description
      t.string :link
      t.string :entity_id
      t.string :type
      t.timestamps
    end

    create_table :course_taxons do |t|
      t.string :name
      t.timestamps
    end

    create_table :tutelages do |t|
      t.references :tutelar
      t.references :pupil
      t.references :user
      t.string :relation
      t.boolean :major
      t.timestamps
    end

    create_table :exam_reviewers do |t|
      t.references :exam
      t.references :student, polymorphic: true
      t.references :reviewer
      t.timestamps
    end

    create_table :exams do |t|
      t.references :course
      t.references :course_paper
      t.references :student, polymorphic: true
      t.string :onedrive_item
      t.string :link
      t.datetime :start_at
      t.datetime :finish_at
      t.string :entity_id
      t.string :state
      t.string :answer_id
      t.string :answer_detail, limit: 4096
      t.boolean :referenced, default: false
      t.string :answer_mark
      t.integer :spent_minutes
      t.string :comment, limit: 1024
      t.timestamps
    end

  end

end
