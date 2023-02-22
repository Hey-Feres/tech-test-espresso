RSpec.shared_examples 'Set MFA verified cookie' do
	it 'should return 401 status code' do
    post action, params: {code: totp.now}
    cookies[:mfa_verified].should be_present
	end
end

RSpec.shared_examples 'Redirect to mfa_new_path after post request' do
  it 'redirects to mfa_new_path' do
    post action, params: {code: totp.now}
    response.should redirect_to(mfa_new_path)
  end
end

RSpec.shared_examples 'Redirect to mfa_new_path after put request' do
  it 'redirects to mfa_new_path' do
    put action, params: {code: totp.now}
    response.should redirect_to(mfa_new_path)
  end
end