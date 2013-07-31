class BudgetsController < ApplicationController
  def index
    authorize! :read, Budget
    @budgets = current_user.budgets
  end

  def new
    @budget = Budget.new
    authorize! :create, @budget
  end

  def create
    @budget = Budget.new(budget_params)
    authorize! :create, @budget
    if BudgetCreator.create(@budget, current_user)
      redirect_to budgets_path, notice: "Budget has been successfully created."
    else
      render :new
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:name)
  end
end
