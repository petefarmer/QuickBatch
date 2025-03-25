class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_account, only: [:index, :new, :create], if: :account_id?

  def index
    @transactions = if @account
      @account.transactions
    else
      Transaction.all
    end
  end

  def show
  end

  def new
    @transaction = if @account
      @account.transactions.build
    else
      Transaction.new
    end
  end

  def edit
  end

  def create
    @transaction = if @account
      @account.transactions.build(transaction_params)
    else
      Transaction.new(transaction_params)
    end

    if @transaction.save
      redirect_to @account ? account_transactions_path(@account) : transactions_path, 
                  notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction.account ? account_transactions_path(@transaction.account) : transactions_path,
                  notice: 'Transaction was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    account = @transaction.account
    @transaction.destroy
    redirect_to account ? account_transactions_path(account) : transactions_path,
                notice: 'Transaction was successfully destroyed.'
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def account_id?
    params[:account_id].present?
  end

  def transaction_params
    params.require(:transaction).permit(:date, :description, :amount, :transaction_type, :account_id)
  end
end
