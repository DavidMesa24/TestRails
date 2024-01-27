class V1::ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :destroy, :update]

  def index
    @providers = Provider.whit_bank_account.paginate(page: params[:page], per_page: 10)
    render :index, status: :ok
  end

  def show
    with_error_handling { render :show }
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    handle_response(@provider.save, 'success.providers.created_success', :new, v1_providers_path)
  end

  def edit
    render :edit
  end

  def update
    handle_response(@provider.update(provider_params), 'success.providers.updated_success', :edit, v1_providers_path)
  end

  def destroy
    @provider.destroy
    flash[:notice] = I18n.t('success.providers.deleted_success')
    redirect_to v1_providers_path
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:name, :nit, :contact_name, :contact_phone, bank_account_attributes: [:id, :bank_id, :account_number, :_destroy])
  end
end
