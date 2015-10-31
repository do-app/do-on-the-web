require 'rails_helper'

describe Household do 
  before (:each) do
    @user = create(:user)
    @household = create(:household, head_of_household: @user)
  end

  it "is valid with a head of household, members and no chores" do 
    expect(@household).to be_valid
  end

  it "is invalid with no name" do 
    @household.name = ''
    expect(@household).to be_invalid
  end

  it "is invalid with no head of household" do 
    @household.head_of_household = nil
    expect(@household).to be_invalid
  end

  it "automatically adds head of household to list of members" do 
    expect(@household.members).to include @user
  end

  it "returns the correct household when searched by name" do
    result = Household.search(@household.name)
    expect(result[0]).to eq(@household)
  end
end