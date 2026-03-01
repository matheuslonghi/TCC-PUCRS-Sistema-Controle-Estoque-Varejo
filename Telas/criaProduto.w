&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME sgDialog
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS sgDialog 
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
DEF INPUT PARAM viID  AS INT  NO-UNDO.

DEF SHARED VAR vsi-usr-id AS INT NO-UNDO.

DEFINE VARIABLE cSrc   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cExt   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cDest  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cBase  AS CHARACTER NO-UNDO.

DEF VAR cImgSalva AS CHAR NO-UNDO.

DEF VAR cImgPadrao AS CHAR NO-UNDO INIT "C:\Users\Totvs\Documents\Imagens\imgpadrao.png".

DEF BUFFER bf-produto FOR produto.
DEF BUFFER bf-histProduto FOR histProduto.

&SCOPED-DEFINE DEST_DIR_IMG "C:\Users\Totvs\Documents\Imagens\"

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME sgDialog

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 imgFoto fil-nome cb-categoria ~
fil-valor fil-valorvarejo fil-estoquecrit bt-anexo Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS fil-nome cb-categoria fil-valor ~
fil-valorvarejo fil-estoquecrit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fBaseName sgDialog 
FUNCTION fBaseName RETURNS CHARACTER
  ( pcPath AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fGetExt sgDialog 
FUNCTION fGetExt RETURNS CHARACTER
  ( pcPath AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-anexo 
     LABEL "Anexar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bt-removeanexo 
     LABEL "Remover" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 12 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 12 BY 1.14.

DEFINE VARIABLE cb-categoria AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     LABEL "Categoria" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 58.6 BY 1 NO-UNDO.

DEFINE VARIABLE fil-estoquecrit AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Estoque Crítico" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8.2 BY 1 NO-UNDO.

DEFINE VARIABLE fil-nome AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nome" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 59 BY 1 NO-UNDO.

DEFINE VARIABLE fil-valor AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Valor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE fil-valorvarejo AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Valor Varejo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1 NO-UNDO.

DEFINE IMAGE imgFoto
     FILENAME "adeicon/blank":U
     SIZE 39 BY 8.81.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 43 BY 9.76.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 20 BY 3.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME sgDialog
     fil-nome AT ROW 1.71 COL 14.4 COLON-ALIGNED WIDGET-ID 6
     cb-categoria AT ROW 2.91 COL 14.4 COLON-ALIGNED WIDGET-ID 34
     fil-valor AT ROW 4.19 COL 14.6 COLON-ALIGNED WIDGET-ID 12
     fil-valorvarejo AT ROW 5.43 COL 14.6 COLON-ALIGNED WIDGET-ID 14
     fil-estoquecrit AT ROW 6.62 COL 21.4 COLON-ALIGNED WIDGET-ID 20
     bt-anexo AT ROW 8.91 COL 14 WIDGET-ID 26
     bt-removeanexo AT ROW 10.19 COL 14 WIDGET-ID 28
     Btn_OK AT ROW 12.76 COL 4 WIDGET-ID 4
     Btn_Cancel AT ROW 12.76 COL 16 WIDGET-ID 2
     "Imagem:" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 7.91 COL 12.6 WIDGET-ID 30
     RECT-1 AT ROW 4.14 COL 32.4 WIDGET-ID 18
     RECT-2 AT ROW 8.14 COL 11.6 WIDGET-ID 22
     imgFoto AT ROW 4.67 COL 34.4 WIDGET-ID 32
     SPACE(4.79) SKIP(0.75)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Manutenção de Produtos" WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB sgDialog 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX sgDialog
   FRAME-NAME                                                           */
ASSIGN 
       FRAME sgDialog:SCROLLABLE       = FALSE
       FRAME sgDialog:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-removeanexo IN FRAME sgDialog
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX sgDialog
/* Query rebuild information for DIALOG-BOX sgDialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX sgDialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME sgDialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sgDialog sgDialog
ON WINDOW-CLOSE OF FRAME sgDialog /* Manutenção de Produtos */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-anexo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-anexo sgDialog
ON CHOOSE OF bt-anexo IN FRAME sgDialog /* Anexar */
DO:
    DEFINE VARIABLE vResp AS LOGICAL NO-UNDO.

    IF cImgSalva <> "" AND cImgSalva <> ? THEN DO:
    
       MESSAGE "Deseja substituir a imagem?"
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
       UPDATE vResp.

       IF NOT vResp THEN
           RETURN NO-APPLY.
    END.

    RUN pEscolherECarregar IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-removeanexo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-removeanexo sgDialog
ON CHOOSE OF bt-removeanexo IN FRAME sgDialog /* Remover */
DO:
    DEFINE VARIABLE vResp AS LOGICAL NO-UNDO.     
                                                  
    IF cImgSalva <> "" AND cImgSalva <> ? THEN DO:
                                                  
       MESSAGE "Deseja remover a imagem?"      
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO  
       UPDATE vResp.                              
                                                  
       IF NOT vResp THEN                          
           RETURN NO-APPLY.                       
    END.                                          

    RUN pLimparImagem IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK sgDialog
ON CHOOSE OF Btn_OK IN FRAME sgDialog /* OK */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        IF TRIM(fil-nome:SCREEN-VALUE) = "" THEN DO:

            MESSAGE "Favor informar um nome."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        IF INPUT fil-valor <= 0 OR INPUT fil-valor = ?  THEN DO:

            MESSAGE "Favor informar um valor válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        IF INPUT fil-valorvarejo <= 0 OR INPUT fil-valorvarejo = ?  THEN DO:
                                                                
            MESSAGE "Favor informar um valor de varejo válido."           
                VIEW-AS ALERT-BOX INFO BUTTONS OK.              
            RETURN NO-APPLY.                                    
        END.     

        IF INPUT fil-estoquecrit < 0 OR INPUT fil-estoquecrit = ?  THEN DO:
                                                                
            MESSAGE "Favor informar um estoque crítico válido."           
                VIEW-AS ALERT-BOX INFO BUTTONS OK.              
            RETURN NO-APPLY.                                    
        END.                                                    

        RUN p-grava.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK sgDialog 


/* ***************************  Main Block  *************************** */

{src/adm2/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects sgDialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI sgDialog  _DEFAULT-DISABLE
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
  HIDE FRAME sgDialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI sgDialog  _DEFAULT-ENABLE
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
  DISPLAY fil-nome cb-categoria fil-valor fil-valorvarejo fil-estoquecrit 
      WITH FRAME sgDialog.
  ENABLE RECT-1 RECT-2 imgFoto fil-nome cb-categoria fil-valor fil-valorvarejo 
         fil-estoquecrit bt-anexo Btn_OK Btn_Cancel 
      WITH FRAME sgDialog.
  VIEW FRAME sgDialog.
  {&OPEN-BROWSERS-IN-QUERY-sgDialog}
  RUN p-leitura.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-grava sgDialog 
PROCEDURE p-grava :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    IF viOPC = "A" THEN DO:

        FIND FIRST produto WHERE                                
                   produto.usuario-id = vsi-usr-id AND        
                   produto.produto-id = viID EXCLUSIVE-LOCK NO-ERROR.

        FIND LAST bf-histProduto WHERE                                                                                           
                  bf-histProduto.usuario-id = vsi-usr-id AND                                                                   
                  bf-histProduto.produto-id = produto.produto-id NO-LOCK NO-ERROR.                                         
                                                                                                                                   
        CREATE histProduto.                                                                                                      
        ASSIGN histProduto.usuario-id                 = produto.usuario-id                                                        
               histProduto.produto-id                 = produto.produto-id                                                      
               histProduto.histproduto-seq            = IF AVAIL bf-histProduto THEN bf-histProduto.histproduto-seq + 1 ELSE 1
               histProduto.categoria-id               = produto.categoria-id 
               histProduto.histproduto-valor          = produto.produto-valor
               histProduto.histproduto-valorVarejo    = produto.produto-valorVarejo
               histProduto.histproduto-estoqueCritico = produto.produto-estoqueCritico
               histProduto.histproduto-imagem         = produto.produto-imagem
               histProduto.histproduto-dataAlt        = produto.produto-dataAlt                                                 
               histProduto.histproduto-horaAlt        = produto.produto-horaAlt
               histProduto.histproduto-nome           = produto.produto-nome.
    END.
    ELSE DO:

        CREATE produto.
        ASSIGN produto.usuario-id = vsi-usr-id.

        FIND LAST bf-produto WHERE
                  bf-produto.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.
        IF AVAIL bf-produto THEN
            ASSIGN produto.produto-id = bf-produto.produto-id + 1.
        ELSE
            ASSIGN produto.produto-id = 1.

        FIND LAST histProduto WHERE                                                  
                  histProduto.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.
        IF AVAIL histProduto THEN
            IF histProduto.produto-id + 1 > produto.produto-id THEN
                ASSIGN produto.produto-id = histProduto.produto-id + 1.
    END.

    RUN pGravaIMG.

    ASSIGN produto.produto-nome           = TRIM(fil-nome:SCREEN-VALUE)
           produto.categoria-id           = INPUT cb-categoria
           produto.produto-valor          = INPUT fil-valor
           produto.produto-valorVarejo    = INPUT fil-valorvarejo
           produto.produto-estoqueCritico = INPUT fil-estoquecrit
           produto.produto-imagem         = cImgSalva
           produto.produto-dataAlt        = TODAY
           produto.produto-horaAlt        = TIME.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leitura sgDialog 
PROCEDURE p-leitura :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    ASSIGN imgFoto:STRETCH-TO-FIT = TRUE
           imgFoto:RETAIN-SHAPE   = TRUE.

    imgFoto:LOAD-IMAGE(cImgPadrao) IN FRAME {&FRAME-NAME} NO-ERROR.

    FOR EACH categoria WHERE                                              
             categoria.usuario-id = vsi-usr-id NO-LOCK.                   
                                                                          
        cb-categoria:ADD-LAST(categoria.categoria-descricao, categoria.categoria-id).
    END.    
    cb-categoria:ADD-FIRST(" ", 0).
    ASSIGN cb-categoria:SCREEN-VALUE = cb-categoria:ENTRY(1).

    IF viOPC = "A" THEN DO:

        FIND FIRST produto WHERE
                   produto.usuario-id = vsi-usr-id AND
                   produto.produto-id = viID NO-LOCK NO-ERROR.
        IF AVAIL produto THEN DO:

            ASSIGN fil-nome:SCREEN-VALUE        = string(produto.produto-nome)
                   cb-categoria:SCREEN-VALUE    = STRING(produto.categoria-id)
                   fil-valor:SCREEN-VALUE       = string(produto.produto-valor)
                   fil-valorvarejo:SCREEN-VALUE = string(produto.produto-valorVarejo)
                   fil-estoquecrit:SCREEN-VALUE = string(produto.produto-estoqueCritico)
                   cImgSalva                    = STRING(produto.produto-imagem).

            IF cImgSalva <> "" AND cImgSalva <> ? THEN
               RUN pCarregarImagem (cImgSalva).

        END.
    END.
    ELSE DO:
        ASSIGN cb-categoria:SCREEN-VALUE = cb-categoria:ENTRY(1).
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pCarregarImagem sgDialog 
PROCEDURE pCarregarImagem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

  DEFINE INPUT  PARAMETER pcArquivo AS CHARACTER NO-UNDO.

  IF pcArquivo = ? OR pcArquivo = "" THEN RETURN.

  /* Ajustes visuais (se preferir fixar no Property Sheet, remova daqui) */
  ASSIGN
    imgFoto:STRETCH-TO-FIT IN FRAME {&FRAME-NAME} = TRUE
    imgFoto:RETAIN-SHAPE   IN FRAME {&FRAME-NAME} = TRUE
    NO-ERROR.

  /* Validação e carga */
  IF SEARCH(pcArquivo) = ? THEN DO:
    MESSAGE "Arquivo não encontrado:" SKIP pcArquivo
      VIEW-AS ALERT-BOX ERROR.
    RETURN.
  END. 

  ASSIGN cImgSalva = pcArquivo.

  ENABLE bt-removeanexo.

  imgFoto:LOAD-IMAGE(pcArquivo) IN FRAME {&FRAME-NAME}.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pEnsureDir sgDialog 
PROCEDURE pEnsureDir :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

   DEFINE INPUT PARAMETER pcDir AS CHARACTER NO-UNDO.
   FILE-INFO:FILE-NAME = pcDir.
   IF FILE-INFO:FILE-TYPE = "D" THEN RETURN. /* já existe */
   OS-COMMAND SILENT VALUE(SUBSTITUTE('cmd /c mkdir "&1"', pcDir)).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pEscolherECarregar sgDialog 
PROCEDURE pEscolherECarregar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    /* 1) Selecionar arquivo */
    SYSTEM-DIALOG GET-FILE cSrc
      TITLE   "Selecione uma imagem (.jpg/.jpeg/.png)"
      FILTERS "Imagens (*.jpg;*.jpeg;*.png)" "*.jpg;*.jpeg;*.png"
      MUST-EXIST USE-FILENAME.
   
    IF cSrc = ? OR cSrc = "" THEN RETURN. /* usuário cancelou */
   
    /* 2) Validar extensão */
    ASSIGN cExt = fGetExt(cSrc).
    IF LOOKUP(cExt, "jpg,jpeg,png") = 0 THEN DO:
      MESSAGE "Arquivo inválido. Selecione um .jpg, .jpeg ou .png."
        VIEW-AS ALERT-BOX ERROR.
      RETURN.
    END.

    RUN pCarregarImagem IN THIS-PROCEDURE (cSrc).

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pGravaIMG sgDialog 
PROCEDURE pGravaIMG :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    IF cImgSalva = ? OR cImgSalva = "" THEN RETURN.

    ASSIGN cExt = fGetExt(cImgSalva).
    IF LOOKUP(cExt, "jpg,jpeg,png") = 0 THEN DO:
      MESSAGE "Falha ao salvar imagem."
        VIEW-AS ALERT-BOX ERROR.

      ASSIGN cImgSalva = "".
      RETURN.
    END.
  
    RUN pEnsureDir ({&DEST_DIR_IMG}).
    ASSIGN
      cBase = fBaseName(cImgSalva)
      cDest = {&DEST_DIR_IMG} + cBase.
  
    OS-DELETE VALUE(cDest) NO-ERROR.
    COPY-LOB FROM FILE cImgSalva TO FILE cDest NO-ERROR.
  
    IF ERROR-STATUS:ERROR THEN
      MESSAGE "Falha ao salvar imagem em:" SKIP cDest VIEW-AS ALERT-BOX ERROR.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pLimparImagem sgDialog 
PROCEDURE pLimparImagem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    ASSIGN cImgSalva = "".

    imgFoto:LOAD-IMAGE(cImgPadrao) IN FRAME {&FRAME-NAME} NO-ERROR.

    DISABLE bt-removeanexo.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fBaseName sgDialog 
FUNCTION fBaseName RETURNS CHARACTER
  ( pcPath AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  ASSIGN i = MAXIMUM(R-INDEX(pcPath, "\"), R-INDEX(pcPath, "/")).
  IF i = 0 THEN RETURN pcPath.
  RETURN SUBSTRING(pcPath, i + 1).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fGetExt sgDialog 
FUNCTION fGetExt RETURNS CHARACTER
  ( pcPath AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  IF pcPath = ? OR pcPath = "" THEN RETURN "".
  ASSIGN i = R-INDEX(pcPath, ".").
  IF i = 0 THEN RETURN "".
  RETURN LC(SUBSTRING(pcPath, i + 1)).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

