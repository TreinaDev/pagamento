require 'rails_helper'

feature 'Client access dashboard' do
  scenario 'successfully' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    create(:client_profile, client: client)

    visit root_path
    click_on 'Login'

    fill_in 'E-mail', with: client.email
    fill_in 'Senha', with: client.password

    click_on 'Log in'

    expect(current_path).to eq(client_dashboard_index_path)
  end

  scenario 'and shoud see profile' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    profile = create(:client_profile, client: client)

    login_as(client, scope: :client)
    visit client_dashboard_index_path

    click_on 'Perfil'

    expect(current_path).to eq(client_client_profile_path(profile))
  end

  scenario 'and shoud see payment methods' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    create(:client_profile, client: client)

    login_as(client, scope: :client)
    visit client_dashboard_index_path

    click_on 'Meios de Pagamento'

    expect(current_path).to eq(payment_methods_path)
  end

  scenario 'and shoud logout' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    create(:client_profile, client: client)

    login_as(client, scope: :client)
    visit client_dashboard_index_path

    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Login')
  end

  scenario 'and try to access dashboard without a login client' do
    visit client_dashboard_index_path

    expect(current_path).to eq(client_session_path)
  end
end
