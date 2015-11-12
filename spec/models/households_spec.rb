require 'rails_helper'

describe Household do 
  before (:each) do
    @user = create(:user)
    @household = create(:household, head_of_household: @user)
    @chore = create(:chore, household: @household)
    5.times do 
      create(:chore, household: @household)
    end
    @user2 = create(:user, household: @household)
    @user2.chores << @chore
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

  it "returns the correct number of chores per member" do 
    expect(@household.max_chores_per_member).to eq 3
  end

  it "returns chores that have been assigned that week" do 
    expect(@household.assigned_chores).to eq [@chore]
  end

  it "returns chores that have not yet been assigned for the week" do 
    expect(@household.unassigned_chores).not_to include @chore
  end
end