&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME gDialog
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS gDialog 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrdlg.w - ADM2 SmartDialog Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{src/adm2/widgetprto.i}

DEF INPUT PARAM viOPC AS CHAR NO-UNDO.

DEF SHARED VAR vsi-usr-id AS INT NO-UNDO.

DEF BUFFER bf-usuario FOR usuario.

DEF VAR lVisualizaSenha AS LOG NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME gDialog

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fil-nome fil-email fil-identificacao rd-tipo ~
Btn_OK fil-telefone Btn_Cancel fil-usuario bt-senha fil-senha 
&Scoped-Define DISPLAYED-OBJECTS fil-nome fil-email fil-identificacao ~
rd-tipo fil-telefone fil-usuario fil-senha 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-validaCNPJ gDialog 
FUNCTION f-validaCNPJ RETURNS LOGICAL
  ( INPUT cCNPJ AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-validaCPF gDialog 
FUNCTION f-validaCPF RETURNS LOGICAL
  ( INPUT cCPF AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-validaEmail gDialog 
FUNCTION f-validaEmail RETURNS LOGICAL
  ( INPUT cEmail AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-validaSenha gDialog 
FUNCTION f-validaSenha RETURNS LOGICAL
  ( INPUT cSenha AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-validaTelefone gDialog 
FUNCTION f-validaTelefone RETURNS LOGICAL
  ( INPUT cTel AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-validaUsuario gDialog 
FUNCTION f-validaUsuario RETURNS LOGICAL
  ( INPUT cUser AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fIsAllowedUsrPwdChar gDialog 
FUNCTION fIsAllowedUsrPwdChar RETURNS LOGICAL
  ( INPUT c AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-senha 
     LABEL "" 
     SIZE 6 BY 1.24.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fil-email AS CHARACTER FORMAT "X(50)":U 
     LABEL "E-mail" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 50 BY 1 NO-UNDO.

DEFINE VARIABLE fil-identificacao AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 29 BY 1 NO-UNDO.

DEFINE VARIABLE fil-nome AS CHARACTER FORMAT "X(50)":U 
     LABEL "Nome" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 50 BY 1 NO-UNDO.

DEFINE VARIABLE fil-senha AS CHARACTER FORMAT "X(30)":U 
     LABEL "Senha" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 24 BY 1 NO-UNDO.

DEFINE VARIABLE fil-telefone AS CHARACTER FORMAT "X(11)":U 
     LABEL "Telefone" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 24 BY 1 NO-UNDO.

DEFINE VARIABLE fil-usuario AS CHARACTER FORMAT "X(30)":U 
     LABEL "Usuario" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 24 BY 1 NO-UNDO.

DEFINE VARIABLE rd-tipo AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "CPF", 1,
"CNPJ", 2
     SIZE 20.8 BY .91 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME gDialog
     fil-nome AT ROW 1.48 COL 9.2 COLON-ALIGNED WIDGET-ID 6
     fil-email AT ROW 2.71 COL 9.2 COLON-ALIGNED WIDGET-ID 8
     fil-identificacao AT ROW 4.05 COL 30 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     rd-tipo AT ROW 4.1 COL 11.2 NO-LABEL WIDGET-ID 10
     Btn_OK AT ROW 5.38 COL 45
     fil-telefone AT ROW 5.52 COL 11.4 COLON-ALIGNED WIDGET-ID 16
     Btn_Cancel AT ROW 6.62 COL 45
     fil-usuario AT ROW 6.81 COL 11.4 COLON-ALIGNED WIDGET-ID 2
     bt-senha AT ROW 7.91 COL 38.2 WIDGET-ID 20
     fil-senha AT ROW 8.05 COL 11.4 COLON-ALIGNED WIDGET-ID 4 BLANK 
     SPACE(27.79) SKIP(0.51)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Manutenção de Conta"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB gDialog 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX gDialog
   FRAME-NAME                                                           */
ASSIGN 
       FRAME gDialog:SCROLLABLE       = FALSE
       FRAME gDialog:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX gDialog
/* Query rebuild information for DIALOG-BOX gDialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX gDialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME gDialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL gDialog gDialog
ON WINDOW-CLOSE OF FRAME gDialog /* Manutenção de Conta */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-senha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-senha gDialog
ON CHOOSE OF bt-senha IN FRAME gDialog
DO:
    DO WITH FRAME {&FRAME-NAME}:

        IF lVisualizaSenha THEN
            ASSIGN lVisualizaSenha = NO.
        ELSE
            ASSIGN lVisualizaSenha = YES.


        IF lVisualizaSenha THEN DO:
            bt-senha:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\visualizar.png").

            fil-senha:BLANK = NO.
        END.
        ELSE DO:
            bt-senha:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\ocultar.png").

            fil-senha:BLANK = YES.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK gDialog
ON CHOOSE OF Btn_OK IN FRAME gDialog /* OK */
DO:
    DO WITH FRAME {&FRAME-NAME}:
        DEF VAR vc-aux AS CHAR.

        IF TRIM(fil-nome:SCREEN-VALUE) = "" THEN DO:

            MESSAGE "Favor informar o Nome."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        IF TRIM(fil-email:SCREEN-VALUE) = "" THEN DO:
                                                    
            MESSAGE "Favor informar um e-mail."        
                VIEW-AS ALERT-BOX INFO BUTTONS OK.  
            RETURN NO-APPLY.                        
        END.

        IF NOT f-validaEmail(TRIM(fil-email:SCREEN-VALUE)) THEN DO:

            MESSAGE "Favor informar um e-mail válido."   
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.                      
        END.

        IF TRIM(fil-identificacao:SCREEN-VALUE) = "" THEN DO: 
            ASSIGN vc-aux = IF INPUT rd-tipo = 1 THEN "CPF" ELSE "CNPJ".
                                                      
            MESSAGE "Favor informar um " + vc-aux + "."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.    
            RETURN NO-APPLY.                          
        END. 

        IF INPUT rd-tipo = 1 AND NOT f-validaCPF(TRIM(fil-identificacao:SCREEN-VALUE)) THEN DO:

            MESSAGE "Favor informar um CPF válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.            
            RETURN NO-APPLY.                                  
        END.

        IF INPUT rd-tipo = 2 AND NOT f-validaCNPJ(TRIM(fil-identificacao:SCREEN-VALUE)) THEN DO:
                                                                                               
            MESSAGE "Favor informar um CNPJ válido."                                            
                VIEW-AS ALERT-BOX INFO BUTTONS OK.                                             
            RETURN NO-APPLY.                                                                   
        END.                                                                                   

        IF TRIM(fil-telefone:SCREEN-VALUE) = "" THEN DO: 
                                                      
            MESSAGE "Favor informar um telefone."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.    
            RETURN NO-APPLY.                          
        END. 

        IF NOT f-validaTelefone(TRIM(fil-telefone:SCREEN-VALUE)) THEN DO:
                                                        
            MESSAGE "Favor informar um telefone válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.      
            RETURN NO-APPLY.                            
        END.                                            

        IF TRIM(fil-usuario:SCREEN-VALUE) = "" THEN DO:
                                                        
            MESSAGE "Favor informar um usuário."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.      
            RETURN NO-APPLY.                            
        END.
        ELSE DO:

            IF NOT f-validaUsuario(TRIM(fil-usuario:SCREEN-VALUE)) THEN   
                RETURN NO-APPLY.                                                                     

            IF viOPC = "I" THEN DO:

                FIND FIRST usuario WHERE
                           usuario.usuario-login = TRIM(fil-usuario:SCREEN-VALUE) NO-LOCK NO-ERROR.
                IF AVAIL usuario THEN DO:
                
                    MESSAGE "Esse usuário já está sendo utilizado." SKIP
                            "Favor escolher outro."
                        VIEW-AS ALERT-BOX INFO BUTTONS OK.
                    RETURN NO-APPLY.
                END.  
            END.
            ELSE DO:

                FIND FIRST usuario WHERE                                                           
                           usuario.usuario-login = TRIM(fil-usuario:SCREEN-VALUE) AND
                           usuario.usuario-id <> vsi-usr-id NO-LOCK NO-ERROR.
                IF AVAIL usuario THEN DO:                                                          
                                                                                                   
                    MESSAGE "Esse usuário já está sendo utilizado." SKIP                           
                            "Favor escolher outro."                                                
                        VIEW-AS ALERT-BOX INFO BUTTONS OK.                                         
                    RETURN NO-APPLY.                                                               
                END.                                                                               
            END.
        END.

        IF TRIM(fil-senha:SCREEN-VALUE) = "" THEN DO:
                                                        
            MESSAGE "Favor informar uma senha."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.      
            RETURN NO-APPLY.                            
        END.   

        IF NOT f-validaSenha(TRIM(fil-senha:SCREEN-VALUE)) THEN
            RETURN NO-APPLY.

        RUN p-grava.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK gDialog 


/* ***************************  Main Block  *************************** */

{src/adm2/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects gDialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI gDialog  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME gDialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI gDialog  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fil-nome fil-email fil-identificacao rd-tipo fil-telefone fil-usuario 
          fil-senha 
      WITH FRAME gDialog.
  ENABLE fil-nome fil-email fil-identificacao rd-tipo Btn_OK fil-telefone 
         Btn_Cancel fil-usuario bt-senha fil-senha 
      WITH FRAME gDialog.
  VIEW FRAME gDialog.
  {&OPEN-BROWSERS-IN-QUERY-gDialog}
  RUN p-leitura.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-grava gDialog 
PROCEDURE p-grava :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    IF viOPC = "A" THEN DO:

        FIND FIRST usuario WHERE
                   usuario.usuario-id = vsi-usr-id EXCLUSIVE-LOCK NO-ERROR.
    END.
    ELSE DO:
        
        CREATE usuario.

        FIND LAST bf-usuario NO-LOCK NO-ERROR.
        IF AVAIL bf-usuario THEN
            ASSIGN usuario.usuario-id = bf-usuario.usuario-id + 1.
        ELSE
            ASSIGN usuario.usuario-id = 1.
    END.

    ASSIGN usuario.usuario-nome              = TRIM(fil-nome:SCREEN-VALUE)
           usuario.usuario-email             = TRIM(fil-email:SCREEN-VALUE)
           usuario.usuario-tipoIdentificacao = INPUT rd-tipo
           usuario.usuario-identificacao     = TRIM(fil-identificacao:SCREEN-VALUE)
           usuario.usuario-identificacao     = REPLACE(usuario.usuario-identificacao, ".", "")
           usuario.usuario-identificacao     = REPLACE(usuario.usuario-identificacao, "-", "")
           usuario.usuario-identificacao     = REPLACE(usuario.usuario-identificacao, "/", "")
           usuario.usuario-telefone          = TRIM(fil-telefone:SCREEN-VALUE)
           usuario.usuario-telefone          = REPLACE(usuario.usuario-telefone, "(", "")
           usuario.usuario-telefone          = REPLACE(usuario.usuario-telefone, ")", "")
           usuario.usuario-telefone          = REPLACE(usuario.usuario-telefone, "-", "")
           usuario.usuario-telefone          = REPLACE(usuario.usuario-telefone, " ", "")
           usuario.usuario-telefone          = REPLACE(usuario.usuario-telefone, ".", "")
           usuario.usuario-login             = TRIM(fil-usuario:SCREEN-VALUE)
           usuario.usuario-senha             = TRIM(fil-senha:SCREEN-VALUE)
           usuario.usuario-dataAlt           = TODAY
           usuario.usuario-horaAlt           = TIME.

    IF viOPC = "I" THEN DO: 
        RUN Atualiza_Estoques.p.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leitura gDialog 
PROCEDURE p-leitura :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    ASSIGN lVisualizaSenha = NO.                                                         
                                                                                         
    ASSIGN bt-senha:LABEL = "" NO-ERROR.                                
                                                                                         
    bt-senha:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\ocultar.png").

    IF viOPC = "A" THEN DO:

        FIND FIRST usuario WHERE
                   usuario.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.
        IF AVAIL usuario THEN DO:

            ASSIGN fil-nome:SCREEN-VALUE          = string(usuario.usuario-nome)
                   fil-email:SCREEN-VALUE         = string(usuario.usuario-email)
                   rd-tipo:SCREEN-VALUE           = string(usuario.usuario-tipoIdentificacao)
                   fil-identificacao:SCREEN-VALUE = string(usuario.usuario-identificacao)
                   fil-telefone:SCREEN-VALUE      = string(usuario.usuario-telefone)
                   fil-usuario:SCREEN-VALUE       = string(usuario.usuario-login)
                   fil-senha:SCREEN-VALUE         = string(usuario.usuario-senha).
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-validaCNPJ gDialog 
FUNCTION f-validaCNPJ RETURNS LOGICAL
  ( INPUT cCNPJ AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cNum   AS CHARACTER NO-UNDO.
    DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
    DEFINE VARIABLE soma   AS INTEGER   NO-UNDO.
    DEFINE VARIABLE resto  AS INTEGER   NO-UNDO.
    DEFINE VARIABLE dig1   AS INTEGER   NO-UNDO.
    DEFINE VARIABLE dig2   AS INTEGER   NO-UNDO.
    DEFINE VARIABLE w      AS INTEGER   NO-UNDO.
   
    /* Remove máscara manualmente */
    cNum = cCNPJ.
    cNum = REPLACE(cNum, ".", "").
    cNum = REPLACE(cNum, "-", "").
    cNum = REPLACE(cNum, "/", "").
    cNum = TRIM(cNum).
   
    /* Tem que ter 14 dígitos */
    IF LENGTH(cNum) <> 14 THEN RETURN FALSE.
   
    /* Não pode ser sequência repetida (000..., 111..., etc.) */
    IF cNum = FILL(SUBSTRING(cNum,1,1), 14) THEN RETURN FALSE.
   
    /* ---------- 1º dígito verificador ---------- */
    soma = 0.
    DO i = 1 TO 12:
      /* pesos: 5,4,3,2,9,8,7,6,5,4,3,2 */
      w = IF i <= 4 THEN 6 - i ELSE 14 - i.
      soma = soma + (INTEGER(SUBSTRING(cNum, i, 1)) * w).
    END.
   
    resto = soma MOD 11.
    dig1  = IF resto < 2 THEN 0 ELSE 11 - resto.
   
    /* ---------- 2º dígito verificador ---------- */
    soma = 0.
    DO i = 1 TO 13:
      /* pesos: 6,5,4,3,2,9,8,7,6,5,4,3,2 */
      w = IF i <= 5 THEN 7 - i ELSE 15 - i.
      soma = soma + (INTEGER(SUBSTRING(cNum, i, 1)) * w).
    END.
   
    resto = soma MOD 11.
    dig2  = IF resto < 2 THEN 0 ELSE 11 - resto.
   
    /* Verifica dígitos */
    RETURN SUBSTRING(cNum, 13, 1) = STRING(dig1)
        AND SUBSTRING(cNum, 14, 1) = STRING(dig2).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-validaCPF gDialog 
FUNCTION f-validaCPF RETURNS LOGICAL
  ( INPUT cCPF AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cNum   AS CHARACTER NO-UNDO.
    DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
    DEFINE VARIABLE soma   AS INTEGER   NO-UNDO.
    DEFINE VARIABLE resto  AS INTEGER   NO-UNDO.
    DEFINE VARIABLE dig1   AS INTEGER   NO-UNDO.
    DEFINE VARIABLE dig2   AS INTEGER   NO-UNDO.
    
    /* Remove caracteres não numéricos */
    cNum = REPLACE(cCPF, ".", "").
    cNum = REPLACE(cNum, "-", "").
    cNum = TRIM(cNum).
    
    /* Tem que ter 11 dígitos */
    IF LENGTH(cNum) <> 11 THEN RETURN FALSE.
    
    /* Não pode ser sequência repetida */
    IF cNum = STRING(FILL("0",11)) OR 
       cNum = STRING(FILL("1",11)) OR 
       cNum = STRING(FILL("2",11)) OR 
       cNum = STRING(FILL("3",11)) OR 
       cNum = STRING(FILL("4",11)) OR 
       cNum = STRING(FILL("5",11)) OR 
       cNum = STRING(FILL("6",11)) OR 
       cNum = STRING(FILL("7",11)) OR 
       cNum = STRING(FILL("8",11)) OR 
       cNum = STRING(FILL("9",11)) THEN RETURN FALSE.
    
    /* ------------------------------- */
    /* Cálculo do primeiro dígito      */
    /* ------------------------------- */
    soma = 0.
    DO i = 1 TO 9:
      soma = soma + (INTEGER(SUBSTRING(cNum, i, 1)) * (11 - i)).
    END.
    
    resto = soma MOD 11.
    IF resto < 2 THEN dig1 = 0.
    ELSE dig1 = 11 - resto.
    
    /* ------------------------------- */
    /* Cálculo do segundo dígito       */
    /* ------------------------------- */
    soma = 0.
    DO i = 1 TO 10:
      soma = soma + (INTEGER(SUBSTRING(cNum, i, 1)) * (12 - i)).
    END.
    
    resto = soma MOD 11.
    IF resto < 2 THEN dig2 = 0.
    ELSE dig2 = 11 - resto.
    
    /* Comparação final */
    IF SUBSTRING(cNum, 10, 1) = STRING(dig1)
       AND SUBSTRING(cNum, 11, 1) = STRING(dig2) THEN
      RETURN TRUE.
    ELSE
      RETURN FALSE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-validaEmail gDialog 
FUNCTION f-validaEmail RETURNS LOGICAL
  ( INPUT cEmail AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE iAt     AS INTEGER   NO-UNDO.
    DEFINE VARIABLE cLocal  AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cDomain AS CHARACTER NO-UNDO.
    
    ASSIGN cEmail = TRIM(cEmail).
    
    /* Não pode estar vazio */
    IF cEmail = "" THEN RETURN FALSE.
    
    /* Não pode ter espaço e nem dois pontos seguidos */
    IF INDEX(cEmail, " ") > 0 OR INDEX(cEmail, "..") > 0 THEN RETURN FALSE.
    
    /* Tem que ter exatamente um @ em posição válida */
    iAt = INDEX(cEmail, "@").
    IF iAt <= 1 OR iAt = LENGTH(cEmail) THEN RETURN FALSE.
    
    ASSIGN
      cLocal  = SUBSTRING(cEmail, 1, iAt - 1)
      cDomain = SUBSTRING(cEmail, iAt + 1).
    
    /* Parte local e domínio precisam existir */
    IF cLocal = "" OR cDomain = "" THEN RETURN FALSE.
    
    /* Domínio precisa ter ponto, não pode começar/terminar com ponto */
    IF INDEX(cDomain, ".") = 0 THEN RETURN FALSE.
    IF SUBSTRING(cDomain, 1, 1) = "." THEN RETURN FALSE.
    IF SUBSTRING(cDomain, LENGTH(cDomain), 1) = "." THEN RETURN FALSE.

  RETURN TRUE.
























END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-validaSenha gDialog 
FUNCTION f-validaSenha RETURNS LOGICAL
  ( INPUT cSenha AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.

  /* Rejeita espaço explicitamente */
  IF INDEX(cSenha, " ") > 0 THEN DO:

      MESSAGE "A senha não pode conter espaços."
          VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN FALSE.
  END.

  DO i = 1 TO LENGTH(cSenha):
      c = SUBSTRING(cSenha, i, 1).
      IF NOT fIsAllowedUsrPwdChar(c) THEN DO:

          MESSAGE "A senha não pode conter carcteres especiais."
              VIEW-AS ALERT-BOX INFO BUTTONS OK.                
          RETURN FALSE.
      END.
  END.

  RETURN TRUE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-validaTelefone gDialog 
FUNCTION f-validaTelefone RETURNS LOGICAL
  ( INPUT cTel AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cNum AS CHARACTER NO-UNDO.
    DEFINE VARIABLE i    AS INTEGER   NO-UNDO.
    
    /* Remove máscara */
    cNum = cTel.
    cNum = REPLACE(cNum, "(", "").
    cNum = REPLACE(cNum, ")", "").
    cNum = REPLACE(cNum, "-", "").
    cNum = REPLACE(cNum, " ", "").
    cNum = REPLACE(cNum, ".", "").
    cNum = TRIM(cNum).
    
    /* Verifica se só tem números */
    DO i = 1 TO LENGTH(cNum):
      IF ASC(SUBSTRING(cNum, i, 1)) < ASC("0")
         OR ASC(SUBSTRING(cNum, i, 1)) > ASC("9") THEN
         RETURN FALSE.
    END.
    
    /* Tamanhos aceitos:
       8  = fixo sem DDD
       9  = celular sem DDD
       10 = fixo com DDD
       11 = celular com DDD
    */
    IF LENGTH(cNum) = 8  OR 
       LENGTH(cNum) = 9  OR
       LENGTH(cNum) = 10 OR
       LENGTH(cNum) = 11 THEN
      RETURN TRUE.
    
    RETURN FALSE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-validaUsuario gDialog 
FUNCTION f-validaUsuario RETURNS LOGICAL
  ( INPUT cUser AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE c AS CHARACTER NO-UNDO.
    DEFINE VARIABLE i AS INTEGER   NO-UNDO.
   
    /* Bloqueia espaço só por garantia */
    IF INDEX(cUser, " ") > 0 THEN DO:

        MESSAGE "O usuário não pode conter espaços." 
            VIEW-AS ALERT-BOX INFO BUTTONS OK.                    
        RETURN FALSE.
    END.

    DO i = 1 TO LENGTH(cUser):
        c = SUBSTRING(cUser, i, 1).
        IF NOT fIsAllowedUsrPwdChar(c) THEN DO:

            MESSAGE "O usuario não pode conter carcteres especiais."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.                
            RETURN FALSE.
        END.
    END.
   
    RETURN TRUE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fIsAllowedUsrPwdChar gDialog 
FUNCTION fIsAllowedUsrPwdChar RETURNS LOGICAL
  ( INPUT c AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE a AS INTEGER NO-UNDO.
    IF LENGTH(c) <> 1 THEN RETURN FALSE.
    
    a = ASC(c).
    
    /* 0-9 */
    IF a >= ASC("0") AND a <= ASC("9") THEN RETURN TRUE.
    /* A-Z */
    IF a >= ASC("A") AND a <= ASC("Z") THEN RETURN TRUE.
    /* a-z */
    IF a >= ASC("a") AND a <= ASC("z") THEN RETURN TRUE.
    /* ponto . */
    IF a = ASC(".") THEN RETURN TRUE.
    /* underline _ */
    IF a = ASC("_") THEN RETURN TRUE.
    /* hífen - */
    IF a = ASC("-") THEN RETURN TRUE.
    
    /* demais caracteres, incluindo espaço, são inválidos */
    RETURN FALSE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

