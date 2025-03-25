class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def show
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully deleted.'
  end

  def balance_sheet
    @date = Date.current
    @report = FinancialReportService.generate_balance_sheet(@date)
    render 'reports/balance_sheet'
  end

  def income_statement
    @start_date = Date.current.beginning_of_month
    @end_date = Date.current
    @report = FinancialReportService.generate_income_statement(@start_date, @end_date)
    render 'reports/income_statement'
  end

  def cash_flow
    @start_date = Date.current.beginning_of_month
    @end_date = Date.current
    @report = FinancialReportService.generate_cash_flow(@start_date, @end_date)
    render 'reports/cash_flow'
  end

  def ebitda
    @start_date = Date.current.beginning_of_month
    @end_date = Date.current
    @report = FinancialReportService.generate_ebitda(@start_date, @end_date)
    render 'reports/ebitda'
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :account_type, :number, :description, :parent_id)
  end
end
