&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
*/
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

DEF SHARED VAR vsi-usr-id AS INT NO-UNDO.

DEF TEMP-TABLE tt-produtosDisp LIKE produto
    FIELD qtdDesconto   AS INT
    FIELD qtdDisponivel AS INT.

DEF TEMP-TABLE tt-produtosSelec LIKE tt-produtosDisp
    FIELD qtdSelec    AS INT
    FIELD vlrDesconto AS DEC
    FIELD precoTotal  AS DEC.

DEFINE VARIABLE cSrc   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cExt   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cDest  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cBase  AS CHARACTER NO-UNDO.

DEF VAR cImgSalva AS CHAR NO-UNDO.

DEF BUFFER bf-venda FOR venda.

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
&Scoped-define FRAME-NAME gDialog
&Scoped-define BROWSE-NAME br-produtoDisp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-produtosDisp tt-produtosSelec

/* Definitions for BROWSE br-produtoDisp                                */
&Scoped-define FIELDS-IN-QUERY-br-produtoDisp tt-produtosDisp.produto-nome tt-produtosDisp.qtdDisponivel tt-produtosDisp.produto-valor tt-produtosDisp.produto-valorVarejo tt-produtosDisp.qtdDesconto   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-produtoDisp   
&Scoped-define SELF-NAME br-produtoDisp
&Scoped-define QUERY-STRING-br-produtoDisp FOR EACH tt-produtosDisp
&Scoped-define OPEN-QUERY-br-produtoDisp OPEN QUERY {&SELF-NAME} FOR EACH tt-produtosDisp.
&Scoped-define TABLES-IN-QUERY-br-produtoDisp tt-produtosDisp
&Scoped-define FIRST-TABLE-IN-QUERY-br-produtoDisp tt-produtosDisp


/* Definitions for BROWSE br-produtoSelec                               */
&Scoped-define FIELDS-IN-QUERY-br-produtoSelec tt-produtosSelec.produto-nome tt-produtosSelec.qtdDisponivel tt-produtosSelec.qtdSelec tt-produtosSelec.precoTotal   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-produtoSelec   
&Scoped-define SELF-NAME br-produtoSelec
&Scoped-define QUERY-STRING-br-produtoSelec FOR EACH tt-produtosSelec
&Scoped-define OPEN-QUERY-br-produtoSelec OPEN QUERY {&SELF-NAME} FOR EACH tt-produtosSelec.
&Scoped-define TABLES-IN-QUERY-br-produtoSelec tt-produtosSelec
&Scoped-define FIRST-TABLE-IN-QUERY-br-produtoSelec tt-produtosSelec


/* Definitions for DIALOG-BOX gDialog                                   */
&Scoped-define OPEN-BROWSERS-IN-QUERY-gDialog ~
    ~{&OPEN-QUERY-br-produtoDisp}~
    ~{&OPEN-QUERY-br-produtoSelec}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-3 RECT-5 RECT-6 fil-filtroIdProduto ~
cb-filtroCategoria fil-filtroDescProduto bt-filtroProduto br-produtoDisp ~
bt-retiraTodos bt-retira bt-seleciona bt-selecionaTodos br-produtoSelec ~
fil-hora bt-anexa Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS fil-filtroIdProduto cb-filtroCategoria ~
fil-filtroDescProduto fil-data fil-hora fil-subtotal fil-desconto fil-total 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-converteHora gDialog 
FUNCTION f-converteHora RETURNS INTEGER
  ( cHora AS CHAR)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fBaseName gDialog 
FUNCTION fBaseName RETURNS CHARACTER
  ( pcPath AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fGetExt gDialog 
FUNCTION fGetExt RETURNS CHARACTER
  ( pcPath AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-anexa 
     LABEL "Anexar" 
     SIZE 15 BY 1.

DEFINE BUTTON bt-filtroProduto 
     LABEL "Filtrar" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-remove 
     LABEL "Remover" 
     SIZE 15 BY 1.

DEFINE BUTTON bt-retira 
     LABEL "" 
     SIZE 8 BY 1.19.

DEFINE BUTTON bt-retiraTodos 
     LABEL "" 
     SIZE 8 BY 1.19.

DEFINE BUTTON bt-seleciona 
     LABEL "" 
     SIZE 8 BY 1.19.

DEFINE BUTTON bt-selecionaTodos 
     LABEL "" 
     SIZE 8 BY 1.19.

DEFINE BUTTON bt-visualiza 
     LABEL "Visualizar" 
     SIZE 15 BY 1.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE cb-filtroCategoria AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     LABEL "Categoria" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 47 BY 1 NO-UNDO.

DEFINE VARIABLE fil-data AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE fil-desconto AS DECIMAL FORMAT ">>>>9.99":U INITIAL 0 
     LABEL "Desconto" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fil-filtroDescProduto AS CHARACTER FORMAT "X(256)":U 
     LABEL "Descrição" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 48.2 BY 1 NO-UNDO.

DEFINE VARIABLE fil-filtroIdProduto AS INTEGER FORMAT ">>>>>":U INITIAL 0 
     LABEL "ID" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE fil-hora AS CHARACTER FORMAT "99:99:99":U 
     LABEL "Hora" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE fil-subtotal AS DECIMAL FORMAT ">>>>9.99":U INITIAL 0 
     LABEL "Subtotal" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fil-total AS DECIMAL FORMAT ">>>>9.99":U INITIAL 0 
     LABEL "Total" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 73 BY 3.1.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 73 BY 6.95.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 1.67.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-produtoDisp FOR 
      tt-produtosDisp SCROLLING.

DEFINE QUERY br-produtoSelec FOR 
      tt-produtosSelec SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-produtoDisp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-produtoDisp gDialog _FREEFORM
  QUERY br-produtoDisp DISPLAY
      tt-produtosDisp.produto-nome         COLUMN-LABEL "Nome"            FORMAT "x(50)" 
      tt-produtosDisp.qtdDisponivel        COLUMN-LABEL "Qtd. Disponivel" FORMAT ">>>>>"
      tt-produtosDisp.produto-valor        COLUMN-LABEL "Valor"
      tt-produtosDisp.produto-valorVarejo  COLUMN-LABEL "Valor Varejo"
      tt-produtosDisp.qtdDesconto          COLUMN-LABEL "% Desconto"      FORMAT ">>>"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 73 BY 6.19
         TITLE "Produtos Disponíveis" FIT-LAST-COLUMN.

DEFINE BROWSE br-produtoSelec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-produtoSelec gDialog _FREEFORM
  QUERY br-produtoSelec DISPLAY
      tt-produtosSelec.produto-nome  COLUMN-LABEL "Nome"            FORMAT "x(50)"   
      tt-produtosSelec.qtdDisponivel COLUMN-LABEL "QTD.Disponivel"  FORMAT ">>>>"
      tt-produtosSelec.qtdSelec      COLUMN-LABEL "Qtd.Selecionada" FORMAT ">>>>"  
      tt-produtosSelec.precoTotal    COLUMN-LABEL "Valor"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 73 BY 6.19
         TITLE "Produtos Selecionados" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME gDialog
     fil-filtroIdProduto AT ROW 2.33 COL 5.6 COLON-ALIGNED WIDGET-ID 40
     cb-filtroCategoria AT ROW 2.33 COL 25.8 COLON-ALIGNED WIDGET-ID 46
     fil-filtroDescProduto AT ROW 3.52 COL 12.6 COLON-ALIGNED WIDGET-ID 42
     bt-filtroProduto AT ROW 3.52 COL 63.8 WIDGET-ID 44
     br-produtoDisp AT ROW 5.05 COL 3 WIDGET-ID 300
     bt-retiraTodos AT ROW 11.48 COL 21.8 WIDGET-ID 52
     bt-retira AT ROW 11.48 COL 30 WIDGET-ID 54
     bt-seleciona AT ROW 11.48 COL 40 WIDGET-ID 48
     bt-selecionaTodos AT ROW 11.48 COL 48.2 WIDGET-ID 50
     br-produtoSelec AT ROW 12.95 COL 3 WIDGET-ID 400
     fil-data AT ROW 20.81 COL 8.4 COLON-ALIGNED WIDGET-ID 66
     fil-hora AT ROW 20.81 COL 31 COLON-ALIGNED WIDGET-ID 68
     fil-subtotal AT ROW 20.81 COL 58.4 COLON-ALIGNED WIDGET-ID 70
     fil-desconto AT ROW 22.05 COL 58.4 COLON-ALIGNED WIDGET-ID 76
     fil-total AT ROW 23.24 COL 58.4 COLON-ALIGNED WIDGET-ID 78
     bt-anexa AT ROW 24.86 COL 24.2 WIDGET-ID 34
     bt-remove AT ROW 24.86 COL 39.6 WIDGET-ID 36
     bt-visualiza AT ROW 24.86 COL 54.8 WIDGET-ID 38
     Btn_OK AT ROW 27.1 COL 46
     Btn_Cancel AT ROW 27.1 COL 60.8
     "Venda:" VIEW-AS TEXT
          SIZE 7.6 BY .62 AT ROW 19.52 COL 4.4 WIDGET-ID 64
     "Busca Produtos Disponíveis:" VIEW-AS TEXT
          SIZE 29 BY .62 AT ROW 1.48 COL 4.6 WIDGET-ID 60
     "Nota Fiscal:" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 25.1 COL 8.6 WIDGET-ID 74
     RECT-3 AT ROW 1.71 COL 3 WIDGET-ID 58
     RECT-5 AT ROW 19.76 COL 3.2 WIDGET-ID 62
     RECT-6 AT ROW 24.52 COL 6.6 WIDGET-ID 72
     SPACE(5.59) SKIP(2.37)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Registra Venda"
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
/* BROWSE-TAB br-produtoDisp bt-filtroProduto gDialog */
/* BROWSE-TAB br-produtoSelec bt-selecionaTodos gDialog */
ASSIGN 
       FRAME gDialog:SCROLLABLE       = FALSE
       FRAME gDialog:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-remove IN FRAME gDialog
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bt-visualiza IN FRAME gDialog
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-data IN FRAME gDialog
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-desconto IN FRAME gDialog
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-subtotal IN FRAME gDialog
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-total IN FRAME gDialog
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-produtoDisp
/* Query rebuild information for BROWSE br-produtoDisp
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-produtosDisp.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-produtoDisp */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-produtoSelec
/* Query rebuild information for BROWSE br-produtoSelec
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-produtosSelec.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-produtoSelec */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX gDialog
/* Query rebuild information for DIALOG-BOX gDialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX gDialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME gDialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL gDialog gDialog
ON WINDOW-CLOSE OF FRAME gDialog /* Registra Venda */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-anexa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-anexa gDialog
ON CHOOSE OF bt-anexa IN FRAME gDialog /* Anexar */
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


&Scoped-define SELF-NAME bt-filtroProduto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroProduto gDialog
ON CHOOSE OF bt-filtroProduto IN FRAME gDialog /* Filtrar */
DO:
    RUN p-filtro.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-remove
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-remove gDialog
ON CHOOSE OF bt-remove IN FRAME gDialog /* Remover */
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


&Scoped-define SELF-NAME bt-retira
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-retira gDialog
ON CHOOSE OF bt-retira IN FRAME gDialog
DO:
    DO WITH FRAME {&FRAME-NAME}:

        FIND CURRENT tt-produtosSelec EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL tt-produtosSelec THEN DO:

            ASSIGN fil-total:SCREEN-VALUE    = STRING(INPUT fil-total - tt-produtosSelec.precoTotal)
                   fil-desconto:SCREEN-VALUE = STRING(INPUT fil-desconto - tt-produtosSelec.vlrDesconto)
                   fil-subtotal:SCREEN-VALUE = STRING(INPUT fil-subtotal - (tt-produtosSelec.produto-valorVarejo * tt-produtosSelec.qtdSelec)).
            
            DELETE tt-produtosSelec.

            {&OPEN-QUERY-br-produtoSelec}

            RUN p-filtro.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-retiraTodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-retiraTodos gDialog
ON CHOOSE OF bt-retiraTodos IN FRAME gDialog
DO:
    DO WITH FRAME {&FRAME-NAME}:

        FOR EACH tt-produtosSelec EXCLUSIVE-LOCK.
            
            DELETE tt-produtosSelec. 
        END.

        {&OPEN-QUERY-br-produtoSelec}

        ASSIGN fil-subtotal:SCREEN-VALUE = "0"
               fil-desconto:SCREEN-VALUE = "0"
               fil-total:SCREEN-VALUE    = "0".
                                     
        RUN p-filtro.                
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-seleciona
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-seleciona gDialog
ON CHOOSE OF bt-seleciona IN FRAME gDialog
DO:
    DO WITH FRAME {&FRAME-NAME}:
        DEF VAR iAuxQTD AS INT NO-UNDO.

        ASSIGN iAuxQTD = ?.

        FIND CURRENT tt-produtosDisp EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL tt-produtosDisp THEN DO:

            RUN produtoVenda.w (INPUT "I",
                                INPUT ?,
                                INPUT tt-produtosDisp.qtdDisponivel,
                                INPUT tt-produtosDisp.produto-valorVarejo,
                                INPUT tt-produtosDisp.qtdDesconto,
                                OUTPUT iAuxQTD).

            IF iAuxQTD <> ? THEN DO:

                FIND FIRST tt-produtosSelec WHERE
                           tt-produtosSelec.produto-id = tt-produtosDisp.produto-id NO-LOCK NO-ERROR.
                IF NOT AVAIL tt-produtosSelec THEN DO:

                    CREATE tt-produtosSelec.
                    BUFFER-COPY tt-produtosDisp TO tt-produtosSelec.
                END.

                ASSIGN tt-produtosSelec.qtdSelec    = iAuxQTD
                       tt-produtosSelec.vlrDesconto = IF tt-produtosDisp.qtdDesconto > 0 THEN tt-produtosSelec.produto-valorVarejo * iAuxQTD ELSE 0                     
                       tt-produtosSelec.vlrDesconto = IF tt-produtosDisp.qtdDesconto > 0 THEN tt-produtosSelec.vlrDesconto * (tt-produtosDisp.qtdDesconto / 100) ELSE 0 
                       tt-produtosSelec.precoTotal  = iAuxQTD * tt-produtosDisp.produto-valorVarejo - tt-produtosSelec.vlrDesconto.

                DELETE tt-produtosDisp.

                ASSIGN fil-total:SCREEN-VALUE    = STRING(INPUT fil-total    + tt-produtosSelec.precoTotal)                                          
                       fil-desconto:SCREEN-VALUE = STRING(INPUT fil-desconto + tt-produtosSelec.vlrDesconto)                                       
                       fil-subtotal:SCREEN-VALUE = STRING(INPUT fil-subtotal + (tt-produtosSelec.produto-valorVarejo * tt-produtosSelec.qtdSelec)).

                {&OPEN-QUERY-br-produtoDisp} 
                {&OPEN-QUERY-br-produtoSelec}
            END.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-selecionaTodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-selecionaTodos gDialog
ON CHOOSE OF bt-selecionaTodos IN FRAME gDialog
DO:
    DO WITH FRAME {&FRAME-NAME}:
        DEF VAR iAuxQTD  AS INT NO-UNDO.
        DEF VAR dAuxVlr  AS DEC NO-UNDO.
        DEF VAR dAuxVlr2 AS DEC NO-UNDO.
        DEF VAR dAuxVlr3 AS DEC NO-UNDO.

        ASSIGN iAuxQTD  = ?
               dAuxVlr  = 0
               dAuxVlr2 = 0
               dAuxVlr3 = 0.

        FIND FIRST tt-produtosDisp NO-LOCK NO-ERROR.
        IF AVAIL tt-produtosDisp THEN
            RUN produtoQuantidade.w (OUTPUT iAuxQTD).

        IF iAuxQTD <> ? THEN DO:

           FOR EACH tt-produtosDisp EXCLUSIVE-LOCK.

               IF tt-produtosDisp.qtdDisponivel < iAuxQTD THEN DO:

                   MESSAGE "O produto: " + tt-produtosDisp.produto-nome + " não será incluido," SKIP
                           "pois possui apenas " + STRING(tt-produtosDisp.qtdDisponivel) + " disponivel."
                       VIEW-AS ALERT-BOX INFO BUTTONS OK.

                   NEXT.
               END.
                   
               FIND FIRST tt-produtosSelec WHERE
                          tt-produtosSelec.produto-id = tt-produtosDisp.produto-id NO-LOCK NO-ERROR.
               IF NOT AVAIL tt-produtosSelec THEN DO:
               
                   CREATE tt-produtosSelec.
                   BUFFER-COPY tt-produtosDisp TO tt-produtosSelec.
               END.

               ASSIGN tt-produtosSelec.qtdSelec    = iAuxQTD
                      tt-produtosSelec.vlrDesconto = IF tt-produtosDisp.qtdDesconto > 0 THEN tt-produtosSelec.produto-valorVarejo * iAuxQTD ELSE 0
                      tt-produtosSelec.vlrDesconto = IF tt-produtosDisp.qtdDesconto > 0 THEN tt-produtosSelec.vlrDesconto * (tt-produtosDisp.qtdDesconto / 100) ELSE 0
                      tt-produtosSelec.precoTotal  = (tt-produtosSelec.produto-valorVarejo * iAuxQTD) - tt-produtosSelec.vlrDesconto
                      dAuxVlr  = dAuxVlr  + tt-produtosSelec.precoTotal
                      dAuxVlr2 = dAuxVlr2 + tt-produtosSelec.vlrDesconto
                      dAuxVlr3 = dAuxVlr3 + (tt-produtosSelec.produto-valorVarejo * iAuxQTD).
               
               DELETE tt-produtosDisp.   
           END.

           ASSIGN fil-total:SCREEN-VALUE    = STRING(INPUT fil-total + dAuxVlr)
                  fil-desconto:SCREEN-VALUE = STRING(INPUT fil-desconto + dAuxVlr2)
                  fil-subtotal:SCREEN-VALUE = STRING(INPUT fil-subtotal + dAuxVlr3).

           {&OPEN-QUERY-br-produtoDisp} 
           {&OPEN-QUERY-br-produtoSelec}

        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-visualiza
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-visualiza gDialog
ON CHOOSE OF bt-visualiza IN FRAME gDialog /* Visualizar */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        /* Validação e carga */                      
        IF SEARCH(cImgSalva) = ? THEN DO:                 
          MESSAGE "Arquivo não encontrado:" SKIP cImgSalva
            VIEW-AS ALERT-BOX ERROR.                 
          RETURN.                                    
        END.                                         

        OS-COMMAND NO-WAIT VALUE('"' + cImgSalva + '"').
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK gDialog
ON CHOOSE OF Btn_OK IN FRAME gDialog /* OK */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        IF INPUT fil-data = ? THEN DO:

            MESSAGE "Favor informar uma data."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        IF INPUT fil-hora = ? OR TRIM(INPUT fil-hora) = "" THEN DO:

            MESSAGE "Favor informar uma hora."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        IF (int(SUBSTRING(STRING(INPUT fil-hora),1,2,"CHARACTER")) >= 0 AND 
            int(SUBSTRING(STRING(INPUT fil-hora),1,2,"CHARACTER")) <= 24   ) OR
           (int(SUBSTRING(STRING(INPUT fil-hora),3,2,"CHARACTER")) >= 0 AND      
            int(SUBSTRING(STRING(INPUT fil-hora),3,2,"CHARACTER")) <= 59   ) OR 
           (int(SUBSTRING(STRING(INPUT fil-hora),5,2,"CHARACTER")) >= 0 AND  
            int(SUBSTRING(STRING(INPUT fil-hora),5,2,"CHARACTER")) <= 59   ) THEN.
        ELSE DO:

            MESSAGE "Favor informar uma hora válida."    
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.                      
        END.

        FIND FIRST tt-produtosSelec NO-LOCK NO-ERROR.
        IF NOT AVAIL tt-produtosSelec THEN DO:

            MESSAGE "Favor selecionar pelo menos um produto."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        RUN p-grava.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-produtoDisp
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
  DISPLAY fil-filtroIdProduto cb-filtroCategoria fil-filtroDescProduto fil-data 
          fil-hora fil-subtotal fil-desconto fil-total 
      WITH FRAME gDialog.
  ENABLE RECT-3 RECT-5 RECT-6 fil-filtroIdProduto cb-filtroCategoria 
         fil-filtroDescProduto bt-filtroProduto br-produtoDisp bt-retiraTodos 
         bt-retira bt-seleciona bt-selecionaTodos br-produtoSelec fil-hora 
         bt-anexa Btn_OK Btn_Cancel 
      WITH FRAME gDialog.
  VIEW FRAME gDialog.
  {&OPEN-BROWSERS-IN-QUERY-gDialog}
  RUN p-leitura.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-filtro gDialog 
PROCEDURE p-filtro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:
    EMPTY TEMP-TABLE tt-produtosDisp.

    FOR EACH produto WHERE                                                        
             produto.usuario-id = vsi-usr-id NO-LOCK. 

        IF INPUT fil-filtroIdProduto <> ? AND INPUT fil-filtroIdProduto <> 0 THEN DO:
            IF INPUT fil-filtroIdProduto <> produto.produto-id THEN
                NEXT.
        END. 

        IF INPUT cb-filtroCategoria <> ? AND INPUT cb-filtroCategoria <> 0 THEN DO:
            IF INPUT cb-filtroCategoria <> produto.categoria-id THEN
                NEXT.
        END. 

        IF TRIM(fil-filtroDescProduto:SCREEN-VALUE) <> "" THEN DO:
            IF produto.produto-nome MATCHES("*" + TRIM(fil-filtroDescProduto:SCREEN-VALUE) + "*") THEN.
            ELSE
                NEXT.
        END.
                                                                                                                                                                                                                      
        FIND FIRST tt-produtosSelec WHERE                                     
                   tt-produtosSelec.produto-id = produto.produto-id NO-LOCK NO-ERROR. 
        IF AVAIL tt-produtosSelec THEN                                        
            NEXT.  

        FIND LAST estoque WHERE                                                                
                  estoque.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.                            
        IF AVAIL estoque THEN DO:                                                              
                                                                                               
            CREATE tt-produtosDisp.                                                            
            BUFFER-COPY produto TO tt-produtosDisp.                                            
            ASSIGN tt-produtosDisp.qtdDesconto = 0.                                            
                                                                                               
            FIND LAST desconto WHERE                                                           
                      desconto.usuario-id = vsi-usr-id AND                                     
                      desconto.desconto-dataIni <= TODAY AND                                   
                      desconto.desconto-dataFim >= TODAY NO-LOCK NO-ERROR.                     
            IF AVAIL desconto THEN DO:                                                         
                                                                                               
                FIND FIRST descontoProduto WHERE                                               
                           descontoProduto.usuario-id  = vsi-usr-id AND                        
                           descontoProduto.desconto-id = desconto.desconto-id AND              
                           descontoProduto.produto-id  = produto.produto-id NO-LOCK NO-ERROR.  
                IF AVAIL descontoProduto THEN                                                  
                    ASSIGN tt-produtosDisp.qtdDesconto = descontoProduto.descontoproduto-valor.            
            END.                                                                               
                                                                                               
            FIND FIRST estoqueProduto WHERE                                                    
                       estoqueProduto.usuario-id = vsi-usr-id AND                              
                       estoqueProduto.estoque-id = estoque.estoque-id AND                      
                       estoqueProduto.produto-id = produto.produto-id NO-LOCK NO-ERROR.        
            IF AVAIL estoqueProduto AND                                                        
               estoqueProduto.estoqueproduto-quantidade > 0 THEN                               
                ASSIGN tt-produtosDisp.qtdDisp = estoqueProduto.estoqueproduto-quantidade.     
            ELSE                                                                               
                DELETE tt-produtosDisp.                                                        
        END.                                                                                   
    END.                                                                          

    {&OPEN-QUERY-br-produtoDisp}
END.
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

    FIND LAST estoque WHERE
              estoque.usuario-id = vsi-usr-id EXCLUSIVE-LOCK NO-ERROR.
    IF AVAIL estoque THEN DO:

        RUN pGravaIMG.

        FIND LAST bf-venda WHERE
                  bf-venda.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.

        CREATE venda.
        ASSIGN venda.usuario-id       = vsi-usr-id
               venda.venda-id         = IF AVAIL bf-venda THEN bf-venda.venda-id + 1 ELSE 1
               venda.venda-data       = INPUT fil-data
               venda.venda-hora       = f-converteHora(STRING(INPUT fil-hora,"99:99:99"))
               venda.venda-notafiscal = cImgSalva
               venda.venda-dataAlt    = TODAY
               venda.venda-horaAlt    = TIME.

        FOR EACH tt-produtosSelec NO-LOCK.

            CREATE vendaProduto.
            ASSIGN vendaProduto.usuario-id                = vsi-usr-id
                   vendaProduto.venda-id                  = venda.venda-id
                   vendaProduto.produto-id                = tt-produtosSelec.produto-id 
                   vendaProduto.vendaproduto-quantidade   = tt-produtosSelec.qtdSelec
                   vendaProduto.vendaproduto-valorUnidade = tt-produtosSelec.precoTotal / tt-produtosSelec.qtdSelec
                   vendaProduto.vendaproduto-valorTotal   = tt-produtosSelec.precoTotal
                   vendaProduto.vendaproduto-dataAlt      = TODAY 
                   vendaProduto.vendaproduto-horaAlt      = TIME. 

            FIND LAST estoqueProduto WHERE
                      estoqueProduto.usuario-id = vsi-usr-id AND
                      estoqueProduto.estoque-id = estoque.estoque-id AND
                      estoqueProduto.produto-id = tt-produtosSelec.produto-id EXCLUSIVE-LOCK NO-ERROR.
            IF AVAIL estoqueProduto THEN DO:

                ASSIGN estoqueProduto.estoqueproduto-quantidade = estoqueProduto.estoqueproduto-quantidade - tt-produtosSelec.qtdSelec
                       estoqueProduto.estoqueproduto-dataAlt = TODAY                                                                  
                       estoqueProduto.estoqueproduto-horaAlt = TIME.                                                                  
            END.   
        END.

        ASSIGN estoque.estoque-dataAlt = TODAY
               estoque.estoque-horaAlt = TIME.
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

    EMPTY TEMP-TABLE tt-produtosSelec.
    EMPTY TEMP-TABLE tt-produtosDisp. 
    
    ASSIGN bt-retiraTodos:LABEL IN FRAME {&FRAME-NAME} = ""
           bt-retira:LABEL IN FRAME {&FRAME-NAME} = ""
           bt-selecionaTodos:LABEL IN FRAME {&FRAME-NAME} = ""
           bt-seleciona:LABEL IN FRAME {&FRAME-NAME} = ""
           NO-ERROR.

    bt-retiraTodos:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\setas-cima.png") IN FRAME {&FRAME-NAME}.
    bt-retira:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\seta-cima.png") IN FRAME {&FRAME-NAME}.
    bt-selecionaTodos:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\setas-baixo.png") IN FRAME {&FRAME-NAME}.
    bt-seleciona:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\seta-baixo.png") IN FRAME {&FRAME-NAME}.

    FOR EACH categoria WHERE                                                               
             categoria.usuario-id = vsi-usr-id NO-LOCK.                                    
                                                                                           
        cb-filtroCategoria:ADD-LAST(categoria.categoria-descricao, categoria.categoria-id).
    END.                                                                                   
    cb-filtroCategoria:ADD-FIRST(" ", 0).                                                                                       
    ASSIGN cb-filtroCategoria:SCREEN-VALUE = cb-filtroCategoria:ENTRY(1).      

    FOR EACH produto WHERE                                                                                  
             produto.usuario-id = vsi-usr-id NO-LOCK. 

        FIND LAST estoque WHERE
                  estoque.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.
        IF AVAIL estoque THEN DO:

            CREATE tt-produtosDisp.                
            BUFFER-COPY produto TO tt-produtosDisp.
            ASSIGN tt-produtosDisp.qtdDesconto = 0.

            FIND LAST desconto WHERE
                      desconto.usuario-id = vsi-usr-id AND
                      desconto.desconto-dataIni <= TODAY AND
                      desconto.desconto-dataFim >= TODAY NO-LOCK NO-ERROR.
            IF AVAIL desconto THEN DO:

                FIND FIRST descontoProduto WHERE
                           descontoProduto.usuario-id  = vsi-usr-id AND
                           descontoProduto.desconto-id = desconto.desconto-id AND
                           descontoProduto.produto-id  = produto.produto-id NO-LOCK NO-ERROR.
                IF AVAIL descontoProduto THEN
                    ASSIGN tt-produtosDisp.qtdDesconto = descontoProduto.descontoproduto-valor.
            END.
                                                                                                            
            FIND FIRST estoqueProduto WHERE                                                                     
                       estoqueProduto.usuario-id = vsi-usr-id AND                                               
                       estoqueProduto.estoque-id = estoque.estoque-id AND                                       
                       estoqueProduto.produto-id = produto.produto-id NO-LOCK NO-ERROR.                         
            IF AVAIL estoqueProduto AND 
               estoqueProduto.estoqueproduto-quantidade > 0 THEN 
                ASSIGN tt-produtosDisp.qtdDisp = estoqueProduto.estoqueproduto-quantidade.
            ELSE
                DELETE tt-produtosDisp.                                                                                                
        END.
    END. 

    ASSIGN fil-data:SCREEN-VALUE     = STRING(TODAY)          
           fil-hora:SCREEN-VALUE     = STRING(TIME,"HH:MM:SS")
           fil-subtotal:SCREEN-VALUE = "0" 
           fil-desconto:SCREEN-VALUE = "0" 
           fil-total:SCREEN-VALUE    = "0".

    {&OPEN-QUERY-br-produtoDisp}
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pEnsureDir gDialog 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pEscolherECarregar gDialog 
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

    /* Validação e carga */                           
    IF SEARCH(cSrc) = ? THEN DO:                 
      MESSAGE "Arquivo não encontrado:" SKIP cSrc
        VIEW-AS ALERT-BOX ERROR.                      
      RETURN.                                         
    END.                                              
                                                      
    ASSIGN cImgSalva = cSrc.                     
                                                      
    ENABLE bt-remove
           bt-visualiza.                            

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pGravaIMG gDialog 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pLimparImagem gDialog 
PROCEDURE pLimparImagem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    ASSIGN cImgSalva = "".

    DISABLE bt-remove
            bt-visualiza.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-converteHora gDialog 
FUNCTION f-converteHora RETURNS INTEGER
  ( cHora AS CHAR) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE iHora     AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iMin      AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iSeg      AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iTotal    AS INTEGER   NO-UNDO.
    
    iHora = INTEGER(ENTRY(1, cHora, ":")).
    iMin  = INTEGER(ENTRY(2, cHora, ":")).
    iSeg  = INTEGER(ENTRY(3, cHora, ":")).
    
    iTotal = (iHora * 3600) + (iMin * 60) + iSeg.

    RETURN iTotal.
    
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fBaseName gDialog 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fGetExt gDialog 
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

