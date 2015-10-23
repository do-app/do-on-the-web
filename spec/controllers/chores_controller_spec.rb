require 'rails_helper'

describe ChoresController do 
  before :each do 
    @test_head_of_household = create(:user)
    @test_member = create(:user)
    @test_household = create(:household, )
  end

  describe 'head of household access' do
    before :each do 
      stub_current_user(@test_head_of_household)
      stub_authorize_user!
    end
  end

  describe 'household member access' do 
    before :each do 
      stub_current_user(@test_member)
      stub_authorize_user!
    end
  end

  describe 'non member access' do 
    before :each do 
      stub_current_user(@test_non_member)
      stub_authorize_user!
    end
  end

  describe 'guest access' do 
    describe 'GET#index' do 
    end
  end

end