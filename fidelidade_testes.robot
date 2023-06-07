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
    Acessar a home page do site Fidelidade.com.br
    Verificar se o título da página fica "Fidelidade | Nº 1 em Seguros Automóvel, Saúde, Casa e Viagem"
    Entrar no menu "Particulares"
    Entrar no menu "Auto"
    Entrar no submenu "Auto1|2|3|4"
    Clicar no botão "Quero Simular"
    Entrar com o número da "${MATRICULA}" matricula
    Clicar na opção "FAÇA UMA SIMULAÇÃO MAIS PERSONALIZADA"
    Entrar com o NOME "${NOME}"e o NIF "${NIF}" e botão CONTINUAR
    Entrar com a Data de Nascimento "${DATANASC}", Género "${GENERO}", Data de Carta de Condução "${DT_CARTA_CONDUCAO}", Código Postal "${CODIGO_POSTAL}"
    Clicar na opção "CONTINUAR SEM AGENTE"
    Entrar com o E-mail "${EMAIL_TESTE}", Telemovel "${TELEMOVEL}", marcar "${DADOS_PRIVACIDADE}" para os dados e clicar no botão CONTINUAR
   # Clicar no botão CONTINUAR
    Escolher a versão do veículo, e clique no botão CONTINUAR
    Clicar na opção "Não", para Seguro extra
    Clicar na opção "Não", para Reboque e Atrelado
    Clicar na opção CONTINUAR
    Clicar na opção "Fins particulares", para Uso do veículo e em CONTINUAR
    Clicar em CONTINUAR, para a opção "Não tenho seguro"
    Clicar em CONTINUAR, para ja temos uma proposta para o seu veículo
    Validar que foi exibido uma cotação de seguro AUTO