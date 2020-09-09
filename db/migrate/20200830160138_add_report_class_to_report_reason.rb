class AddReportClassToReportReason < ActiveRecord::Migration[6.0]
  def change
    add_column :report_reasons, :reason_class, :string
  end
end
