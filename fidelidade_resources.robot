*** Settings ***
Library     SeleniumLibrary
Resource    settings.robot

*** Variables ***
${BROWSER}                  chrome
${URL}                      https://www.fidelidade.pt/
${COOKIES_PRIVACIDADE}      //button[contains(.,'Aceitar Todos')]
${MENU_PARTICULARES}        //*[@id="header"]/div[1]/div[2]/div/div[1]/nav/a[1]
${SUBMENU_AUTO1234}         //*[@id="header"]/div[1]/div[2]/div/div[2]/nav/div[1]/div/ul[1]/li[3]/a
${BUTTON_QUERO_SIMULAR}     ctl00_PlaceHolderMain_EditModePanel2_ProductDescription_lnkSimulateLink
${NOME}                     Kiuil Nodapun
${NIF}                      255289987
${MATRICULA}                AA16AA  
${DATANASC}                 11111977
${GENERO}                   Masculino
${DT_CARTA_CONDUCAO}        11111998 
${CODIGO_POSTAL}            1500002
${EMAIL}                    teste@teste1200.com
${TELEMOVEL}                930000080
${DADOS_PRIVACIDADE}        SIM

*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Fidelidade.com.br
    Go To    url=${URL}
    Click Element    locator=${COOKIES_PRIVACIDADE}
    Wait Until Element Is Visible    locator=${MENU_PARTICULARES}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Entrar no menu "Particulares"
    Click Element    locator=${MENU_PARTICULARES}

Entrar no menu "Auto"
    Mouse Over    css=a.header

Entrar no submenu "Auto1|2|3|4"
    Click Link    link=Auto 1|2|3|4

Clicar no botão "Quero Simular"
    Click Element    id=${BUTTON_QUERO_SIMULAR}

Entrar com o número da "${MATRICULA}" matricula
    Select Frame     //iframe[contains(@title,'Simulator')]
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt60$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCustomCard$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wt9$block$wtContent$Sim_Auto_Web_Pat_wtLicensePlateBlock$block$wtInputPlaceholder$wttxtRegNumber'][contains(@id,'wttxtRegNumber')]    text=${MATRICULA}
    Sleep    3s
    Click Element   xpath=//input[@type='submit'][contains(@id,'wtbtnNext')]
    
Clicar na opção "FAÇA UMA SIMULAÇÃO MAIS PERSONALIZADA"
    Sleep    1s
    Wait Until Page Contains    text=Este é um exemplo de pré-simulação para o veículo TESLA Model 3
    Click Element   xpath=//input[@type='submit'][contains(@id,'wt27')]

Entrar com o NOME "${NOME}"e o NIF "${NIF}" e botão CONTINUAR
    Sleep    5s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt22$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt92$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wt25$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldName$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wtnameStatus$block$wtInput$wttxtName'][contains(@id,'wttxtName')]    text=${NOME}
    Sleep    3s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt22$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt92$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wt25$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldNIF$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wtnifStatus$block$wtInput$wttxtNif'][contains(@id,'wttxtNif')]    text=${NIF}
    Sleep    2s
    Wait Until Element Is Visible    locator=//input[@tabindex='3'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt22_block_wtMainContent_wtbtnNext']

Entrar com a Data de Nascimento "${DATANASC}", Género "${GENERO}", Data de Carta de Condução "${DT_CARTA_CONDUCAO}", Código Postal "${CODIGO_POSTAL}"
    Sleep    4s
    #Wait Until Page Contains    xpath=//input[@type='submit'][contains(@id,'wtNextButton4')]
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt8$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt101$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldDataNasc$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt31$block$wtInput$wtDOBInput'][contains(@id,'wtDOBInput')]    text=${DATANASC} 
    Sleep    4s
    Select From List by Label    xpath=//select[@name='CFID_B2C_SIM_Th_SIMAUTO_wt8$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt101$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldGender$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt2$block$wtInput$wtGenderCombo'][contains(@id,'wtGenderCombo')]    ${GENERO}
    Sleep    4s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt8$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt101$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldDataCarta$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt59$block$wtInput$wtLicenseDateInput'][contains(@id,'wtLicenseDateInput')]    text=${DT_CARTA_CONDUCAO}
    Sleep    2s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt8$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wt101$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldCodPostal$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt48$block$wtInput$wtPostalCodeInput'][contains(@id,'wtPostalCodeInput')]    text=${CODIGO_POSTAL}
    Sleep    2s
    Wait Until Element Is Visible    locator=//input[@tabindex='5'][contains(@id,'wtNextButton')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt8_block_wtMainContent_wtNextButton']
    Sleep    4s

Clicar na opção "CONTINUAR SEM AGENTE"
     Wait Until Element Is Visible    locator=//input[@type='submit'][contains(@id,'wtNextButton4')]
     Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt8_block_wtMainContent_wtAgents_Sim_Auto_Web_Pat_wtConfirmModal_block_wtSecondaryButtons_wtNextButton4']
     Sleep    5s

Entrar com o E-mail "${EMAIL}", Telemovel "${TELEMOVEL}", marcar "${DADOS_PRIVACIDADE}" para os dados e clicar no botão CONTINUAR
    Sleep    4s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt21$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardContainer$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wt7$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt31$block$wtInput$wtPhoneInput'][contains(@id,'wtPhoneInput')]     text=${TELEMOVEL}
    Sleep    2s
    Input Text    xpath=//input[@name='CFID_B2C_SIM_Th_SIMAUTO_wt21$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardContainer$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wt79$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt13$block$wtInput$wtEmailInput'][contains(@id,'wtEmailInput')]    text=${EMAIL} 
    Sleep    2s
    Click Element    xpath=//span[@class='Bold'][contains(.,'Porque precisamos dos seus dados?')]
    Sleep    3s
    Select Checkbox    xpath=//input[@type='checkbox'][contains(@id,'wtInputRGPD')]
    Sleep    3s
    Wait Until Element Is Visible    locator=//input[@tabindex='3'][contains(@id,'wtNextButton')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt21_block_wtMainContent_wtNextButton']
    Sleep    5s

Clicar no botão CONTINUAR
    Sleep    3s
    Wait Until Element Is Visible    locator=//input[@tabindex='1'][contains(@id,'wtNextButton')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt27_block_wtMainContent_wtNextButton']
    Sleep    5s

Escolher a versão do veículo, e clique no botão CONTINUAR
    Select From List by Label    xpath=//select[@name='CFID_B2C_SIM_Th_SIMAUTO_wt78$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtInnerContainer$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldVersion$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt54$block$wtInput$wtVersionListCombo'][contains(@id,'wtVersionListCombo')]    Model 3 Long-Range Dual Motor (351Cv) - (4p) - (18-)
    #Select From List By Value    xpath=//select[@name='CFID_B2C_SIM_Th_SIMAUTO_wt78$block$wtMainContent$CFID_B2C_SIM_Pat_SIMAUTO_wtInnerContainer$block$wtCustomCardContent$CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm$block$wtContent$CFID_B2C_SIM_Pat_SIMAUTO_wtfieldVersion$block$wtInput$CFID_B2C_SIM_Pat_SIMAUTO_wt54$block$wtInput$wtVersionListCombo'][contains(@id,'wtVersionListCombo')]    Model 3 Long-Range Dual Motor
    Sleep    4s
    Capture Page Screenshot	proposta_seguro_recomeo.png
    Sleep    3s
    Wait Until Element Is Visible    locator=//input[@tabindex='5'][contains(@id,'wtbtnContinuar')]
    Capture Page Screenshot	seguro_recomendado.png
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt78_block_wtMainContent_wtbtnContinuar']
    Capture Page Screenshot	proposta_segurendado.png
    Sleep    5s

Clicar na opção "Não", para Seguro extra
    Sleep    3s
    Click Element    id=CFID_B2C_SIM_Th_SIMAUTO_wt94_block_wtMainContent_CFID_B2C_SIM_Pat_SIMAUTO_wt52_block_wtCustomCardContent_CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm_block_wtContent_CFID_B2C_SIM_Pat_SIMAUTO_wt101_block_wtInput_CFID_B2C_SIM_Pat_SIMAUTO_wt89_block_wtInput_WebPatterns_wt71_block_wtColumn2_Sim_Auto_Web_Pat_wt35_block_wtRadio_wt116

Clicar na opção "Não", para Reboque e Atrelado
    Sleep    5s
    Click Element    id=CFID_B2C_SIM_Th_SIMAUTO_wt94_block_wtMainContent_CFID_B2C_SIM_Pat_SIMAUTO_wt52_block_wtCustomCardContent_CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm_block_wtContent_CFID_B2C_SIM_Pat_SIMAUTO_wt16_block_wtInput_CFID_B2C_SIM_Pat_SIMAUTO_wt7_block_wtInput_WebPatterns_wt31_block_wtColumn2_Sim_Auto_Web_Pat_wt112_block_wtRadio_wt104

Clicar na opção CONTINUAR
    Sleep    3s
    Wait Until Element Is Visible    locator=//input[@tabindex='5'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt94_block_wtMainContent_wtbtnNext'] 

Clicar na opção "Fins particulares", para Uso do veículo e em CONTINUAR
    Sleep    3s
    Click Element    id=CFID_B2C_SIM_Th_SIMAUTO_wt47_block_wtMainContent_CFID_B2C_SIM_Pat_SIMAUTO_wt6_block_wtCustomCardContent_CFID_B2C_SIM_Pat_SIMAUTO_wtCardForm_block_wtContent_CFID_B2C_SIM_Pat_SIMAUTO_wt43_block_wtInput_CFID_B2C_SIM_Pat_SIMAUTO_wt56_block_wtInput_WebPatterns_wt67_block_wtColumn1_Sim_Auto_Web_Pat_wt68_block_wtRadio_wtcbProfUse
    Sleep    1s
    Wait Until Element Is Visible    locator=//input[@type='submit'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt47_block_wtMainContent_wtbtnNext']

Clicar em CONTINUAR, para a opção "Não tenho seguro"
    Sleep    5s
    Wait Until Element Is Visible    locator=//input[@type='submit'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt48_block_wtMainContent_wtbtnNext']

Clicar em CONTINUAR, para ja temos uma proposta para o seu veículo
    Sleep    5s
    Wait Until Element Is Visible    locator=//input[@tabindex='2'][contains(@id,'wtbtnNext')]
    Click Element    xpath=//input[@id='CFID_B2C_SIM_Th_SIMAUTO_wt29_block_wtMainContent_wtbtnNext']

Validar que foi exibido uma cotação de seguro AUTO
    Sleep    5s
    Capture Page Screenshot	proposta_seguro_recomendado.png
