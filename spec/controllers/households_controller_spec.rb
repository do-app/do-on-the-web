require 'rails_helper'

describe HouseholdsController do 
  before :each do 
    @test_head_of_household = create(:user)
    @test_household = create(:household, head_of_household: @test_head_of_household)
    @test_member = create(:user)
    @test_household.members << @test_head_of_household
    @test_household.members << @test_member
    @test_non_member = create(:user)
  end

  describe 'GET#index' do 

    context 'when user is logged in' do 
      before :each do 
        stub_current_user(@test_non_member)
        stub_authorize_user!
      end
      it 'renders the index template' do 
        get :index
        expect(response).to render_template :index
      end
    end

    context 'when user is not logged in ' do 
      it 'redirects to the home page' do 
        get :index
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'GET#new' do 

    context 'when user is logged in' do 
      before :each do 
        stub_current_user(@test_non_member)
        stub_authorize_user!
      end

      it 'assigns a new Household to @household' do 
        get :new
        expect(assigns(:household)).to be_a_new(Household) 
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    context 'when user is not logged in ' do 
      it 'redirects to the home page' do 
        get :new
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'POST#create' do 
    context 'when user is logged in and not yet a member of a household' do 
      before :each do 
        stub_current_user(@test_non_member)
        stub_authorize_user!
      end

      xit 'saves a household with valid attributes' do 
      end

      xit 'does not save a household with invalid attributes' do 
      end

      xit 'sets the user as head of household' do 
      end

      xit 'sets the user as a member of the household' do 
      end
    end

    context 'when user is logged in and already a member of a household' do 
      before :each do 
        stub_current_user(@test_member)
        stub_authorize_user!
      end

      xit 'does not save the household' do 
      end

      xit 'does not change the household membership of the user' do 
      end
    end

    context 'when user is not logged in ' do 
      it 'redirects to the home page' do 
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end


  describe 'GET#show' do 

    context 'when member of household is logged in' do 
      before :each do 
        stub_current_user(@test_member)
        stub_authorize_user!
      end

      it 'assigns the correct Household to @household' do 
        get :show, id: @test_household
        expect(assigns(:household)).to eq(@test_household) 
      end

      it 'renders the :show template' do
        get :show, id: @test_household
        expect(response).to render_template :show
      end
    end

    context 'when non-member of household is logged in' do 
      before :each do 
        stub_current_user(@test_non_member)
        stub_authorize_user!
      end

      it 'redirects to the user page' do 
        get :show, id: @test_household
        expect(response).to redirect_to user_path(@test_non_member)
      end
    end


    context 'when user is not logged in' do 
      it 'redirects to the home page' do 
        get :show, id: @test_household
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET#edit' do 

    context 'when head of household is logged in' do 
      before :each do 
        stub_current_user(@test_head_of_household)
        stub_authorize_user!
      end

      it 'assigns the correct Household to @household' do 
        get :edit, id: @test_household
        expect(assigns(:household)).to eq(@test_household) 
      end

      it 'renders the :edit template' do
        get :edit, id: @test_household
        expect(response).to render_template :edit
      end
    end

    context 'when member is logged in' do
      before :each do 
        stub_current_user(@test_member)
        stub_authorize_user!
      end

      it 'redirects to the user page' do 
        get :edit, id: @test_household
        expect(response).to redirect_to user_path(@test_member)
      end
    end

    context 'when user is not logged in ' do 
      it 'redirects to the home page' do 
        get :edit, id: @test_household
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'PATCH#update' do
    before :each do 
      @old_name = @test_household.name
      @new_name = "NEWWNAME!"
    end

    context 'when head of household is logged in' do 
      before :each do 
        stub_current_user(@test_head_of_household)
        stub_authorize_user!
      end

      it 'saves changes to the household with valid attributes' do 
        patch :update, id: @test_household,
        household: attributes_for(:household,
          name: @new_name)
        @test_household.reload
        expect(@test_household.name).to eq(@new_name)
      end

      it 'does not save changes to household with invalid attributes' do 
        patch :update, id: @test_household,
        household: attributes_for(:household,
          name: nil)
        @test_household.reload
        expect(@test_household.name).to eq(@old_name)
      end
    end

    context 'when household member is logged in ' do 
      before :each do 
        stub_current_user(@test_member)
        stub_authorize_user!
      end

      it 'does not save the changes to the database' do 
        patch :update, id: @test_household,
        household: attributes_for(:household,
          name: @new_name)
        @test_household.reload
        expect(@test_household.name).to eq(@old_name)
      end

      it 'renders a flash error' do 
        patch :update, id: @test_household,
        household: attributes_for(:household,
          name: @new_name)
        expect(flash[:error]).to be_present
      end
    end

  end

  describe 'GET#search' do 

    context 'when user is logged in 'do 
      before :each do 
        stub_current_user(@test_non_member)
        stub_authorize_user!
      end

      xit 'assigns household(s) with names matching the search query to @households' do 
      end

      xit 'does not assign any households @households if none were found' do 
      end

      xit 'does not assign any households to @households if no search query' do 
      end

      xit 'does not assign incorrect households to @households' do 
      end

      xit 'renders the results template' do 
      end
    end

    context 'when user is not logged in 'do 
      it 'redirects to the home page' do 
        get :edit, id: @test_household
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PUT#join' do

    context 'when user is logged in and not yet a member of a household' do 
      before :each do 
        stub_current_user(@test_non_member)
        stub_authorize_user!
      end

      it 'makes the user a member of the household' do 
        put :join, id: @test_household
        @test_non_member.reload
        @test_household.reload
        expect(@test_non_member.household).to eq @test_household
        expect(@test_household.members).to include @test_non_member
      end

      it 'redirects to the household page' do 
        put :join, id: @test_household
        expect(response).to redirect_to household_path(@test_household)
      end
    end

    context 'when user is logged in and already a member of a household' do 
      before :each do 
        stub_current_user(@test_member)
        stub_authorize_user!
        @new_household = create(:household, head_of_household: create(:user))
      end

      it 'does not change which household the user belongs to' do
        put :join, id: @new_household
        @test_member.reload
        expect(@test_member.household).to eq(@test_household)
      end

      it 'does not add the user to the household as a member' do 
        put :join, id: @new_household
        @new_household.reload
        expect(@new_household.members).to_not include @test_member
      end

      it 'renders a flash error notice' do
        put :join, id: @new_household
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'PUT#leave' do 

    context 'when user is logged in and not yet a member of a household' do 
      before :each do 
        stub_current_user(@test_non_member)
        stub_authorize_user!
      end

      xit 'does not change which household the user belongs to' do 
      end

      xit 'redirects to the household page' do 
      end

      xit 'renders a flash error notice' do 
      end
    end

    context 'when user is logged in and already a member of a household' do 
      before :each do 
        stub_current_user(@test_member)
        stub_authorize_user!
      end

      xit 'changes the household the user belongs to to nil' do 
      end

      xit 'does removes the user to the household as a member' do 
      end

      xit 'redirects to the user page' do 
      end
    end

    context 'when user is not logged in 'do 
      xit 'renders a flash error notice' do 
      end
    end
  end

  describe 'DELETE#destroy' do 

    context 'when user is logged in and is the head of household' do 
      before :each do 
        stub_current_user(@test_head_of_household)
        stub_authorize_user!
      end

      xit 'removes the household from the database' do 
      end

      xit 'does removes the user from the household as a member' do 
      end

      xit 'it removes all other members of the household as a member' do 
      end

      xit 'redirects to the user page' do 
      end
    end

    context 'when user is logged in and not the head of houshold' do 
      before :each do 
        stub_current_user(@test_member)
        stub_authorize_user!
      end

      xit 'does not destroy the household' do 
      end

      xit 'does not change membership of any household members' do 
      end

      xit 'does not make any changes to the household' do 
      end

      xit 'redirects to the household page' do 
      end

      xit 'renders a flash error notice' do 
      end
    end

    context 'when user is not logged in 'do 
      xit 'renders a flash error notice' do 
      end
    end

  end

end