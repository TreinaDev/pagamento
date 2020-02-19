require 'rails_helper'

feature 'Client access dashboard' do
  scenario 'successfully' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    create(:client_profile, client: client)

    visit root_path
    click_on 'Login'

    fill_in 'E-mail', with: client.email
    fill_in 'Senha', with: '123teste@'
    click_on 'Log in'

    expect(current_path).to eq(payment_methods_path)
  end

  scenario 'and should see profile' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    profile = create(:client_profile, client: client)

    login_as(client, scope: :client)
    visit root_path

    click_on 'Meu Perfil'

    expect(current_path).to eq(client_client_profile_path(profile))
  end

  scenario 'and should see payment methods' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    create(:client_profile, client: client)

    login_as(client, scope: :client)
    visit root_path

    click_on 'Meios de pagamento'

    expect(current_path).to eq(payment_methods_path)
  end

  scenario 'and should logout' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    create(:client_profile, client: client)

    login_as(client, scope: :client)
    visit root_path

    click_on 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Login')
  end

  scenario 'and try to access dashboard without a login client' do
    visit client_dashboard_index_path

    expect(current_path).to eq(client_session_path)
  end
end
