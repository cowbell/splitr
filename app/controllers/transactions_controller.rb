class TransactionsController < ApplicationController
  def new
    authorize! :manage, Budget
    @transaction = budget.transactions.build
  end

  def create
    authorize! :manage, Budget
    @transaction = budget.transactions.build(transaction_params)
    if @transaction.save
      redirect_to budget_path(budget), notice: "Transaction has been successfully added."
    else
      render :new
    end
  end

  def edit
    authorize! :manage, Budget
    @transaction = budget.transactions.find(params[:id])
  end

  def update
    authorize! :manage, Budget
    @transaction = budget.transactions.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to budget_path(budget), notice: "Transaction has been successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize! :manage, Budget
    @transaction = budget.transactions.find(params[:id])
    @transaction.destroy
    redirect_to budget_path(budget), notice: "Transaction has been successfully destroyed."
  end

  private

  def budget
    @budget ||= current_user.budgets.find(params[:budget_id])
  end

  def transaction_params
    @transaction_params ||= params.require(:transaction).permit(:description, :issued_on, :amount, participant_ids: []).tap do |params|
      params[:participant_ids] = (params[:participant_ids] || []).map(&:to_i) & budget.members.pluck(:id)
    end
  end
end
