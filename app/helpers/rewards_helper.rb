module RewardsHelper
  def points_until_reward (reward)
    current_user.points < reward.points ? (current_user.points - reward.points).abs : 0
  end
end
