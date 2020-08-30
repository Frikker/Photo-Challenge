class CreateReportReasons < ActiveRecord::Migration[6.0]
  def change
    create_table :report_reasons do |t|
      t.references :reason, null: false
      t.references :from, null: false
      t.references :user, null: false

      t.timestamps
    end

    add_index :report_reasons, %i[reason_id from_id user_id]
  end
end
