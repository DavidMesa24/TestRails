require 'rails_helper'

RSpec.describe "v1/banks/edit", type: :view do
  it 'render the edit template with form and back link' do
    bank = FactoryBot.create(:bank)
    assign(:bank, bank)

    render
    expect(rendered).to have_selector('h1', text: 'Edit Bank')
    expect(rendered).to render_template(partial: '_form')
    expect(rendered).to have_link('Back', href: v1_banks_path)
  end
end