class V1::BanksController < ApplicationController

  before_action :set_bank, only: [:show, :edit, :destroy, :update]
  def new
    @bank = Bank.new
  end

  def index
    @banks = Bank.all
    render :index, status: :ok
  end

  def show
    with_error_handling { render :show }
  end

  def create
    @bank = Bank.new(bank_params)
    with_error_handling { render :show, status: :created } if @bank.save
  end

  def edit
    render :edit
  end

  def update
    if @bank.update(bank_params)
      flash[:notice] = 'Bank updated successfully.'
      redirect_to v1_banks_path
    else
      flash[:error] = @bank.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end



  def destroy
    with_error_handling { head :no_content } if @bank.destroy
  end

  private

  def bank_params
    params.require(:bank).permit(:name)
  end

  def set_bank
    @bank = Bank.find(params[:id])
  end

  def with_error_handling
    yield
  rescue ActiveRecord::RecordNotFound => e
    render json: handle_error(e, I18n.t('errors.record_not_found'), :not_found), status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: handle_error(e, I18n.t('errors.validation_error'), :unprocessable_entity), status: :unprocessable_entity
  rescue StandardError => e
    render json: handle_error(e, I18n.t('errors.general_error'), :internal_server_error), status: :internal_server_error
  end

  def handle_error(exception, message, status)
    Rails.logger.error("#{message}: #{exception.message}")
    { error: message }.merge!(status: status)
  end
end