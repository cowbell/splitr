class BudgetsController < ApplicationController
  def new
    @budget = Budget.new
    authorize! :create, @budget
  end

  def create
    @budget = Budget.new
    authorize! :create, @budget
    if @budget.update(budget_params)
      redirect_to root_url, notice: "Budget has been successfully created."
    else
      render "new"
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:name)
  end
end
