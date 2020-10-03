# frozen_string_literal: true

module ReportWorker
  class DeleteReport
    include Sidekiq::Worker

    sidekiq_options retry: false

    def perform(report_id)
      report = ReportReason.find(report_id)
      report.destroy! unless report.nil?
    end
  end
end
