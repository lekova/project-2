class LoansController < ApplicationController

  def index
    if params[:limit]
      loans = current_user ? current_user.loans : []
    end

    render json: loans
  end

  def show
    render json: Loan.find(params[:id])
  end

  def show_my_loans
    render json: Loan.find_by(loan_params_with_user_id["owner_id"])
  end

  def create
    byebug
    loan = Loan.create(loan_params_with_user_id)
    if loan.save!
      render json: loan
    else
      render json: loan.errors, status: :unprocessable_entity
    end
  end

  def update
    loan = Loan.find(params[:id])
    if loan.update!(loan_params)
      render json: loan
    else
      render json: loan.errors, status: :unprocessable_entity
    end
  end

  def destroy
    loan = Loan.find(params[:id])
    loan.destroy!
  end

  private
  def loan_params
    params.require(:loan).permit(:id, :borrower_id, :book_id, :date_loaned, :loan_duration)
  end

  def loan_params_with_user_id
    current_params = loan_params
    current_params["loaner_id"] = current_user.id
    current_params
  end
end
