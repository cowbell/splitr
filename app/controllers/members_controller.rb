class MembersController < ApplicationController
  def new
    authorize! :manage, Budget
    @member = budget.members.build
  end

  def create
    authorize! :manage, Budget
    @member = budget.members.build(member_params)
    if @member.save
      redirect_to budget_path(budget), notice: "Member has been successfully added."
    else
      render :new
    end
  end

  private

  def budget
    @budget ||= current_user.budgets.find(params[:budget_id])
  end

  def member_params
    params.require(:member).permit(:name)
  end
end
