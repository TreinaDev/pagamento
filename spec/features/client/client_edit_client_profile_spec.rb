require 'rails_helper'

feature 'Client edit a client profile' do
  scenario 'successfully' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    create(:client_profile, address: 'Rua A, 123',
                            phone: '(11)5566-2244',
                            manager: 'Fulano de Carvalho',
                            client: client)

    login_as(client, scope: :client)
    visit client_dashboard_index_path
    click_on 'Perfil'
    click_on 'Editar'

    fill_in 'Endereço', with: 'Rua B, 456'
    fill_in 'Telefone', with: '(11)2586-4789'
    fill_in 'Representante', with: 'Siclano da Silva'

    click_on 'Salvar'

    expect(page).to have_content('Endereço: Rua B, 456')
    expect(page).to have_content('Telefone: (11)2586-4789')
    expect(page).to have_content('Representante: Siclano da Silva')
  end

  scenario 'and try to access edit profile without a login client' do
    client = create(:client, email: 'teste@teste.com',
                             password: '123teste@')
    profile = create(:client_profile, client: client)

    visit edit_client_client_profile_path(profile)

    expect(current_path).to eq(client_session_path)
  end
end
