# frozen_string_literal: true

json.set! :employee do
  json.extract! @employee, :first_name, :last_name, :role, :main_skill,
                :description, :additional
  json.skills @employee.skills do |skill|
    json.extract! skill, :skill_type, :name
  end
  json.projects @employee.projects do |project|
    json.extract! project, :name, :description, :start_date, :end_date,
                  :client, :link
    json.skills project.skills do |skill|
      json.extract! skill, :skill_type, :name
    end
  end
end