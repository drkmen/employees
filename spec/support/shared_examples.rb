# frozen_string_literal: true

RSpec.shared_examples 'unauthenticated' do
  it { expect(response).to have_http_status(302) }
  it { expect(response).to redirect_to new_employee_session_path }
end

RSpec.shared_examples 'unauthorized' do
  before { send_request }

  it { expect(flash[:warning]).to eq 'You are not authorized to perform this action.' }
  it { expect(response).to redirect_to(employee_path(user)) }
end
