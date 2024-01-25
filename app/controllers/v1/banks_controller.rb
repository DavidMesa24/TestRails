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
    if @bank.save
      flash[:notice] = 'Bank created successfully.'
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
      flash[:notice] = 'Bank updated successfully.'
      redirect_to v1_banks_path
    else
      with_error_handling { render :edit, status: :unprocessable_entity }
    end
  end



  def destroy
    @bank.destroy
    flash[:notice] = 'Bank deleted successfully.'
    redirect_to v1_banks_path
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
    handle_error(e, I18n.t('errors.record_not_found'), :not_found)
  rescue ActiveRecord::RecordInvalid => e
    handle_error(e, I18n.t('errors.validation_error'), :unprocessable_entity)
  rescue StandardError => e
    handle_error(e, I18n.t('errors.general_error'), :internal_server_error)
  end

  def handle_error(exception, message, status)
    Rails.logger.error("#{message}: #{exception.message}")

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('flash-container', partial: 'shared/flash') }
      format.html { flash[:error] = exception.message }
      format.json { render json: { error: message }, status: status }
    end
  end
end