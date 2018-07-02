# frozen_string_literal: true

namespace :update do

  task :role, [:role] => :environment do |_task, args|
    p Employee.find_by(email: ENV['LEAD_EMAIL']).update_attributes!(role: args[:role])
  end
end
