RSpec.shared_examples 'unauthenticated' do
  it { expect(response).to have_http_status(302) }
  it { expect(response).to redirect_to new_employee_session_path }
end

RSpec.shared_examples 'unauthorized' do
  it 'raises an error' do
    expect { send_request }.to raise_error Pundit::NotAuthorizedError
  end
end