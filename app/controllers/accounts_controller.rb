class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :set_date_params, only: [:index, :balance_sheet, :income_statement, :cash_flow, :ebitda]

  def index
    @accounts = Account.all
    @balance_sheet = FinancialReportService.get_balance_sheet(@date)
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
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.current
    @report = FinancialReportService.get_balance_sheet(@date)
    @report_type = :balance_sheet
    render template: 'reports/report'
  end

  def income_statement
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.current.beginning_of_month
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.current.end_of_month
    @report = FinancialReportService.get_income_statement(@start_date, @end_date)
    @report_type = :income_statement
    render template: 'reports/report'
  end

  def cash_flow
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.current.beginning_of_month
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.current.end_of_month
    @report = FinancialReportService.get_cash_flow(@start_date, @end_date)
    @report_type = :cash_flow
    render template: 'reports/report'
  end

  def ebitda
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.current.beginning_of_month
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.current.end_of_month
    @report = FinancialReportService.get_ebitda(@start_date, @end_date)
    @report_type = :ebitda
    render template: 'reports/report'
  end

  private

  def set_date_params
    @date = if params[:date].present?
              begin
                Date.parse(params[:date])
              rescue ArgumentError
                Date.current
              end
            else
              Date.current
            end

    @start_date = if params[:start_date].present?
                    begin
                      Date.parse(params[:start_date])
                    rescue ArgumentError
                      @date.beginning_of_month
                    end
                  else
                    @date.beginning_of_month
                  end

    @end_date = if params[:end_date].present?
                  begin
                    Date.parse(params[:end_date])
                  rescue ArgumentError
                    @date
                  end
                else
                  @date
                end
  end

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :account_type, :description, :parent_id, :number)
  end
end
