require 'rails_helper'

RSpec.describe "v1/providers/index", type: :view do
  it 'renders the index template with a list of providers' do
    providers = FactoryBot.create_list(:provider, 1)

    assign(:providers, providers)

    render

    expect(rendered).to have_selector('h1', text: I18n.t('views.providers.header'))

    expect(rendered).to have_link(I18n.t('views.providers.new'), href: new_v1_provider_path)
  end
end