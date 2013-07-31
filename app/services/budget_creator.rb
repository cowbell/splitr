module BudgetCreator
  def self.create(budget, user)
    ActiveRecord::Base.transaction do
      if budget.save
        Member.create!(budget: budget, user: user, name: user.name)
      end
    end
  end
end
