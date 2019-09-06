class RailsEduInit < ActiveRecord::Migration[5.0]

  def change
    
    create_table :course_papers do |t|
      t.references :course
      t.string :title
      t.text :description
      t.string :link
      t.string :entity_id
      t.string :type
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
