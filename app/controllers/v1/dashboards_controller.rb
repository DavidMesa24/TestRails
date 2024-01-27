class V1::DashboardsController < ApplicationController
  def index
    @providers = Provider.count
    @banks = Bank.count
  end
end