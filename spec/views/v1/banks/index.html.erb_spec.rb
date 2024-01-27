require 'rails_helper'

RSpec.describe "v1/banks/index", type: :view do
  it 'renders the index template' do
    assign(:banks, [])

    render
    expect(view).to render_template('index')
    expect(rendered).to have_selector('h1', text: 'Banks')
    expect(rendered).to render_template(partial: 'v1/banks/_banks_table')
    expect(rendered).to have_link('New Bank', href: new_v1_bank_path)
  end

  it 'renders the index template with banks' do
    bank = FactoryBot.create(:bank)
    assign(:banks, [bank])

    render
    expect(view).to render_template('index')
    expect(rendered).to have_selector('h1', text: 'Banks')
    expect(rendered).to render_template(partial: 'v1/banks/_banks_table')
    expect(rendered).to have_link('New Bank', href: new_v1_bank_path)
  end
end