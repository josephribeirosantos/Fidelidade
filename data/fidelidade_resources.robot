*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
#Library     FakerLibrary    locale=pt_PT    WITH NAME    Faker
Library     FakerLibrary    locale=pt_PT    
Library     String
Library     Collections
Library     BuiltIn
Library     random
##3...    /Users/josephsantos/Library/Python/3.9/lib/python/site-packages
###...     /Users/josephsantos/Library/Python/3.9/lib/python/site-packages
#Library     FakerLibrary     /Users/josephsantos/Library/Frameworks/Python.framework/Versions/3.11/Resources/Python.app/Contents/MacOS/Python
########Resource    settings.robot

#Elements
#${First_Name}  firstName
#${Last_Name}  lastName 
#${Email}   userEmail
#${MobileNumber}   userNumber
#####Resource    ../settings.robot

*** Variables ***
${BROWSER}                  chrome
${URL}                      https://www.fidelidade.pt/
${COOKIES_PRIVACIDADE}      //button[contains(.,'Aceitar Todos')]
${MENU_PARTICULARES}        //*[@id="header"]/div[1]/div[2]/div/div[1]/nav/a[1]
${SUBMENU_AUTO1234}         //*[@id="header"]/div[1]/div[2]/div/div[2]/nav/div[1]/div/ul[1]/li[3]/a
${BUTTON_QUERO_SIMULAR}     ctl00_PlaceHolderMain_EditModePanel2_ProductDescription_lnkSimulateLink
#${NOME}                     Oskulace Guago
#${NIF}                      234549696
${MATRICULA}                AA16AA  
${DATANASC}                 11091969
${GENERO}                   Masculino
${DT_CARTA_CONDUCAO}        11091999 
${CODIGO_POSTAL}            1500012
#${EMAIL}                   teste@teste1700.com
${TELEMOVEL}                935010988
${DADOS_PRIVACIDADE}        SIM

*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser


# Exemplo de uso de email aleatório
#     ${email}    Generate Random Email      testeemail@email.com
#     Log    Email gerado: ${email}

# Gerar Email Aleatório
#     # Gerar um novo e-mail pra inserir no campo e-mail
#     #${faker}= FakerLibrary.Create locale=pt_PT
#     ${palavra_aleatoria}  Generate Random String  Length=4  chars=[LETTERS] # Gera uma palavra aleatória com 4 letras em caixa baixa
#     ${palavra_aleatoria}  Convert To Lower Case   ${palavra_aleatoria}  # Concatena a palavra aleatória com o domínio de email
#     Set Test Variable    ${EMAIL_TESTE}   ${palavra_aleatoria}@emailteste.com
#     Set Suite Variable   ${EMAIL_TESTE} # Armazena o email em uma variável de suite para uso posterior
#     Log Email gerado: ${EMAIL_TESTE}

Acessar a home page do site Fidelidade.com.br
    Go To    url=${URL}
    Click Element    locator=${COOKIES_PRIVACIDADE}
    Wait Until Element Is Visible    locator=${MENU_PARTICULARES}
    Capture Page Screenshot	Fidelidade-com-br.png

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}
    Capture Page Screenshot	title.png

Entrar no menu "Particulares"
    Click Element    locator=${MENU_PARTICULARES}
    Capture Page Screenshot	menu_particulares.png

Entrar no menu "Auto"
    Mouse Over    css=a.header
    Capture Page Screenshot	auto.png

Entrar no submenu "Auto1|2|3|4"
    Click Link    link=Auto 1|2|3|4
    Capture Page Screenshot	auto1234.png

Clicar no botão "Quero Simular"
    Click Element    id=${BUTTON_QUERO_SIMULAR}
    Capture Page Screenshot	quero-simular.png

Entrar com o número da "${MATRICULA}" matricula
    Select Frame     //iframe[contains(@title,'Simulator')]
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt60$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCustomCard$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wt9$block$wtContent$Sim_Auto_Web_Pat_wtLicensePlateBlock$block$wtInputPlaceholder$wttxtRegNumber'][contains(@id,'wttxtRegNumber')]    text=${MATRICULA}
    Capture Page Screenshot	matricula.png
    Sleep    3s
    Click Element   xpath=//input[@type='submit'][contains(@id,'wtbtnNext')]
    
Clicar na opção "FAÇA UMA SIMULAÇÃO MAIS PERSONALIZADA"
    Sleep    1s
    Wait Until Page Contains    text=Este é um exemplo de pré-simulação para o veículo TESLA Model 3
    Click Element   xpath=//input[@type='submit'][contains(@id,'wt27')]
    Capture Page Screenshot	faca-simulacao-mais-personalizada.png
    Sleep    1s

Entrar com o NOME "${NOME}"
    Sleep    5s
    ${NOME}  FakerLibrary.FirstName
    ${SOBRENOME}  FakerLibrary.lastName
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt22$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt92$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wt25$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldName$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wtnameStatus$block$wtInput$wttxtName'][contains(@id,'wttxtName')]    text=${NOME} ${SOBRENOME}
    Capture Page Screenshot	name.png
    Sleep    3s

Gerar NIF Válido
    ${digits}    FakerLibrary.Numerify    '########'
    ${check_digit}    Gerar Dígito de Verificação    ${digits}
    ${nif}    Catenate    SEPARATOR=    ${digits}    ${check_digit}
    [Return]    ${nif}

Gerar Dígito de Verificação
    [Arguments]    ${digits}
    ${weights}    Create List    9    8    7    6    5    4    3    2
    ${sum}    Evaluate    sum(int(d) * int(w) for d, w in zip(str(${digits}), ${weights}))
    ${remainder}    Evaluate    ${sum} % 11
    ${check_digit}    Evaluate    0 if ${remainder} < 2 else 11 - ${remainder}
    [Return]    ${check_digit}


Preencher Dados
    [Arguments]    ${NIF}
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt22$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt92$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wt25$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldNIF$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wtnifStatus$block$wtInput$wttxtNif'][contains(@id,'wttxtNif')]    ${NIF}
#     Wait Until Element Is Visible    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt22$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt92$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wt25$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldNIF$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wtnifStatus$block$wtInput$wttxtNif'][contains(@id,'wttxtNif')]     ${NIF}
#     Wait Until Element Is Enabled    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt22$block$wtMainContent$wtbtnNext'][contains(@id,'wtbtnNext')]
#     Click Element    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt22$block$wtMainContent$wtbtnNext'][contains(@id,'wtbtnNext')]
   ####### Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt22$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt92$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wt25$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldNIF$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wtnifStatus$block$wtInput$wttxtNif'][contains(@id,'wttxtNif')]    ${NIF}
    Capture Page Screenshot	nif.png
    Sleep    4s

Clicar no botão CONTINUAR da page NOME e NIF   
    Wait Until Element Is Visible    locator=//input[@tabindex='3'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt22_block_wtMainContent_wtbtnNext']
    Capture Page Screenshot	CONTINUAR.png

Entrar com a Data de Nascimento "${DATANASC}", Género "${GENERO}", Data de Carta de Condução "${DT_CARTA_CONDUCAO}", Código Postal "${CODIGO_POSTAL}"
    Sleep    4s
    #Wait Until Page Contains    xpath=//input[@type='submit'][contains(@id,'wtNextButton4')]
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt8$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt101$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldDataNasc$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt31$block$wtInput$wtDOBInput'][contains(@id,'wtDOBInput')]    text=${DATANASC} 
    Capture Page Screenshot	DATANASC.png
    Sleep    4s
    Select From List by Label    xpath=//select[@name='CFID_B2C_SIM_Th_SIMAUTO_wt8$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt101$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldGender$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt2$block$wtInput$wtGenderCombo'][contains(@id,'wtGenderCombo')]    ${GENERO}
    Capture Page Screenshot	GENERO.png
    Sleep    4s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt8$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt101$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldDataCarta$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt59$block$wtInput$wtLicenseDateInput'][contains(@id,'wtLicenseDateInput')]    text=${DT_CARTA_CONDUCAO}
    Capture Page Screenshot	DT_CARTA_CONDUCAO.png
    Sleep    2s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt8$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt101$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldCodPostal$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt48$block$wtInput$wtPostalCodeInput'][contains(@id,'wtPostalCodeInput')]    text=${CODIGO_POSTAL}
    Capture Page Screenshot	CODIGO_POSTAL.png
    Sleep    2s
    Wait Until Element Is Visible    locator=//input[@tabindex='5'][contains(@id,'wtNextButton')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt8_block_wtMainContent_wtNextButton']
    Capture Page Screenshot	CONTINUAR22.png
    Sleep    4s

Clicar na opção "CONTINUAR SEM AGENTE"
     Wait Until Element Is Visible    locator=//input[@type='submit'][contains(@id,'wtNextButton4')]
     Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt8_block_wtMainContent_wtAgents_Sim_Auto_Web_Pat_wtConfirmModal_block_wtSecondaryButtons_wtNextButton4']
     Capture Page Screenshot	CONTINUAR-SEM-AGENTE.png
     Sleep    5s

Entrar com o E-mail "${email}", Telemovel "${TELEMOVEL}", marcar "${DADOS_PRIVACIDADE}" para os dados e clicar no CONTINUAR
    Sleep    4s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt21$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardContainer$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wt7$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt31$block$wtInput$wtPhoneInput'][contains(@id,'wtPhoneInput')]     text=${TELEMOVEL}
    Capture Page Screenshot	telemovel.png
    Sleep    2s
    # Gerar um novo e-mail pra inserir no campo e-mail
    # ${palavra_aleatoria}  Generate Random String  length=4  chars=[LETTERS]
    # ${palavra_aleatoria}  Convert To Lower Case    ${palavra_aleatoria}
    # #Set Test Variable     ${EMAIL_TESTE}  ${palavra_aleatoria}@emailteste.com
    # Set Suite Variable     ${EMAIL_TESTE} ${palavra_aleatoria}@emailteste.com
    # Log  ${EMAIL_TESTE}
    ${email}  FakerLibrary.FreeEmail
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt21$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardContainer$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wt79$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt13$block$wtInput$wtEmailInput'][contains(@id,'wtEmailInput')]    ${email}
    Capture Page Screenshot	emailteste.png
    Sleep    2s
    Click Element    xpath=//span[@class='Bold'][contains(.,'Porque precisamos dos seus dados?')]
    Capture Page Screenshot	DADOS_PRIVACIDADE.png
    Sleep    5s
    Select Checkbox    xpath=//input[@type='checkbox'][contains(@id,'wtInputRGPD')]
    Capture Page Screenshot	Checkbox.png
    Sleep    5s
    Wait Until Element Is Visible    locator=//input[@tabindex='3'][contains(@id,'wtNextButton')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt21_block_wtMainContent_wtNextButton']
    Capture Page Screenshot	CONTINUAR-DADOS.png
     Sleep    5s

Clicar no button CONTINUE
    Sleep    3s
    Wait Until Element Is Visible    locator=//input[@tabindex='1'][contains(@id,'wtNextButton')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt27_block_wtMainContent_wtNextButton']
    Capture Page Screenshot	CONTINUAR14.png
    Sleep    5s

Escolher a versão do veículo, e clique no botão CONTINUAR
    Sleep    5s
    Select From List by Label    xpath=//select[@name='CFID_B2C_SIM_Th_SIMAUTO_wt78$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtInnerContainer$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldVersion$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt54$block$wtInput$wtVersionListCombo'][contains(@id,'wtVersionListCombo')]    Model 3 Long-Range Dual Motor (351Cv) - (4p) - (18-)
    #Select From List By Value    xpath=//select[@name='CFID_B2C_SIM_Th_SIMAUTO_wt78$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtInnerContainer$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldVersion$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt54$block$wtInput$wtVersionListCombo'][contains(@id,'wtVersionListCombo')]    Model 3 Long-Range Dual Motor
    Capture Page Screenshot	versao-veiculo.png
    Sleep    3s
    Wait Until Element Is Visible    locator=//input[@tabindex='5'][contains(@id,'wtbtnContinuar')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt78_block_wtMainContent_wtbtnContinuar']
    Capture Page Screenshot	continuar222.png
    Sleep    5s

Clicar na opção "Não", para Seguro extra
    Sleep    3s
    Click Element    id=CFID_B2C_SIM_Th_SIMAUTO_wt94_block_wtMainContent_CFID_B2C_SIM_Pat_SIMAUTO_wt52_block_wtCustomCardContent_CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm_block_wtContent_CFID_B2C_SIM_Pat_SIMAUTO_wt101_block_wtInput_CFID_B2C_SIM_Pat_SIMAUTO_wt89_block_wtInput_WebPatterns_wt71_block_wtColumn2_Sim_Auto_Web_Pat_wt35_block_wtRadio_wt116
    Capture Page Screenshot	Seguro-extra.png

Clicar na opção "Não", para Reboque e Atrelado
    Sleep    5s
    Click Element    id=CFID_B2C_SIM_Th_SIMAUTO_wt94_block_wtMainContent_CFID_B2C_SIM_Pat_SIMAUTO_wt52_block_wtCustomCardContent_CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm_block_wtContent_CFID_B2C_SIM_Pat_SIMAUTO_wt16_block_wtInput_CFID_B2C_SIM_Pat_SIMAUTO_wt7_block_wtInput_WebPatterns_wt31_block_wtColumn2_Sim_Auto_Web_Pat_wt112_block_wtRadio_wt104
    Capture Page Screenshot	Reboque-Atrelado.png

Clicar na opção CONTINUAR
    Sleep    3s
    Wait Until Element Is Visible    locator=//input[@tabindex='5'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt94_block_wtMainContent_wtbtnNext'] 
    Capture Page Screenshot	CONTINUAR23.png

Clicar na opção "Fins particulares", para Uso do veículo e em CONTINUAR
    Sleep    3s
    Click Element    id=CFID_B2C_SIM_Th_SIMAUTO_wt47_block_wtMainContent_CFID_B2C_SIM_Pat_SIMAUTO_wt6_block_wtCustomCardContent_CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm_block_wtContent_CFID_B2C_SIM_Pat_SIMAUTO_wt43_block_wtInput_CFID_B2C_SIM_Pat_SIMAUTO_wt56_block_wtInput_WebPatterns_wt67_block_wtColumn1_Sim_Auto_Web_Pat_wt68_block_wtRadio_wtcbProfUse
    Capture Page Screenshot	Fins-particulares.png
    Sleep    1s
    Wait Until Element Is Visible    locator=//input[@type='submit'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt47_block_wtMainContent_wtbtnNext']
    Capture Page Screenshot	CONTINUAR24.png

Clicar em CONTINUAR, para a opção "Não tenho seguro"
    Sleep    5s
    Wait Until Element Is Visible    locator=//input[@type='submit'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt48_block_wtMainContent_wtbtnNext']
    Capture Page Screenshot	NAO-TEM-SEGURO.png

Clicar em CONTINUAR, para ja temos uma proposta para o seu veículo
    Sleep    5s
    Wait Until Element Is Visible    locator=//input[@tabindex='2'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt29_block_wtMainContent_wtbtnNext']
    Capture Page Screenshot	PROPOSTA-VEICULO.png

Validar que foi exibido uma cotação de seguro AUTO
    Sleep    5s
    Capture Page Screenshot	proposta_seguro_recomendado.png


# GHERKIN STEPS

#Dado que eu tenho a biblioteca ${faker} configurada
# Quando eu gero uma "${palavra_aleatoria}" de 4 letras
# E eu concateno a "${palavra_aleatoria}" com o domínio de "${EMAIL_TESTE}"
# Então o "${EMAIL_TESTE}" gerado deve estar no formato correto
# E o "${EMAIL_TESTE}" gerado deve ser armazenado corretamente
# Dado que um "${email}" aleatório é gerado
# Quando eu exibir o "${email}" gerado
# Então o "${email}" gerado deve estar no formato válido

Dado que estou na home page do site Fidelidade.com.br
    Acessar a home page do site Fidelidade.com.br
    Verificar se o título da página fica "Fidelidade | Nº 1 em Seguros Automóvel, Saúde, Casa e Viagem"

Quando acessar o menu "Particulares"
    Entrar no menu "Particulares"

Então acesso o menu "Auto"
    Entrar no menu "Auto"

E quando acessar o submenu "Auto1|2|3|4"
    Entrar no submenu "Auto1|2|3|4"

E clicar no botão "Quero Simular"
    Clicar no botão "Quero Simular"

E entrar com o número da matricula
    Preencher o número da "${MATRICULA}" matricula

E clicar na opção "FAÇA UMA SIMULAÇÃO MAIS PERSONALIZADA"
    Clicar na opção "FAÇA UMA SIMULAÇÃO MAIS PERSONALIZADA"

E entrar com o NOME "${NOME}" e o NIF "${NIF}" e botão CONTINUAR
    Entrar com o NOME "${NOME}" e o NIF "${NIF}" e botão CONTINUAR

E entrar com a Data de Nascimento "${DATANASC}", Género "${GENERO}", Data de Carta de Condução "${DT_CARTA_CONDUCAO}", Código Postal "${CODIGO_POSTAL}"
    Preencher a Data de Nascimento "${DATANASC}", Género "${GENERO}", Data de Carta de Condução "${DT_CARTA_CONDUCAO}", Código Postal "${CODIGO_POSTAL}"
   
E clicar na opção "CONTINUAR SEM AGENTE"
    Clicar na opção "CONTINUAR SEM AGENTE"

Então entrar com o E-mail "${email}", Telemovel "${TELEMOVEL}", marcar "${DADOS_PRIVACIDADE}" para os dados e clicar no botão CONTINUAR
    Preencher o E-mail "${email}", Telemovel "${TELEMOVEL}", marcar "${DADOS_PRIVACIDADE}" e CONTINUAR

Clicar no botão CONTINUAR
    Clicar no botão CONTINUAR 

Então escolher a versão do veículo, e clique no botão CONTINUAR
    Escolher a versão do veículo, e clique no botão CONTINUAR

E clicar na opção "Não", para Seguro extra
    Clicar na opção "Não", para Seguro extra

E clicar na opção "Não", para Reboque e Atrelado
    Clicar na opção "Não", para Reboque e Atrelado

E clicar na opção CONTINUAR
    clicar na opção CONTINUAR

E clicar na opção "Fins particulares", para Uso do veículo e em CONTINUAR
    clicar na opção "Fins particulares", para Uso do veículo e em CONTINUAR

E clicar em CONTINUAR, para a opção "Não tenho seguro"
    clicar em CONTINUAR, para a opção "Não tenho seguro"

E clicar em CONTINUAR, para ja temos uma proposta para o seu veículo
    clicar em CONTINUAR, para ja temos uma proposta para o seu veículo

Então validar que foi exibido uma cotação de seguro AUTO
    Validar que foi exibido uma cotação de seguro AUTO