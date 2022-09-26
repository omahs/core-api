class RankRules
  include Merit::RankRulesMethods

  def initialize
    set_rank level: 1, to: User.all do |user|
      user.donations.count > 1
    end
  end
end
