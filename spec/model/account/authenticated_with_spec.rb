require 'spec_helper'

describe Account, '#authenticated_with?' do
  let(:account) { Account.create! }

  before do
    account.authentications.create! provider: 'twitter'
  end

  it 'return if there is an authentication with a given provider' do
    account.authenticated_with?('twitter').should be_true
    account.authenticated_with?('facebook').should be_false
  end
end
