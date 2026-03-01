&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME wWin
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
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

DEF TEMP-TABLE tt-estoque LIKE estoqueProduto
    FIELD nomeProduto   AS CHAR
    FIELD descCategoria AS CHAR
    FIELD estoqueMin    AS INT
    FIELD corLinha      AS INT.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain
&Scoped-define BROWSE-NAME br-estoque

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-estoque

/* Definitions for BROWSE br-estoque                                    */
&Scoped-define FIELDS-IN-QUERY-br-estoque tt-estoque.estoqueproduto-quantidade tt-estoque.nomeProduto tt-estoque.descCategoria   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-estoque   
&Scoped-define SELF-NAME br-estoque
&Scoped-define QUERY-STRING-br-estoque FOR EACH tt-estoque
&Scoped-define OPEN-QUERY-br-estoque OPEN QUERY {&SELF-NAME} FOR EACH tt-estoque.
&Scoped-define TABLES-IN-QUERY-br-estoque tt-estoque
&Scoped-define FIRST-TABLE-IN-QUERY-br-estoque tt-estoque


/* Definitions for FRAME fMain                                          */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fMain ~
    ~{&OPEN-QUERY-br-estoque}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 bt-compra fil-filtroIdProduto ~
fil-filtroDescProduto bt-venda cb-filtroCategoria bt-filtroProduto ~
br-estoque Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS fil-filtroIdProduto fil-filtroDescProduto ~
cb-filtroCategoria 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-compra 
     LABEL "Registrar Compra" 
     SIZE 21 BY 1.1.

DEFINE BUTTON bt-filtroProduto 
     LABEL "Filtrar" 
     SIZE 12.2 BY 1.

DEFINE BUTTON bt-venda 
     LABEL "Registrar Venda" 
     SIZE 21 BY 1.1.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Sair" 
     SIZE 17.4 BY 1.1.

DEFINE VARIABLE cb-filtroCategoria AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     LABEL "Categoria" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 47 BY 1 NO-UNDO.

DEFINE VARIABLE fil-filtroDescProduto AS CHARACTER FORMAT "X(256)":U 
     LABEL "Descrição" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 48.2 BY 1 NO-UNDO.

DEFINE VARIABLE fil-filtroIdProduto AS INTEGER FORMAT ">>>>>":U INITIAL 0 
     LABEL "ID" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 74 BY 3.1.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 25 BY 3.1.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-estoque FOR 
      tt-estoque SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-estoque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-estoque wWin _FREEFORM
  QUERY br-estoque DISPLAY
      tt-estoque.estoqueproduto-quantidade column-label "Qtd."      FORMAT ">>>9"
      tt-estoque.nomeProduto               column-label "Produto"   FORMAT "x(50)"
      tt-estoque.descCategoria             column-label "Categoria" FORMAT "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 99.2 BY 13.1
         TITLE "Estoque" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     bt-compra AT ROW 1.67 COL 79.4 WIDGET-ID 4
     fil-filtroIdProduto AT ROW 1.71 COL 5.2 COLON-ALIGNED WIDGET-ID 40
     fil-filtroDescProduto AT ROW 1.71 COL 25 COLON-ALIGNED WIDGET-ID 42
     bt-venda AT ROW 2.95 COL 79.4 WIDGET-ID 6
     cb-filtroCategoria AT ROW 3 COL 12.2 COLON-ALIGNED WIDGET-ID 46
     bt-filtroProduto AT ROW 3 COL 62.8 WIDGET-ID 44
     br-estoque AT ROW 4.57 COL 3 WIDGET-ID 200
     Btn_Cancel AT ROW 18.1 COL 84 WIDGET-ID 2
     RECT-2 AT ROW 1.29 COL 3 WIDGET-ID 48
     RECT-3 AT ROW 1.29 COL 77.4 WIDGET-ID 52
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 102.6 BY 18.67 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "Consulta de Estoque"
         HEIGHT             = 18.67
         WIDTH              = 102.6
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 146.2
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 146.2
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
/* BROWSE-TAB br-estoque bt-filtroProduto fMain */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-estoque
/* Query rebuild information for BROWSE br-estoque
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-estoque.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-estoque */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Consulta de Estoque */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Consulta de Estoque */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-estoque
&Scoped-define SELF-NAME br-estoque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-estoque wWin
ON ROW-DISPLAY OF br-estoque IN FRAME fMain /* Estoque */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN tt-estoque.estoqueproduto-quantidade:BGCOLOR IN BROWSE br-estoque = tt-estoque.corLinha
               tt-estoque.nomeProduto:BGCOLOR               IN BROWSE br-estoque = tt-estoque.corLinha
               tt-estoque.descCategoria:BGCOLOR             IN BROWSE br-estoque = tt-estoque.corLinha.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-compra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-compra wWin
ON CHOOSE OF bt-compra IN FRAME fMain /* Registrar Compra */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        RUN criaCompra.w.

        RUN p-limpaFiltro.

        APPLY "CHOOSE" TO bt-filtroProduto.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-filtroProduto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroProduto wWin
ON CHOOSE OF bt-filtroProduto IN FRAME fMain /* Filtrar */
DO:
  RUN p-filtroProduto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-venda wWin
ON CHOOSE OF bt-venda IN FRAME fMain /* Registrar Venda */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        RUN criaVenda.w.

        RUN p-limpaFiltro.

        APPLY "CHOOSE" TO bt-filtroProduto.

        RUN p-alerta.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */

{src/adm2/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
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
  DISPLAY fil-filtroIdProduto fil-filtroDescProduto cb-filtroCategoria 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE RECT-2 RECT-3 bt-compra fil-filtroIdProduto fil-filtroDescProduto 
         bt-venda cb-filtroCategoria bt-filtroProduto br-estoque Btn_Cancel 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  VIEW wWin.
  RUN p-leitura.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-alerta wWin 
PROCEDURE p-alerta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:
    DEF VAR cAUXalerta AS CHAR NO-UNDO.

    ASSIGN cAUXalerta = "".

    FOR EACH tt-estoque WHERE 
             tt-estoque.corLinha = 12 NO-LOCK.

        ASSIGN cAUXalerta = IF cAUXalerta = "" THEN "ID: " + string(tt-estoque.produto-id) + " - Nome: " + tt-estoque.nomeProduto + " - Qtd.:" + STRING(tt-estoque.estoqueproduto-quantidade)
                                               ELSE cAUXalerta + CHR(10) + "ID: " + string(tt-estoque.produto-id) + " - Nome: " + tt-estoque.nomeProduto + " - Qtd.:" + STRING(tt-estoque.estoqueproduto-quantidade).
    END.

    IF cAUXalerta <> "" THEN DO:

        MESSAGE "O(s) seguinte(s) produto(s) estão sem estoque ou abaixo da quantidade mínima:" SKIP SKIP
                cAUXalerta
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-filtroProduto wWin 
PROCEDURE p-filtroProduto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    EMPTY TEMP-TABLE tt-estoque.

    FIND LAST estoque WHERE                                                                                 
              estoque.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.                                             
    IF AVAIL estoque THEN DO:                                                                               
                                                                                                            
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
                                                                                                            
            FIND FIRST categoria WHERE                                                                      
                       categoria.usuario-id   = vsi-usr-id AND                                              
                       categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.                      
                                                                                                            
            FIND FIRST estoqueProduto WHERE                                                                 
                       estoqueProduto.usuario-id = vsi-usr-id AND                                           
                       estoqueProduto.estoque-id = estoque.estoque-id AND                                   
                       estoqueProduto.produto-id = produto.produto-id NO-LOCK NO-ERROR.                     
            IF AVAIL estoqueProduto THEN DO:                                                                
                                                                                                            
                CREATE tt-estoque.                                                                          
                BUFFER-COPY estoqueProduto TO tt-estoque.                                                   
            END.                                                                                            
            ELSE DO:                                                                                        
                                                                                                            
                CREATE tt-estoque.                                                                          
                ASSIGN tt-estoque.usuario-id = vsi-usr-id                                                   
                       tt-estoque.estoque-id = estoque.estoque-id                                           
                       tt-estoque.produto-id = produto.produto-id                                           
                       tt-estoque.estoqueproduto-quantidade = 0.                                            
            END.                                                                                            
                                                                                                            
            ASSIGN tt-estoque.nomeProduto   = produto.produto-nome                                          
                   tt-estoque.descCategoria = IF AVAIL categoria THEN categoria.categoria-descricao ELSE "" 
                   tt-estoque.estoqueMin    = produto.produto-estoqueCritico
                   tt-estoque.corLinha      = 10.

            IF tt-estoque.estoqueproduto-quantidade = 0 THEN 
                ASSIGN tt-estoque.corLinha = 12.
            ELSE DO:

                IF tt-estoque.estoqueproduto-quantidade = tt-estoque.estoqueMin THEN
                    ASSIGN tt-estoque.corLinha = 14.
                ELSE IF tt-estoque.estoqueproduto-quantidade < tt-estoque.estoqueMin THEN
                    ASSIGN tt-estoque.corLinha = 12.
            END.
        END.                                                                                                
                                                                                                            
        {&OPEN-QUERY-br-estoque}                                                                            
    END.                                                                                                    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leitura wWin 
PROCEDURE p-leitura :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    EMPTY TEMP-TABLE tt-estoque.

    FOR EACH categoria WHERE                                                               
             categoria.usuario-id = vsi-usr-id NO-LOCK.                                    
                                                                                           
        cb-filtroCategoria:ADD-LAST(categoria.categoria-descricao, categoria.categoria-id).
    END.       
    cb-filtroCategoria:ADD-FIRST(" ", 0).
    ASSIGN cb-filtroCategoria:SCREEN-VALUE = cb-filtroCategoria:ENTRY(1).                  

    FIND LAST estoque WHERE
              estoque.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.
    IF AVAIL estoque THEN DO:

        FOR EACH produto WHERE                  
                 produto.usuario-id = vsi-usr-id NO-LOCK.

            FIND FIRST categoria WHERE
                       categoria.usuario-id   = vsi-usr-id AND
                       categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.

            FIND FIRST estoqueProduto WHERE                                   
                       estoqueProduto.usuario-id = vsi-usr-id AND             
                       estoqueProduto.estoque-id = estoque.estoque-id AND
                       estoqueProduto.produto-id = produto.produto-id NO-LOCK NO-ERROR.
            IF AVAIL estoqueProduto THEN DO:

                CREATE tt-estoque.
                BUFFER-COPY estoqueProduto TO tt-estoque.
            END.
            ELSE DO:

                CREATE tt-estoque.
                ASSIGN tt-estoque.usuario-id = vsi-usr-id
                       tt-estoque.estoque-id = estoque.estoque-id
                       tt-estoque.produto-id = produto.produto-id
                       tt-estoque.estoqueproduto-quantidade = 0.
            END.

            ASSIGN tt-estoque.nomeProduto   = produto.produto-nome
                   tt-estoque.descCategoria = IF AVAIL categoria THEN categoria.categoria-descricao ELSE ""
                   tt-estoque.estoqueMin    = produto.produto-estoqueCritico
                   tt-estoque.corLinha      = 10.

            IF tt-estoque.estoqueproduto-quantidade = 0 THEN                             
                ASSIGN tt-estoque.corLinha = 12.                                         
            ELSE DO:                                                                     
                                                                                         
                IF tt-estoque.estoqueproduto-quantidade = tt-estoque.estoqueMin THEN     
                    ASSIGN tt-estoque.corLinha = 14.                                     
                ELSE IF tt-estoque.estoqueproduto-quantidade < tt-estoque.estoqueMin THEN
                    ASSIGN tt-estoque.corLinha = 12.                                     
            END.                                                                         
        END.

        {&OPEN-QUERY-br-estoque}
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-limpaFiltro wWin 
PROCEDURE p-limpaFiltro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    ASSIGN fil-filtroIdProduto:SCREEN-VALUE   = ""
           fil-filtroDescProduto:SCREEN-VALUE = ""
           cb-filtroCategoria:SCREEN-VALUE    = cb-filtroCategoria:ENTRY(1).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

