# frozen_string_literal: true

namespace :invite_employees do

  task invite: :environment do
    puts 'Invited all' if Employee.all.each(&:deliver_invitation)
  end
end
