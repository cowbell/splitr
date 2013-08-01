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

  private

  def budget
    @budget ||= current_user.budgets.find(params[:budget_id])
  end

  def transaction_params
    @transaction_params ||= params.require(:transaction).permit(:description, :amount, participant_ids: []).tap do |params|
      params[:participant_ids] = (params[:participant_ids] || []).map(&:to_i) & budget.members.pluck(:id)
    end
  end
end
