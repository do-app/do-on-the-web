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

  describe 'head of household access' do
    before :each do 
      stub_current_user(@test_head_of_household)
      stub_authorize_user!
    end

    describe 'GET#edit' do 
      it 'assigns the correct Household to @household' do 
        get :edit, id: @test_household
        expect(assigns(:household)).to eq(@test_household) 
      end

      it 'renders the :edit template' do
        get :edit, id: @test_household
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH#update' do 
      before :each do 
        @old_name = @test_household.name
        @new_name = @test_household.name
        while @new_name == @old_name do 
          @new_name = Faker::Team.name
        end
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
        household: attributes_for(:invalid_household)
        @test_household.reload
        expect(@test_household.name).to eq(@old_name)
      end
    end

    describe 'PUT#leave' do 
    end

    describe 'DElETE#destroy' do 
      it 'removes the household from the database' do
        expect{
          delete :destroy, id: @test_household
        }.to change(Household, :count).by(-1)
      end

      it 'removes the user from the household as a member' do 
        delete :destroy, id: @test_household
        @test_head_of_household.reload
        expect(@test_head_of_household.household).to eq(nil)
        expect(@test_head_of_household.households_is_head_of).to be_empty
      end

      it 'it removes all other members of the household as a member' do 
        delete :destroy, id: @test_household
        @test_member.reload
        expect(@test_member.household).to eq(nil)
      end

      it 'redirects to the root path' do 
        delete :destroy, id: @test_household
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'household member access' do 
    before :each do 
      stub_current_user(@test_member)
      stub_authorize_user!
    end

    describe 'POST#create' do 
      it 'does not save the household' do 
        expect{
          post :create, household: attributes_for(:household)
        }.to_not change(Household, :count)
      end

      it 'does not change the household membership of the user' do 
        post :create, household: attributes_for(:household)
        @test_member.reload
        expect(@test_member.household).to eq @test_household
      end

      it 'renders a flash error notice' do 
        post :create, household: attributes_for(:household)
        expect(flash[:error]).to be_present
      end
    end

    describe 'GET#show' do 
      it 'assigns the correct Household to @household' do 
        get :show, id: @test_household
        expect(assigns(:household)).to eq(@test_household) 
      end

      it 'renders the :show template' do
        get :show, id: @test_household
        expect(response).to render_template :show
      end
    end

    describe 'GET#edit' do 
      it 'redirects to the user page' do 
        get :edit, id: @test_household
        expect(response).to redirect_to user_path(@test_member)
      end
    end

    describe 'PATCH#update' do
      before :each do 
        @old_name = @test_household.name
        @new_name = @test_household.name
        while @new_name == @old_name do 
          @new_name = Faker::Team.name
        end
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

    describe 'PUT#join' do 
      before :each do 
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

    describe 'PUT#leave' do 
      it 'removes user from the household' do 
        put :leave, id: @test_household
        @test_member.reload
        @test_household.reload
        expect(@test_member.household).to eq nil
        expect(@test_household.members).to_not include @test_member
      end

      it 'redirects to the user page' do 
        put :leave, id: @test_household
        expect(response).to redirect_to user_path(@test_member)
      end
    end

    describe 'DELETE#destroy' do 
      it 'does not destroy the household' do 
        expect{
          delete :destroy, id: @test_household
        }.to_not change(Household, :count)
      end

      it 'does not change membership of any household members' do 
        delete :destroy, id: @test_household
        @test_head_of_household.reload
        @test_member.reload
        expect(@test_head_of_household.household).to eq @test_household
        expect(@test_member.household).to eq @test_household
      end

      it 'redirects to the household page' do 
        delete :destroy, id: @test_household
        expect(response).to redirect_to household_path(@test_household)
      end

      it 'renders a flash error notice' do 
        delete :destroy, id: @test_household
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'non member access' do 
    before :each do 
      stub_current_user(@test_non_member)
      stub_authorize_user!
    end

    describe 'GET#index' do 
      it 'renders the index template' do 
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET#new' do 
      it 'assigns a new Household to @household' do 
        get :new
        expect(assigns(:household)).to be_a_new(Household) 
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST#create' do 
       it 'saves a household with valid attributes' do 
        expect{
          post :create, household: attributes_for(:household)
        }.to change(Household, :count).by(1)
      end

      it 'does not save a household with invalid attributes' do 
        expect{
          post :create, household: attributes_for(:invalid_household)
        }.to_not change(Household, :count)
      end

      it 'sets the user as head of household' do 
        post :create, household: attributes_for(:household)
        @test_non_member.reload
        expect(@test_non_member.households_is_head_of.length).to eq(1)
      end

      it 'sets the user as a member of the household' do 
        post :create, household: attributes_for(:household)
        @test_non_member.reload
        expect(@test_non_member.household).to_not eq(nil)
      end
    end

    describe 'GET#show' do     
      it 'redirects to the user page' do 
        get :show, id: @test_household
        expect(response).to redirect_to user_path(@test_non_member)
      end
    end

    describe 'GET#search' do
      it 'assigns household(s) with names matching the search query to @households' do 
        get :search, search: @test_household.name
        expect(assigns(:households)).to include @test_household
      end

      it 'does not assign any households to @households if none were found' do 
        query = @test_household.name
        while query == @test_household.name do 
          query = Faker::Team.name
        end
        get :search, search: query
        expect(assigns(:households)).to be_empty 
      end

      it 'does not assign any households to @households if no search query' do
        get :search, search: nil
        expect(assigns(:households)).to eq(nil)
      end

      it 'does not assign incorrect households to @households' do 
        new_household = create(:household, head_of_household: create(:user))
        query = new_household.name
        while query == new_household.name do 
          query = Faker::Team.name
        end
        get :search, search: query
        expect(assigns(:households)).to_not include new_household
      end

      it 'renders the results template' do 
        get :search, search: @test_household.name
        expect(response).to render_template :search
      end
    end

    describe 'PUT#join' do 
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

    describe 'PUT#leave' do
      it 'does not change which household the user belongs to' do
        put :leave, id: @test_household 
        @test_non_member.reload
        expect(@test_non_member.household).to eq(nil)
      end

      it 'renders a flash error notice' do 
        put :leave, id: @test_household 
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'guest access' do 
    describe 'GET#index' do 
      it 'redirects to the home page' do 
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET#new' do 
      it 'redirects to the home page' do 
        get :new
        expect(response).to redirect_to root_path
      end
    end

    describe 'POST#create' do 
      it 'redirects to the home page' do 
        get :new
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET#show' do 
      it 'redirects to the home page' do 
        get :show, id: @test_household
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET#edit' do 
      it 'redirects to the home page' do 
        get :edit, id: @test_household
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET#search' do
      it 'redirects to the home page' do 
        get :search, search: @test_household.name
        expect(response).to redirect_to root_path
      end
    end
  end

end