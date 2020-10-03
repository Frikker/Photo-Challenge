# frozen_string_literal: true

module Users
  class Report < ActiveInteraction::Base
    integer :from_id
    integer :reason_id
    string :reason_class

    def execute
      report
    end

    private

    def report
      report_model = eval "#{reason_class}.find(#{reason_id})"
      report_user = report_model.user
      current_user = User.find(from_id)
      if current_user == report_user
        nil
      else
        report_user.report! unless report_user.aasm_state == 'reported'
        ReportReason.create!(reason_id: report_model.id, from_id: from_id, user_id: report_user.id,
                             reason_class: reason_class)
      end
    end
  end
end
