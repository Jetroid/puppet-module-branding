require 'spec_helper'
describe 'branding' do

  context 'with defaults for all parameters' do
    it { should contain_class('branding') }
  end
end
