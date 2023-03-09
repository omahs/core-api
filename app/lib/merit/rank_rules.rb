module Merit
  class RankRules
    include Merit::RankRulesMethods

    def initialize
      (1..20).each do |level|
        set_rank level:, to: User.all do |user|
          user.points > level * 7.87
        end
      end
    end
  end
end
