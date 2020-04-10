# frozen_string_literal: true

RSpec.shared_examples 'authorizable' do
  before { sign_in admin }

  it 'check permissions' do
    expect(controller).to receive(:authorize).with(*target).and_call_original
  end

  after { send_request }
end

RSpec.shared_examples 'unauthenticated' do
  it { expect(response).to have_http_status(302) }
  it { expect(response).to redirect_to new_employee_session_path }
end

RSpec.shared_examples 'unauthorized' do
  before { send_request }

  it { expect(flash[:warning]).to eq 'You are not authorized to perform this action.' }
  it { expect(response).to redirect_to(employee_path(user)) }
end

RSpec.shared_examples 'success response' do
  it { expect(flash[:success]).to eq message }
  it { expect(response).to have_http_status(302) }
  it { expect(response).to redirect_to(path) }
end