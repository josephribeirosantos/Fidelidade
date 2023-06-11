*** Settings ***
Documentation    Essa suíte testa o site da Fidelidade.com.br
Resource    ../data/fidelidade_resources.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador


*** Test Cases ***
Caso de Teste 01 - Acesso ao menu "Particulares"
    [Documentation]    Esse teste solicita uma cotação no menu particulares do site da Fidelidade.com.br
    ...                e visualiza o retorno dessa cotação
    [Tags]             menus  categorias
    Dado que estou na home page do site Fidelidade.com.br
    Verificar se o título da página fica "Fidelidade | Nº 1 em Seguros Automóvel, Saúde, Casa e Viagem"
    Quando acessar o menu "Particulares"
    Entrar no menu "Auto"
    Entrar no submenu "Auto1|2|3|4"
    E clicar no botão "Quero Simular"
    E entrar com o número da "${MATRICULA}" matricula
    E clicar na opção "FAÇA UMA SIMULAÇÃO MAIS PERSONALIZADA"

    ${NOME}    FakerLibrary.FirstName
    ${SOBRENOME}     FakerLibrary.lastName
    Entrar com o NOME "${NOME}" 

    ${NIF}    Gerar NIF Válido
    Log    Número de Identificação Fiscal gerado: ${NIF}
    Preencher Dados    ${NIF}

    Clicar no botão CONTINUAR da page NOME e NIF
    
    E entrar com a Data de Nascimento "${DATANASC}", Género "${GENERO}", Data de Carta de Condução "${DT_CARTA_CONDUCAO}", Código Postal "${CODIGO_POSTAL}"
    E clicar na opção "CONTINUAR SEM AGENTE"
    ${email}    FakerLibrary.FreeEmail
    Entrar com o E-mail "${email}", Telemovel "${TELEMOVEL}", marcar "${DADOS_PRIVACIDADE}" para os dados e clicar no CONTINUAR
    Clicar no button CONTINUE
    Então escolher a versão do veículo, e clique no botão CONTINUAR
    E clicar na opção "Não", para Seguro extra
    E clicar na opção "Não", para Reboque e Atrelado
    E clicar na opção CONTINUAR
    E clicar na opção "Fins particulares", para Uso do veículo e em CONTINUAR
    E clicar em CONTINUAR, para a opção "Não tenho seguro"
    E clicar em CONTINUAR, para ja temos uma proposta para o seu veículo
    Então validar que foi exibido uma cotação de seguro AUTO