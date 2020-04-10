# frozen_string_literal: true

module CommonHelpers
  module_function

  extend ActionDispatch::TestProcess

  def open_file_by_name(filename)
    open_file(file_path(filename))
  end

  def upload_file(filename, type)
    fixture_file_upload(file_path(filename), type)
  end

  def open_file(path)
    File.open(path)
  end

  def file_path(filename)
    Rails.root.join('spec', 'support', 'files', filename)
  end

  def base64(filename)
    Base64.encode64(open_file_by_name(filename).read)
  end

  def employee_roles
    Employee::ROLES.map(&:to_s)
  end

  def adminable_roles
    employee_roles - common_roles
  end

  def common_roles
    employee_roles.without('admin', 'manager')
  end
end
