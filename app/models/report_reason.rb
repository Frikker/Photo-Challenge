# == Schema Information
#
# Table name: report_reasons
#
#  id           :bigint           not null, primary key
#  reason_class :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  from_id      :bigint           not null
#  reason_id    :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_report_reasons_on_from_id                            (from_id)
#  index_report_reasons_on_reason_id                          (reason_id)
#  index_report_reasons_on_reason_id_and_from_id_and_user_id  (reason_id,from_id,user_id)
#  index_report_reasons_on_user_id                            (user_id)
#
class ReportReason < ApplicationRecord
  belongs_to :user
  belongs_to :reason, class_name: 'Photopost', optional: true
  belongs_to :reason, class_name: 'Comment', optional: true
  belongs_to :from, class_name: 'User'


end
