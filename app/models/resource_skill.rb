class ResourceSkill < ApplicationRecord
  belongs_to :skill, optional: true
  belongs_to :project, optional: true
  belongs_to :employee, optional: true
end
