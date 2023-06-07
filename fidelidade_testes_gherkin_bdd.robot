*** Settings ***
Documentation    Essa suíte testa o site da Fidelidade.com.br
Resource         fidelidade_resources.robot
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
    E entrar com o NOME "${NOME}"e o NIF "${NIF}" e botão CONTINUAR
    E entrar com a Data de Nascimento "${DATANASC}", Género "${GENERO}", Data de Carta de Condução "${DT_CARTA_CONDUCAO}", Código Postal "${CODIGO_POSTAL}"
    E clicar na opção "CONTINUAR SEM AGENTE"
    E entrar com o E-mail "${EMAIL_TESTE}", Telemovel "${TELEMOVEL}", marcar "${DADOS_PRIVACIDADE}" para os dados e clicar no botão CONTINUAR
   # Clicar no botão CONTINUAR
    Então escolher a versão do veículo, e clique no botão CONTINUAR
    E clicar na opção "Não", para Seguro extra
    E clicar na opção "Não", para Reboque e Atrelado
    E clicar na opção CONTINUAR
    E clicar na opção "Fins particulares", para Uso do veículo e em CONTINUAR
    E clicar em CONTINUAR, para a opção "Não tenho seguro"
    E clicar em CONTINUAR, para ja temos uma proposta para o seu veículo
    Então validar que foi exibido uma cotação de seguro AUTO