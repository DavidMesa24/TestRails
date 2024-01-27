class V1::BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :destroy, :update]

  def new
    @bank = Bank.new
  end

  def index
    @banks = Bank.all.paginate(page: params[:page], per_page: 10)
    render :index, status: :ok
  end

  def show
    render :show
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      flash[:notice] = (I18n.t('success.banks.created_success'))
      redirect_to v1_banks_path
    else
      with_error_handling { render :new, status: :unprocessable_entity }
    end
  end

  def edit
    render :edit
  end

  def update
    if @bank.update(bank_params)
      flash[:notice] = I18n.t('success.banks.updated_success')
      redirect_to v1_banks_path
    else
      with_error_handling { render :edit, status: :unprocessable_entity }
    end
  end

  def destroy
    if @bank.bank_accounts.any?
      flash[:alert] = I18n.t('errors.banks.bank_not_empty')
      redirect_to v1_banks_path
    else
      @bank.destroy
      flash[:notice] = I18n.t('success.banks.deleted_success')
      redirect_to v1_banks_path
    end
  end

  private

  def bank_params
    params.require(:bank).permit(:name)
  end

  def set_bank
    @bank = Bank.find(params[:id])
  end
end
