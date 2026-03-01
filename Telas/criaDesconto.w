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

DEF INPUT PARAM viOPC AS CHAR NO-UNDO.
DEF INPUT PARAM viID  AS INT  NO-UNDO.

DEF SHARED VAR vsi-usr-id AS INT NO-UNDO.

DEF TEMP-TABLE tt-produtosDisp
    FIELD id   AS INT
    FIELD nome AS CHAR.

DEF TEMP-TABLE tt-produtosSelec
    FIELD id         AS INT
    FIELD nome       AS CHAR
    FIELD vlrporcent AS INT.

DEF BUFFER bf-desconto FOR desconto.

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
&Scoped-define FIELDS-IN-QUERY-br-produtoDisp tt-produtosDisp.id tt-produtosDisp.nome   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-produtoDisp   
&Scoped-define SELF-NAME br-produtoDisp
&Scoped-define QUERY-STRING-br-produtoDisp FOR EACH tt-produtosDisp
&Scoped-define OPEN-QUERY-br-produtoDisp OPEN QUERY {&SELF-NAME} FOR EACH tt-produtosDisp.
&Scoped-define TABLES-IN-QUERY-br-produtoDisp tt-produtosDisp
&Scoped-define FIRST-TABLE-IN-QUERY-br-produtoDisp tt-produtosDisp


/* Definitions for BROWSE br-produtoSelec                               */
&Scoped-define FIELDS-IN-QUERY-br-produtoSelec tt-produtosSelec.id tt-produtosSelec.nome tt-produtosSelec.vlrporcent   
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
&Scoped-Define ENABLED-OBJECTS RECT-3 RECT-4 fil-filtroIdProduto ~
cb-filtroCategoria fil-filtroDescProduto bt-filtroProduto br-produtoDisp ~
bt-retiraTodos bt-retira bt-seleciona bt-selecionaTodos br-produtoSelec ~
Btn_OK Btn_Cancel fil-FimDesconto 
&Scoped-Define DISPLAYED-OBJECTS fil-filtroIdProduto cb-filtroCategoria ~
fil-filtroDescProduto fil-iniDesconto fil-FimDesconto 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-filtroProduto 
     LABEL "Filtrar" 
     SIZE 11 BY 1.

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

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 10 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 10 BY 1.14.

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

DEFINE VARIABLE fil-FimDesconto AS DATE FORMAT "99/99/9999":U 
     LABEL "até" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE fil-iniDesconto AS DATE FORMAT "99/99/9999":U 
     LABEL "Período" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 73 BY 3.1.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 49 BY 1.67.

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
      tt-produtosDisp.id           COLUMN-LABEL "ID"   FORMAT ">>>>>>"   
tt-produtosDisp.nome         COLUMN-LABEL "Nome" FORMAT "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 73 BY 6.19
         TITLE "Produtos Disponíveis" FIT-LAST-COLUMN.

DEFINE BROWSE br-produtoSelec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-produtoSelec gDialog _FREEFORM
  QUERY br-produtoSelec DISPLAY
      tt-produtosSelec.id           COLUMN-LABEL "ID"         FORMAT ">>>>>>"   
      tt-produtosSelec.nome         COLUMN-LABEL "Nome"       FORMAT "x(48)"
      tt-produtosSelec.vlrporcent   COLUMN-LABEL "% Desconto" FORMAT ">>>"
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
     Btn_OK AT ROW 19.86 COL 54
     Btn_Cancel AT ROW 19.86 COL 64
     fil-iniDesconto AT ROW 19.95 COL 11 COLON-ALIGNED WIDGET-ID 56
     fil-FimDesconto AT ROW 19.95 COL 32 COLON-ALIGNED WIDGET-ID 62
     "Desconto:" VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 19.33 COL 4.6 WIDGET-ID 68
     "Busca Produtos Disponíveis:" VIEW-AS TEXT
          SIZE 29 BY .62 AT ROW 1.48 COL 4.6 WIDGET-ID 60
     RECT-3 AT ROW 1.71 COL 3 WIDGET-ID 58
     RECT-4 AT ROW 19.57 COL 3 WIDGET-ID 64
     SPACE(25.99) SKIP(0.23)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Manutenção de Descontos"
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

/* SETTINGS FOR FILL-IN fil-iniDesconto IN FRAME gDialog
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
ON WINDOW-CLOSE OF FRAME gDialog /* Manutenção de Descontos */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-produtoSelec
&Scoped-define SELF-NAME br-produtoSelec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-produtoSelec gDialog
ON MOUSE-SELECT-DBLCLICK OF br-produtoSelec IN FRAME gDialog /* Produtos Selecionados */
DO:
    DO WITH FRAME {&FRAME-NAME}:
        DEF VAR iAux AS INT NO-UNDO.
                                    
        ASSIGN iAux = ?.            

        FIND CURRENT tt-produtosSelec EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL tt-produtosSelec THEN DO: 

            RUN desconto.w (INPUT "A",   
                            INPUT tt-produtosSelec.vlrporcent,     
                            OUTPUT iAux).
                                         
            IF iAux <> ? THEN DO:  

                ASSIGN tt-produtosSelec.vlrporcent = iAux.

                {&OPEN-QUERY-br-produtoSelec}
            END.
        END.
    END.
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


&Scoped-define SELF-NAME bt-retira
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-retira gDialog
ON CHOOSE OF bt-retira IN FRAME gDialog
DO:
    DO WITH FRAME {&FRAME-NAME}:

        FIND CURRENT tt-produtosSelec EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL tt-produtosSelec THEN DO:
            
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
        DEF VAR iAux AS INT NO-UNDO.

        ASSIGN iAux = ?.

        FIND CURRENT tt-produtosDisp EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL tt-produtosDisp THEN DO:

            RUN desconto.w (INPUT "I",
                            INPUT ?,
                            OUTPUT iAux).

            IF iAux <> ? THEN DO:

                FIND FIRST tt-produtosSelec WHERE
                           tt-produtosSelec.id = tt-produtosDisp.id NO-LOCK NO-ERROR.
                IF NOT AVAIL tt-produtosSelec THEN DO:

                    CREATE tt-produtosSelec.
                    ASSIGN tt-produtosSelec.id         = tt-produtosDisp.id
                           tt-produtosSelec.nome       = tt-produtosDisp.nome
                           tt-produtosSelec.vlrporcent = iAux.
                END.

                DELETE tt-produtosDisp.

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
        DEF VAR iAux AS INT NO-UNDO.

        ASSIGN iAux = ?.

        RUN desconto.w (INPUT "I",   
                        INPUT ?,     
                        OUTPUT iAux).

        IF iAux <> ? THEN DO:

           FOR EACH tt-produtosDisp EXCLUSIVE-LOCK.
                   
               FIND FIRST tt-produtosSelec WHERE
                          tt-produtosSelec.id = tt-produtosDisp.id NO-LOCK NO-ERROR.
               IF NOT AVAIL tt-produtosSelec THEN DO:
               
                   CREATE tt-produtosSelec.
                   ASSIGN tt-produtosSelec.id         = tt-produtosDisp.id
                          tt-produtosSelec.nome       = tt-produtosDisp.nome
                          tt-produtosSelec.vlrporcent = iAux.
               END.
               
               DELETE tt-produtosDisp.   
           END.

           {&OPEN-QUERY-br-produtoDisp} 
           {&OPEN-QUERY-br-produtoSelec}

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
        DEF VAR cAUXmsg AS CHAR NO-UNDO.

        IF INPUT fil-iniDesconto = ? OR INPUT fil-FimDesconto = ? THEN DO:
            MESSAGE "Favor informar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        IF INPUT fil-iniDesconto > INPUT fil-FimDesconto THEN DO:
            MESSAGE "Favor informar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.     
            RETURN NO-APPLY.                           
        END.

        IF INPUT fil-iniDesconto < DATE(MONTH(TODAY),1,YEAR(TODAY)) OR
           INPUT fil-FimDesconto < DATE(MONTH(TODAY),1,YEAR(TODAY)) THEN DO:
            MESSAGE "O período não pode ser menor que o mês corrente."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        IF MONTH(INPUT fil-iniDesconto) <> MONTH(INPUT fil-FimDesconto) THEN DO:
            MESSAGE "O período do desconto não pode estar em mêses diferentes."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        FIND FIRST tt-produtosSelec NO-LOCK NO-ERROR.
        IF NOT AVAIL tt-produtosSelec THEN DO:
            MESSAGE "Selecione pelo menos um produto para o desconto."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        ASSIGN cAUXmsg = "".                                                                                                              
                                                                                                                                          
        FOR EACH tt-produtosSelec NO-LOCK.   

            IF viOPC = "I" THEN DO:
                                                                                                                                          
                FOR EACH desconto WHERE                                                                                                       
                         desconto.usuario-id = vsi-usr-id NO-LOCK.                                                                            
                                                                                                                                                                                                                                                                                            
                    /*IF (INPUT fil-iniDesconto <= desconto.desconto-dataIni AND                                                                
                        desconto.desconto-dataIni     >= INPUT fil-FimDesconto) OR                                                            
                       (INPUT fil-iniDesconto <= desconto.desconto-dataFim AND                                                                
                        desconto.desconto-dataFim     >= INPUT fil-FimDesconto) THEN.                                                         
                    ELSE                                                                                                                      
                        NEXT.*/    

                    IF desconto.desconto-dataIni <= INPUT fil-FimDesconto AND  
                       desconto.desconto-dataFim >= INPUT fil-iniDesconto THEN.
                    ELSE                                                               
                        NEXT.                                                          
                                                                                                                                              
                    FIND FIRST descontoProduto WHERE                                                                                          
                               descontoProduto.usuario-id = vsi-usr-id AND
                               descontoProduto.desconto-id = desconto.desconto-id AND
                               descontoProduto.produto-id = tt-produtosSelec.id NO-LOCK NO-ERROR.                                             
                    IF AVAIL descontoProduto THEN                                                                                             
                        ASSIGN cAUXmsg = IF cAUXmsg = "" THEN string(tt-produtosSelec.id) + " - " + tt-produtosSelec.nome                     
                                                         ELSE cAUXmsg + CHR(10) + string(tt-produtosSelec.id) + " - " + tt-produtosSelec.nome.
                END.   
            END.
            ELSE DO:

                FOR EACH desconto WHERE                                                                                                       
                         desconto.usuario-id = vsi-usr-id AND
                         desconto.desconto-id <> viID NO-LOCK.                                                                            
                                                                                                                                              
                    /*IF (INPUT fil-iniDesconto <= desconto.desconto-dataIni AND                                                                
                        desconto.desconto-dataIni     >= INPUT fil-FimDesconto) OR                                                            
                       (INPUT fil-iniDesconto <= desconto.desconto-dataFim AND                                                                
                        desconto.desconto-dataFim     >= INPUT fil-FimDesconto) THEN.                                                         
                    ELSE                                                                                                                      
                        NEXT.*/      

                    IF desconto.desconto-dataIni <= INPUT fil-FimDesconto AND  
                       desconto.desconto-dataFim >= INPUT fil-iniDesconto THEN.
                    ELSE                                                       
                        NEXT.                                                 
                                                                                                                                              
                    FIND FIRST descontoProduto WHERE                                                                                          
                               descontoProduto.usuario-id = vsi-usr-id AND   
                               descontoProduto.desconto-id = desconto.desconto-id AND
                               descontoProduto.produto-id = tt-produtosSelec.id NO-LOCK NO-ERROR.                                             
                    IF AVAIL descontoProduto THEN                                                                                             
                        ASSIGN cAUXmsg = IF cAUXmsg = "" THEN string(tt-produtosSelec.id) + " - " + tt-produtosSelec.nome                     
                                                         ELSE cAUXmsg + CHR(10) + string(tt-produtosSelec.id) + " - " + tt-produtosSelec.nome.
                END.                                                                                                                          
            END.
        END.    

        IF cAUXmsg <> "" THEN DO:

            MESSAGE "Os seguintes produtos já estão em outro desconto dentro do período selecionado e por isso não podem ser escolhidos." SKIP
                    cAUXmsg
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
  DISPLAY fil-filtroIdProduto cb-filtroCategoria fil-filtroDescProduto 
          fil-iniDesconto fil-FimDesconto 
      WITH FRAME gDialog.
  ENABLE RECT-3 RECT-4 fil-filtroIdProduto cb-filtroCategoria 
         fil-filtroDescProduto bt-filtroProduto br-produtoDisp bt-retiraTodos 
         bt-retira bt-seleciona bt-selecionaTodos br-produtoSelec Btn_OK 
         Btn_Cancel fil-FimDesconto 
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
                   tt-produtosSelec.id = produto.produto-id NO-LOCK NO-ERROR. 
        IF AVAIL tt-produtosSelec THEN                                        
            NEXT.                                                                                                                                
                                                                                  
        CREATE tt-produtosDisp.                                                   
        ASSIGN tt-produtosDisp.id   = produto.produto-id                          
               tt-produtosDisp.nome = produto.produto-nome.                       
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

    IF viOPC = "A" THEN DO:

        FIND FIRST desconto WHERE
                   desconto.usuario-id  = vsi-usr-id AND
                   desconto.desconto-id = viID EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL desconto THEN DO:

            FOR EACH descontoProduto WHERE                             
                     descontoProduto.usuario-id  = vsi-usr-id AND      
                     descontoProduto.desconto-id = desconto.desconto-id EXCLUSIVE-LOCK.

                FIND FIRST tt-produtosSelec WHERE
                           tt-produtosSelec.id = descontoProduto.produto-id NO-LOCK NO-ERROR.
                IF NOT AVAIL tt-produtosSelec THEN DO:

                    DELETE descontoProduto.
                END.
            END.

            FOR EACH tt-produtosSelec NO-LOCK.

                FIND FIRST descontoProduto WHERE
                           descontoProduto.usuario-id  = vsi-usr-id AND
                           descontoProduto.desconto-id = desconto.desconto-id AND
                           descontoProduto.produto-id  = tt-produtosSelec.id EXCLUSIVE-LOCK NO-ERROR.
                IF NOT AVAIL descontoProduto THEN DO:

                    CREATE descontoProduto.
                    ASSIGN descontoProduto.usuario-id  = vsi-usr-id
                           descontoProduto.desconto-id = desconto.desconto-id
                           descontoProduto.produto-id  = tt-produtosSelec.id.
                END.

                ASSIGN descontoProduto.descontoproduto-valor   = tt-produtosSelec.vlrporcent
                       descontoProduto.descontoproduto-dataAlt = TODAY
                       descontoProduto.descontoproduto-horaAlt = TIME.
            END.

            ASSIGN desconto.desconto-dataIni = INPUT fil-iniDesconto
                   desconto.desconto-dataFim = INPUT fil-FimDesconto
                   desconto.desconto-dataAlt = TODAY
                   desconto.desconto-horaAlt = TIME.
        END.
    END.
    ELSE DO:

        FIND LAST bf-desconto WHERE
                  bf-desconto.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.

        CREATE desconto.
        ASSIGN desconto.usuario-id       = vsi-usr-id
               desconto.desconto-id      = IF AVAIL bf-desconto THEN bf-desconto.desconto-id + 1 ELSE 1
               desconto.desconto-dataIni = INPUT fil-iniDesconto
               desconto.desconto-dataFim = INPUT fil-FimDesconto
               desconto.desconto-dataAlt = TODAY                
               desconto.desconto-horaAlt = TIME.    

        FOR EACH tt-produtosSelec NO-LOCK.

            CREATE descontoProduto.                                   
            ASSIGN descontoProduto.usuario-id              = vsi-usr-id           
                   descontoProduto.desconto-id             = desconto.desconto-id 
                   descontoProduto.produto-id              = tt-produtosSelec.id
                   descontoProduto.descontoproduto-valor   = tt-produtosSelec.vlrporcent
                   descontoProduto.descontoproduto-dataAlt = TODAY                      
                   descontoProduto.descontoproduto-horaAlt = TIME.                      
        END.
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
    
    ASSIGN bt-retiraTodos:LABEL IN FRAME {&FRAME-NAME}    = ""
           bt-retira:LABEL IN FRAME {&FRAME-NAME}         = ""
           bt-selecionaTodos:LABEL IN FRAME {&FRAME-NAME} = ""
           bt-seleciona:LABEL IN FRAME {&FRAME-NAME}      = ""
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

    IF viOPC = "A" THEN DO:

        FIND FIRST desconto WHERE
                   desconto.usuario-id  = vsi-usr-id AND
                   desconto.desconto-id = viID NO-LOCK NO-ERROR.
        IF AVAIL desconto THEN DO:

            ASSIGN fil-iniDesconto:SCREEN-VALUE = string(desconto.desconto-dataIni)
                   fil-FimDesconto:SCREEN-VALUE = string(desconto.desconto-dataFim).

            FOR EACH descontoProduto WHERE 
                     descontoProduto.usuario-id  = vsi-usr-id AND
                     descontoProduto.desconto-id = desconto.desconto-id NO-LOCK.

                FIND FIRST produto WHERE
                           produto.usuario-id = vsi-usr-id AND
                           produto.produto-id = descontoProduto.produto-id NO-LOCK NO-ERROR.
                IF AVAIL produto THEN DO:

                    CREATE tt-produtosSelec.
                    ASSIGN tt-produtosSelec.id         = produto.produto-id
                           tt-produtosSelec.nome       = produto.produto-nome
                           tt-produtosSelec.vlrporcent = descontoProduto.descontoproduto-valor.
                END.
            END.

        END.
    END.
    ELSE DO:
        ASSIGN fil-iniDesconto:SCREEN-VALUE = string(TODAY).

        IF MONTH(TODAY) = 12 THEN
            ASSIGN fil-FimDesconto:SCREEN-VALUE = string((DATE(1,1,YEAR(TODAY) + 1) - 1)). 
        ELSE
            ASSIGN fil-FimDesconto:SCREEN-VALUE = STRING((DATE(MONTH(TODAY) + 1,1,YEAR(TODAY)) - 1)).
    END.

    FOR EACH produto WHERE
             produto.usuario-id = vsi-usr-id NO-LOCK.

        IF viOPC = "A" THEN DO:

            FIND FIRST tt-produtosSelec WHERE
                       tt-produtosSelec.id = produto.produto-id NO-LOCK NO-ERROR.
            IF AVAIL tt-produtosSelec THEN
                NEXT.
        END.

        CREATE tt-produtosDisp.                                 
        ASSIGN tt-produtosDisp.id   = produto.produto-id  
               tt-produtosDisp.nome = produto.produto-nome.
    END.

    {&OPEN-QUERY-br-produtoDisp}
    {&OPEN-QUERY-br-produtoSelec}

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

