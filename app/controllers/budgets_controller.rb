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

  def show
    authorize! :read, Budget
    @budget = current_user.budgets.find(params[:id])
  end

  def edit
    authorize! :update, Budget
    @budget = current_user.budgets.find(params[:id])
  end

  def update
    authorize! :update, Budget
    @budget = current_user.budgets.find(params[:id])
    if @budget.update(budget_params)
      redirect_to budgets_path, notice: "Budget has been successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, Budget
    @budget = current_user.budgets.find(params[:id])
    @budget.destroy
    redirect_to budgets_path, notice: "Budget has been successfully removed."
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :currency, :precision)
  end
end
