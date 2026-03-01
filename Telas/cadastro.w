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

DEF VAR vc-frame   AS CHAR NO-UNDO.
DEF VAR cImgPadrao AS CHAR NO-UNDO INIT "C:\Users\Totvs\Documents\Imagens\imgpadrao.png".

DEF VAR iIDdesconto AS INT NO-UNDO.

DEF VAR lVisualizaSenha AS LOG NO-UNDO.

DEF TEMP-TABLE tt-produtos LIKE produto
    FIELD categoriaDesc AS CHAR.

DEF TEMP-TABLE tt-categorias LIKE categoria.

DEF TEMP-TABLE tt-descontos LIKE desconto.

DEF TEMP-TABLE tt-descontoprodutos LIKE descontoproduto
    FIELD produtoNome AS CHAR.

DEF BUFFER bf-histCategoria FOR histCategoria.
DEF BUFFER bf-histProduto FOR histProduto.

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
&Scoped-define BROWSE-NAME br-categoria

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-categorias tt-descontos ~
tt-descontoprodutos tt-produtos

/* Definitions for BROWSE br-categoria                                  */
&Scoped-define FIELDS-IN-QUERY-br-categoria tt-categorias.categoria-id tt-categorias.categoria-descricao   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-categoria   
&Scoped-define SELF-NAME br-categoria
&Scoped-define QUERY-STRING-br-categoria FOR EACH tt-categorias
&Scoped-define OPEN-QUERY-br-categoria OPEN QUERY {&SELF-NAME} FOR EACH tt-categorias.
&Scoped-define TABLES-IN-QUERY-br-categoria tt-categorias
&Scoped-define FIRST-TABLE-IN-QUERY-br-categoria tt-categorias


/* Definitions for BROWSE br-desconto                                   */
&Scoped-define FIELDS-IN-QUERY-br-desconto tt-descontos.desconto-dataIni tt-descontos.desconto-dataFim   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-desconto   
&Scoped-define SELF-NAME br-desconto
&Scoped-define QUERY-STRING-br-desconto FOR EACH tt-descontos
&Scoped-define OPEN-QUERY-br-desconto OPEN QUERY {&SELF-NAME} FOR EACH tt-descontos.
&Scoped-define TABLES-IN-QUERY-br-desconto tt-descontos
&Scoped-define FIRST-TABLE-IN-QUERY-br-desconto tt-descontos


/* Definitions for BROWSE br-descontoproduto                            */
&Scoped-define FIELDS-IN-QUERY-br-descontoproduto tt-descontoprodutos.descontoproduto-valor tt-descontoprodutos.produtoNome   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-descontoproduto   
&Scoped-define SELF-NAME br-descontoproduto
&Scoped-define QUERY-STRING-br-descontoproduto FOR EACH tt-descontoprodutos WHERE tt-descontoprodutos.desconto-id = iIDdesconto
&Scoped-define OPEN-QUERY-br-descontoproduto OPEN QUERY {&SELF-NAME} FOR EACH tt-descontoprodutos WHERE tt-descontoprodutos.desconto-id = iIDdesconto.
&Scoped-define TABLES-IN-QUERY-br-descontoproduto tt-descontoprodutos
&Scoped-define FIRST-TABLE-IN-QUERY-br-descontoproduto tt-descontoprodutos


/* Definitions for BROWSE br-produto                                    */
&Scoped-define FIELDS-IN-QUERY-br-produto tt-produtos.produto-id tt-produtos.produto-nome tt-produtos.categoriaDesc tt-produtos.produto-valor tt-produtos.produto-valorVarejo tt-produtos.produto-estoqueCritico   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-produto   
&Scoped-define SELF-NAME br-produto
&Scoped-define QUERY-STRING-br-produto FOR EACH tt-produtos
&Scoped-define OPEN-QUERY-br-produto OPEN QUERY {&SELF-NAME} FOR EACH tt-produtos.
&Scoped-define TABLES-IN-QUERY-br-produto tt-produtos
&Scoped-define FIRST-TABLE-IN-QUERY-br-produto tt-produtos


/* Definitions for FRAME FRAME-B                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-B ~
    ~{&OPEN-QUERY-br-categoria}

/* Definitions for FRAME FRAME-C                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-C ~
    ~{&OPEN-QUERY-br-produto}

/* Definitions for FRAME FRAME-D                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-D ~
    ~{&OPEN-QUERY-br-desconto}~
    ~{&OPEN-QUERY-br-descontoproduto}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bt-conta bt-categoria bt-produto bt-desconto ~
Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS FILL-IN-3 FILL-IN-4 FILL-IN-5 FILL-IN-6 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-categoria 
     LABEL "Categorias" 
     SIZE 15 BY 1.1.

DEFINE BUTTON bt-conta 
     LABEL "Conta" 
     SIZE 15 BY 1.1.

DEFINE BUTTON bt-desconto 
     LABEL "Descontos" 
     SIZE 15 BY 1.1.

DEFINE BUTTON bt-produto 
     LABEL "Produtos" 
     SIZE 15 BY 1.1.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Sair" 
     SIZE 17.4 BY 1.1.

DEFINE VARIABLE FILL-IN-3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1.67 NO-UNDO.

DEFINE VARIABLE FILL-IN-4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1.67 NO-UNDO.

DEFINE VARIABLE FILL-IN-5 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1.67 NO-UNDO.

DEFINE VARIABLE FILL-IN-6 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1.67 NO-UNDO.

DEFINE BUTTON bt-alteraConta 
     LABEL "Alterar" 
     SIZE 15 BY 1.1.

DEFINE BUTTON bt-senha 
     LABEL "" 
     SIZE 6 BY 1.38.

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
     SIZE 19.8 BY .91 NO-UNDO.

DEFINE BUTTON bt-alteraCategoria 
     LABEL "Alterar" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-excluiCategoria 
     LABEL "Excluir" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-filtroCategoria 
     LABEL "Filtrar" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-incluiCategoria 
     LABEL "Incluir" 
     SIZE 11 BY 1.

DEFINE VARIABLE fil-filtroDescCategoria AS CHARACTER FORMAT "X(256)":U 
     LABEL "Descrição" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 65 BY 1 NO-UNDO.

DEFINE VARIABLE fil-filtroIdCategoria AS INTEGER FORMAT ">>>>>":U INITIAL 0 
     LABEL "ID" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1 NO-UNDO.

DEFINE BUTTON bt-alteraProduto 
     LABEL "Alterar" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-excluiProduto 
     LABEL "Excluir" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-filtroProduto 
     LABEL "Filtrar" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-incluiProduto 
     LABEL "Incluir" 
     SIZE 11 BY 1.

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

DEFINE IMAGE imgFoto
     FILENAME "adeicon/blank":U
     SIZE 30.4 BY 6.76.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 32.4 BY 7.14.

DEFINE BUTTON bt-alteraDesconto 
     LABEL "Alterar" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-excluiDesconto 
     LABEL "Excluir" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-filtroDesconto 
     LABEL "Filtrar" 
     SIZE 11 BY 1.

DEFINE BUTTON bt-incluiDesconto 
     LABEL "Incluir" 
     SIZE 11 BY 1.

DEFINE VARIABLE fil-filtroDtFimDesconto AS DATE FORMAT "99/99/9999":U 
     LABEL "até" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE fil-filtroDtIniDesconto AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-categoria FOR 
      tt-categorias SCROLLING.

DEFINE QUERY br-desconto FOR 
      tt-descontos SCROLLING.

DEFINE QUERY br-descontoproduto FOR 
      tt-descontoprodutos SCROLLING.

DEFINE QUERY br-produto FOR 
      tt-produtos SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-categoria wWin _FREEFORM
  QUERY br-categoria DISPLAY
      tt-categorias.categoria-id        COLUMN-LABEL "ID"        FORMAT ">>>>>>"      
tt-categorias.categoria-descricao COLUMN-LABEL "Descrição" FORMAT "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 105.8 BY 5.81
         TITLE "Categorias" FIT-LAST-COLUMN.

DEFINE BROWSE br-desconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-desconto wWin _FREEFORM
  QUERY br-desconto DISPLAY
      tt-descontos.desconto-dataIni COLUMN-LABEL "Inicio" FORMAT "99/99/9999"      
tt-descontos.desconto-dataFim COLUMN-LABEL "Fim"    FORMAT "99/99/9999"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 28.8 BY 7.67
         TITLE "Descontos" FIT-LAST-COLUMN.

DEFINE BROWSE br-descontoproduto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-descontoproduto wWin _FREEFORM
  QUERY br-descontoproduto DISPLAY
      tt-descontoprodutos.descontoproduto-valor COLUMN-LABEL "% Desconto"   FORMAT ">>>"      
      tt-descontoprodutos.produtoNome           COLUMN-LABEL "Nome Produto" FORMAT "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 76 BY 7.76
         TITLE "Produtos do Desconto" FIT-LAST-COLUMN.

DEFINE BROWSE br-produto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-produto wWin _FREEFORM
  QUERY br-produto DISPLAY
      tt-produtos.produto-id             column-label "ID"           format ">>>>>>"
      tt-produtos.produto-nome           column-label "Nome"         format "x(50)"
      tt-produtos.categoriaDesc          column-label "Categoria"    format "x(50)"
      tt-produtos.produto-valor          column-label "Valor"        
      tt-produtos.produto-valorVarejo    column-label "Valor Varejo" 
      tt-produtos.produto-estoqueCritico column-label "Estoque Min." format ">>>>>>"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 70 BY 6.19
         TITLE "Produtos" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     FILL-IN-3 AT ROW 1.57 COL 1 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     FILL-IN-4 AT ROW 1.57 COL 20.2 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     FILL-IN-5 AT ROW 1.57 COL 39.4 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     FILL-IN-6 AT ROW 1.57 COL 58.4 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     bt-conta AT ROW 1.86 COL 4 WIDGET-ID 4
     bt-categoria AT ROW 1.86 COL 23.2 WIDGET-ID 8
     bt-produto AT ROW 1.86 COL 42.4 WIDGET-ID 12
     bt-desconto AT ROW 1.86 COL 61.4 WIDGET-ID 16
     Btn_Cancel AT ROW 1.86 COL 92 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 109.8 BY 12.24 WIDGET-ID 100.

DEFINE FRAME FRAME-D
     fil-filtroDtIniDesconto AT ROW 1.48 COL 6.6 COLON-ALIGNED WIDGET-ID 2
     fil-filtroDtFimDesconto AT ROW 1.48 COL 27 COLON-ALIGNED WIDGET-ID 4
     bt-filtroDesconto AT ROW 1.48 COL 46.2 WIDGET-ID 44
     bt-incluiDesconto AT ROW 1.48 COL 74 WIDGET-ID 34
     bt-alteraDesconto AT ROW 1.48 COL 85.2 WIDGET-ID 36
     bt-excluiDesconto AT ROW 1.48 COL 96.4 WIDGET-ID 38
     br-desconto AT ROW 2.76 COL 2.2 WIDGET-ID 800
     br-descontoproduto AT ROW 2.76 COL 31.6 WIDGET-ID 900
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.43
         SIZE 108 BY 9.71 WIDGET-ID 600.

DEFINE FRAME FRAME-A
     fil-nome AT ROW 1.95 COL 11 COLON-ALIGNED WIDGET-ID 6
     fil-email AT ROW 3.19 COL 11 COLON-ALIGNED WIDGET-ID 8
     fil-identificacao AT ROW 4.52 COL 31.8 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     rd-tipo AT ROW 4.57 COL 13.2 NO-LABEL WIDGET-ID 10
     fil-telefone AT ROW 6 COL 13.2 COLON-ALIGNED WIDGET-ID 16
     bt-alteraConta AT ROW 6.24 COL 44 WIDGET-ID 18
     fil-usuario AT ROW 7.29 COL 13.2 COLON-ALIGNED WIDGET-ID 2
     bt-senha AT ROW 8.33 COL 40 WIDGET-ID 20
     fil-senha AT ROW 8.52 COL 13.2 COLON-ALIGNED WIDGET-ID 4 BLANK 
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.43
         SIZE 108 BY 9.71 WIDGET-ID 400.

DEFINE FRAME FRAME-C
     fil-filtroIdProduto AT ROW 1.48 COL 3.8 COLON-ALIGNED WIDGET-ID 40
     cb-filtroCategoria AT ROW 1.48 COL 24 COLON-ALIGNED WIDGET-ID 46
     fil-filtroDescProduto AT ROW 2.67 COL 10.8 COLON-ALIGNED WIDGET-ID 42
     bt-filtroProduto AT ROW 2.67 COL 62 WIDGET-ID 44
     br-produto AT ROW 4.1 COL 2.8 WIDGET-ID 300
     bt-incluiProduto AT ROW 9 COL 74 WIDGET-ID 34
     bt-alteraProduto AT ROW 9 COL 85.2 WIDGET-ID 36
     bt-excluiProduto AT ROW 9 COL 96.4 WIDGET-ID 38
     RECT-1 AT ROW 1.48 COL 75 WIDGET-ID 18
     imgFoto AT ROW 1.67 COL 75.8 WIDGET-ID 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.43
         SIZE 108 BY 9.71 WIDGET-ID 200.

DEFINE FRAME FRAME-B
     fil-filtroIdCategoria AT ROW 1.48 COL 3.6 COLON-ALIGNED WIDGET-ID 2
     fil-filtroDescCategoria AT ROW 1.48 COL 25 COLON-ALIGNED WIDGET-ID 4
     bt-filtroCategoria AT ROW 1.48 COL 95 WIDGET-ID 44
     br-categoria AT ROW 2.81 COL 2.2 WIDGET-ID 700
     bt-incluiCategoria AT ROW 9.14 COL 38.2 WIDGET-ID 34
     bt-alteraCategoria AT ROW 9.14 COL 49.4 WIDGET-ID 36
     bt-excluiCategoria AT ROW 9.14 COL 60.6 WIDGET-ID 38
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.43
         SIZE 108 BY 9.71 WIDGET-ID 500.


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
         TITLE              = "Consulta de Cadastros"
         HEIGHT             = 12.24
         WIDTH              = 109.8
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
/* REPARENT FRAME */
ASSIGN FRAME FRAME-A:FRAME = FRAME fMain:HANDLE
       FRAME FRAME-B:FRAME = FRAME fMain:HANDLE
       FRAME FRAME-C:FRAME = FRAME fMain:HANDLE
       FRAME FRAME-D:FRAME = FRAME fMain:HANDLE.

/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME FRAME-B:MOVE-AFTER-TAB-ITEM (Btn_Cancel:HANDLE IN FRAME fMain)
       XXTABVALXX = FRAME FRAME-C:MOVE-BEFORE-TAB-ITEM (FRAME FRAME-D:HANDLE)
       XXTABVALXX = FRAME FRAME-A:MOVE-BEFORE-TAB-ITEM (FRAME FRAME-C:HANDLE)
       XXTABVALXX = FRAME FRAME-B:MOVE-BEFORE-TAB-ITEM (FRAME FRAME-A:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FILL-IN FILL-IN-3 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN FILL-IN-4 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN FILL-IN-5 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN FILL-IN-6 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-A
   NOT-VISIBLE                                                          */
ASSIGN 
       FRAME FRAME-A:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN fil-email IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-identificacao IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-nome IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-senha IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-telefone IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fil-usuario IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET rd-tipo IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-B
   NOT-VISIBLE                                                          */
/* BROWSE-TAB br-categoria bt-filtroCategoria FRAME-B */
ASSIGN 
       FRAME FRAME-B:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-alteraCategoria IN FRAME FRAME-B
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bt-excluiCategoria IN FRAME FRAME-B
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-C
   NOT-VISIBLE                                                          */
/* BROWSE-TAB br-produto bt-filtroProduto FRAME-C */
ASSIGN 
       FRAME FRAME-C:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-alteraProduto IN FRAME FRAME-C
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bt-excluiProduto IN FRAME FRAME-C
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-D
   NOT-VISIBLE                                                          */
/* BROWSE-TAB br-desconto bt-excluiDesconto FRAME-D */
/* BROWSE-TAB br-descontoproduto br-desconto FRAME-D */
ASSIGN 
       FRAME FRAME-D:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-alteraDesconto IN FRAME FRAME-D
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bt-excluiDesconto IN FRAME FRAME-D
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-categoria
/* Query rebuild information for BROWSE br-categoria
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-categorias.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-categoria */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-desconto
/* Query rebuild information for BROWSE br-desconto
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-descontos.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-desconto */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-descontoproduto
/* Query rebuild information for BROWSE br-descontoproduto
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-descontoprodutos WHERE tt-descontoprodutos.desconto-id = iIDdesconto.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-descontoproduto */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-produto
/* Query rebuild information for BROWSE br-produto
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-produtos.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-produto */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Consulta de Cadastros */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Consulta de Cadastros */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-categoria
&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME br-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-categoria wWin
ON VALUE-CHANGED OF br-categoria IN FRAME FRAME-B /* Categorias */
DO:
    DO WITH FRAME FRAME-B:

        FIND CURRENT tt-categorias NO-LOCK NO-ERROR.
        IF AVAIL tt-categorias THEN DO:

            ENABLE bt-alteraCategoria
                   bt-excluiCategoria.
        END.
        ELSE DO:

            DISABLE bt-alteraCategoria 
                    bt-excluiCategoria.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-desconto
&Scoped-define FRAME-NAME FRAME-D
&Scoped-define SELF-NAME br-desconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-desconto wWin
ON VALUE-CHANGED OF br-desconto IN FRAME FRAME-D /* Descontos */
DO:
    DO WITH FRAME FRAME-D:

        FIND CURRENT tt-descontos NO-LOCK NO-ERROR.
        IF AVAIL tt-descontos THEN DO:

            ASSIGN iIDdesconto = tt-descontos.desconto-id.

            ENABLE bt-alteraDesconto
                   bt-excluiDesconto.
        END.
        ELSE DO:

            ASSIGN iIDdesconto = ?.
                                                          
            DISABLE bt-alteraDesconto                      
                    bt-excluiDesconto.                     
        END.

        {&OPEN-QUERY-br-descontoproduto}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-produto
&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME br-produto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-produto wWin
ON VALUE-CHANGED OF br-produto IN FRAME FRAME-C /* Produtos */
DO:
    DO WITH FRAME FRAME-C:

        FIND CURRENT tt-produtos NO-LOCK NO-ERROR.
        IF AVAIL tt-produtos THEN DO:

            IF tt-produtos.produto-imagem <> ? AND 
               tt-produtos.produto-imagem <> "" THEN
                imgFoto:LOAD-IMAGE(tt-produtos.produto-imagem) NO-ERROR.
            ELSE
                imgFoto:LOAD-IMAGE(cImgPadrao) NO-ERROR.

            ENABLE bt-alteraProduto
                   bt-excluiProduto.
        END.
        ELSE DO:

            DISABLE bt-alteraProduto 
                    bt-excluiProduto.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME bt-alteraCategoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-alteraCategoria wWin
ON CHOOSE OF bt-alteraCategoria IN FRAME FRAME-B /* Alterar */
DO:
    DO WITH FRAME FRAME-B:

        FIND CURRENT tt-categorias NO-LOCK NO-ERROR.
        IF AVAIL tt-categorias THEN DO:

            RUN criaCategoria.w(INPUT "A",
                                INPUT tt-categorias.categoria-id).

            APPLY "CHOOSE" TO bt-filtroCategoria.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-A
&Scoped-define SELF-NAME bt-alteraConta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-alteraConta wWin
ON CHOOSE OF bt-alteraConta IN FRAME FRAME-A /* Alterar */
DO:
    RUN criaConta.w(INPUT "A").

    RUN p-leituraConta.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-D
&Scoped-define SELF-NAME bt-alteraDesconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-alteraDesconto wWin
ON CHOOSE OF bt-alteraDesconto IN FRAME FRAME-D /* Alterar */
DO:
    DO WITH FRAME FRAME-D:

        FIND CURRENT tt-descontos NO-LOCK NO-ERROR.
        IF AVAIL tt-descontos THEN DO:

            IF tt-descontos.desconto-dataIni < DATE(MONTH(TODAY),1,YEAR(TODAY)) OR                        
               tt-descontos.desconto-dataFim < DATE(MONTH(TODAY),1,YEAR(TODAY)) THEN DO:                   
                                                                                                          
                MESSAGE "Descontos com informações de mêses anteriores não podem ser alterados/excluidos."
                    VIEW-AS ALERT-BOX INFO BUTTONS OK.                                                    
                RETURN NO-APPLY.                                                                          
            END.                                                                                          

            RUN criaDesconto.w(INPUT "A",
                               INPUT tt-descontos.desconto-id).

            APPLY "CHOOSE" TO bt-filtroDesconto.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME bt-alteraProduto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-alteraProduto wWin
ON CHOOSE OF bt-alteraProduto IN FRAME FRAME-C /* Alterar */
DO:
    DO WITH FRAME FRAME-C:

        FIND CURRENT tt-produtos NO-LOCK NO-ERROR.
        IF AVAIL tt-produtos THEN DO:

            RUN criaProduto.w(INPUT "A",
                              INPUT tt-produtos.produto-id).

            APPLY "CHOOSE" TO bt-filtroProduto.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&Scoped-define SELF-NAME bt-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-categoria wWin
ON CHOOSE OF bt-categoria IN FRAME fMain /* Categorias */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN vc-frame = "CATEGORIA".

        RUN pFrames.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-conta wWin
ON CHOOSE OF bt-conta IN FRAME fMain /* Conta */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN vc-frame = "CONTA".

        RUN pFrames.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-desconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-desconto wWin
ON CHOOSE OF bt-desconto IN FRAME fMain /* Descontos */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN vc-frame = "DESCONTO".

        RUN pFrames.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME bt-excluiCategoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-excluiCategoria wWin
ON CHOOSE OF bt-excluiCategoria IN FRAME FRAME-B /* Excluir */
DO:
    DO WITH FRAME FRAME-B:
        DEFINE VARIABLE vResp AS LOGICAL NO-UNDO.

        FIND CURRENT tt-categorias NO-LOCK NO-ERROR.  
        IF AVAIL tt-categorias THEN DO:               

            MESSAGE "Deseja escluir a categoria?"       
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            UPDATE vResp.                            
                                                     
            IF NOT vResp THEN                        
                RETURN NO-APPLY.

            RUN p-excluiCategoria.
           
            APPLY "CHOOSE" TO bt-filtroCategoria.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-D
&Scoped-define SELF-NAME bt-excluiDesconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-excluiDesconto wWin
ON CHOOSE OF bt-excluiDesconto IN FRAME FRAME-D /* Excluir */
DO:
    DO WITH FRAME FRAME-D:
        DEFINE VARIABLE vResp AS LOGICAL NO-UNDO.

        FIND CURRENT tt-descontos NO-LOCK NO-ERROR.  
        IF AVAIL tt-descontos THEN DO:    

            IF tt-descontos.desconto-dataIni < DATE(MONTH(TODAY),1,YEAR(TODAY)) OR
               tt-descontos.desconto-dataFim < DATE(MONTH(TODAY),1,YEAR(TODAY)) THEN DO:

                MESSAGE "Descontos com informações de mêses anteriores não podem ser alterados/excluidos."
                    VIEW-AS ALERT-BOX INFO BUTTONS OK.
                RETURN NO-APPLY.
            END.

            MESSAGE "Deseja escluir o desconto?"       
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            UPDATE vResp.                            
                                                     
            IF NOT vResp THEN                        
                RETURN NO-APPLY.

            RUN p-excluiDesconto.
           
            APPLY "CHOOSE" TO bt-filtroDesconto.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME bt-excluiProduto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-excluiProduto wWin
ON CHOOSE OF bt-excluiProduto IN FRAME FRAME-C /* Excluir */
DO:
    DO WITH FRAME FRAME-C:
        DEFINE VARIABLE vResp AS LOGICAL NO-UNDO.

        FIND CURRENT tt-produtos NO-LOCK NO-ERROR.  
        IF AVAIL tt-produtos THEN DO: 

            FIND LAST estoque WHERE
                      estoque.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.
            IF AVAIL estoque THEN DO:
                
                FIND FIRST estoqueProduto WHERE
                           estoqueProduto.usuario-id = vsi-usr-id AND
                           estoqueProduto.estoque-id = estoque.estoque-id AND
                           estoqueProduto.produto-id = tt-produtos.produto-id NO-LOCK NO-ERROR.
                IF AVAIL estoqueProduto AND 
                   estoqueProduto.estoqueproduto-quantidade > 0 THEN DO:
                
                    MESSAGE "Não é possível excluir um produto que ainda possui estoque."
                        VIEW-AS ALERT-BOX INFO BUTTONS OK.
                    RETURN NO-APPLY.
                END.
            END.

            MESSAGE "Deseja escluir o produto?"       
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            UPDATE vResp.                            
                                                     
            IF NOT vResp THEN                        
                RETURN NO-APPLY.

            RUN p-excluiProduto.
           
            APPLY "CHOOSE" TO bt-filtroProduto.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME bt-filtroCategoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroCategoria wWin
ON CHOOSE OF bt-filtroCategoria IN FRAME FRAME-B /* Filtrar */
DO:
  RUN p-filtroCategoria.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-D
&Scoped-define SELF-NAME bt-filtroDesconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroDesconto wWin
ON CHOOSE OF bt-filtroDesconto IN FRAME FRAME-D /* Filtrar */
DO:
    DO WITH FRAME FRAME-D:

        IF (INPUT fil-filtroDtIniDesconto <> ? AND
            INPUT fil-filtroDtFimDesconto = ?     ) OR
           (INPUT fil-filtroDtFimDesconto <> ? AND   
            INPUT fil-filtroDtIniDesconto = ?     ) THEN DO:

            MESSAGE "Favor escolher um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        IF (INPUT fil-filtroDtIniDesconto <> ? AND 
            INPUT fil-filtroDtFimDesconto <> ?    ) AND
            INPUT fil-filtroDtIniDesconto > INPUT fil-filtroDtFimDesconto THEN DO:

            MESSAGE "Favor escolher um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.     
            RETURN NO-APPLY.                           
        END.

        RUN p-filtroDesconto.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME bt-filtroProduto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroProduto wWin
ON CHOOSE OF bt-filtroProduto IN FRAME FRAME-C /* Filtrar */
DO:
  RUN p-filtroProduto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME bt-incluiCategoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-incluiCategoria wWin
ON CHOOSE OF bt-incluiCategoria IN FRAME FRAME-B /* Incluir */
DO:
    DO WITH FRAME FRAME-B:

        RUN criaCategoria.w(INPUT "I",
                            INPUT ?).

        APPLY "CHOOSE" TO bt-filtroCategoria.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-D
&Scoped-define SELF-NAME bt-incluiDesconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-incluiDesconto wWin
ON CHOOSE OF bt-incluiDesconto IN FRAME FRAME-D /* Incluir */
DO:
    DO WITH FRAME FRAME-D:

        RUN criaDesconto.w(INPUT "I",
                           INPUT ?).

        APPLY "CHOOSE" TO bt-filtroDesconto.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME bt-incluiProduto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-incluiProduto wWin
ON CHOOSE OF bt-incluiProduto IN FRAME FRAME-C /* Incluir */
DO:
    DO WITH FRAME FRAME-C:

        RUN criaProduto.w(INPUT "I",
                          INPUT ?).

        APPLY "CHOOSE" TO bt-filtroProduto.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&Scoped-define SELF-NAME bt-produto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-produto wWin
ON CHOOSE OF bt-produto IN FRAME fMain /* Produtos */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN vc-frame = "PRODUTO".

        RUN pFrames.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-A
&Scoped-define SELF-NAME bt-senha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-senha wWin
ON CHOOSE OF bt-senha IN FRAME FRAME-A
DO:
    DO WITH FRAME FRAME-A:

        IF lVisualizaSenha THEN
            ASSIGN lVisualizaSenha = NO.
        ELSE
            ASSIGN lVisualizaSenha = YES.


        IF lVisualizaSenha THEN DO:
            bt-senha:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\visualizar.png") IN FRAME FRAME-A.

            fil-senha:BLANK = NO.
        END.
        ELSE DO:
            bt-senha:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\ocultar.png") IN FRAME FRAME-A.

            fil-senha:BLANK = YES.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&Scoped-define BROWSE-NAME br-categoria
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
  DISPLAY FILL-IN-3 FILL-IN-4 FILL-IN-5 FILL-IN-6 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE bt-conta bt-categoria bt-produto bt-desconto Btn_Cancel 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  DISPLAY fil-nome fil-email fil-identificacao rd-tipo fil-telefone fil-usuario 
          fil-senha 
      WITH FRAME FRAME-A IN WINDOW wWin.
  ENABLE bt-alteraConta bt-senha 
      WITH FRAME FRAME-A IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
  DISPLAY fil-filtroIdCategoria fil-filtroDescCategoria 
      WITH FRAME FRAME-B IN WINDOW wWin.
  ENABLE fil-filtroIdCategoria fil-filtroDescCategoria bt-filtroCategoria 
         br-categoria bt-incluiCategoria 
      WITH FRAME FRAME-B IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-B}
  DISPLAY fil-filtroIdProduto cb-filtroCategoria fil-filtroDescProduto 
      WITH FRAME FRAME-C IN WINDOW wWin.
  ENABLE RECT-1 imgFoto fil-filtroIdProduto cb-filtroCategoria 
         fil-filtroDescProduto bt-filtroProduto br-produto bt-incluiProduto 
      WITH FRAME FRAME-C IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-C}
  DISPLAY fil-filtroDtIniDesconto fil-filtroDtFimDesconto 
      WITH FRAME FRAME-D IN WINDOW wWin.
  ENABLE fil-filtroDtIniDesconto fil-filtroDtFimDesconto bt-filtroDesconto 
         bt-incluiDesconto br-desconto br-descontoproduto 
      WITH FRAME FRAME-D IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-D}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-excluiCategoria wWin 
PROCEDURE p-excluiCategoria :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-B:

    IF AVAIL tt-categorias THEN DO:

        FIND FIRST categoria WHERE                                                                                                 
                   categoria.usuario-id   = vsi-usr-id AND                                                                         
                   categoria.categoria-id = tt-categorias.categoria-id EXCLUSIVE-LOCK NO-ERROR. 
        IF AVAIL categoria THEN DO:
                                                                                                                                   
            FIND LAST bf-histCategoria WHERE                                                                                           
                      bf-histCategoria.usuario-id   = vsi-usr-id AND                                                                   
                      bf-histCategoria.categoria-id = categoria.categoria-id NO-LOCK NO-ERROR.                                         
                                                                                                                                       
            CREATE histCategoria.                                                                                                      
            ASSIGN histCategoria.usuario-id              = categoria.usuario-id                                                        
                   histCategoria.categoria-id            = categoria.categoria-id                                                      
                   histCategoria.histcategoria-seq       = IF AVAIL bf-histCategoria THEN bf-histCategoria.histcategoria-seq + 1 ELSE 1
                   histCategoria.histcategoria-descricao = categoria.categoria-descricao                                               
                   histCategoria.histcategoria-dataAlt   = categoria.categoria-dataAlt                                                 
                   histCategoria.histcategoria-horaAlt   = categoria.categoria-horaAlt.    


            DELETE categoria.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-excluiDesconto wWin 
PROCEDURE p-excluiDesconto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-D:

    IF AVAIL tt-descontos THEN DO:

        FIND FIRST desconto WHERE
                   desconto.usuario-id  = vsi-usr-id AND
                   desconto.desconto-id = tt-descontos.desconto-id EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL desconto THEN DO:

            FOR EACH descontoProduto WHERE                                      
                     descontoProduto.usuario-id  = vsi-usr-id AND               
                     descontoProduto.desconto-id = desconto.desconto-id EXCLUSIVE-LOCK.

                DELETE descontoProduto.
            END.

            DELETE desconto.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-excluiProduto wWin 
PROCEDURE p-excluiProduto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-C:

    IF AVAIL tt-produtos THEN DO:

        FIND FIRST produto WHERE                                                                       
                   produto.usuario-id = vsi-usr-id AND                                                 
                   produto.produto-id = tt-produtos.produto-id EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL produto THEN DO:

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
                   histProduto.histproduto-horaAlt        = produto.produto-horaAlt.                                              

            DELETE produto.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-filtroCategoria wWin 
PROCEDURE p-filtroCategoria :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-B:

    EMPTY TEMP-TABLE tt-categorias.

    FOR EACH categoria WHERE                           
             categoria.usuario-id = vsi-usr-id NO-LOCK.

        IF INPUT fil-filtroIdCategoria <> ? AND INPUT fil-filtroIdCategoria <> 0 THEN DO:                  
            IF INPUT fil-filtroIdCategoria <> categoria.categoria-id THEN                                    
                NEXT.                                                                                  
        END.                                                                                                                                                                                  
                                                                                                       
        IF TRIM(fil-filtroDescCategoria:SCREEN-VALUE) <> "" THEN DO:                                     
            IF categoria.categoria-descricao MATCHES("*" + TRIM(fil-filtroDescCategoria:SCREEN-VALUE) + "*") THEN.
            ELSE                                                                                       
                NEXT.                                                                                  
        END.                                                                                           
                                                       
        CREATE tt-categorias.                          
        BUFFER-COPY categoria TO tt-categorias.        
    END.                                               

    {&OPEN-QUERY-br-categoria}

    APPLY "VALUE-CHANGED" TO br-categoria.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-filtroDesconto wWin 
PROCEDURE p-filtroDesconto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-D:

    ASSIGN iIDdesconto = ?.                
                                           
    EMPTY TEMP-TABLE tt-descontos.         
    EMPTY TEMP-TABLE tt-descontoprodutos.  

    FOR EACH desconto WHERE                                                             
             desconto.usuario-id = vsi-usr-id NO-LOCK.

        IF INPUT fil-filtroDtIniDesconto <> ? AND INPUT fil-filtroDtFimDesconto <> ? THEN DO:

            IF desconto.desconto-dataIni <= INPUT fil-filtroDtFimDesconto AND
               desconto.desconto-dataFim >= INPUT fil-filtroDtIniDesconto THEN.
            ELSE
                NEXT.
        END.
                                                                                        
        CREATE tt-descontos.                                                            
        BUFFER-COPY desconto TO tt-descontos.                                           
                                                                                        
        FOR EACH descontoProduto WHERE                                                  
                 descontoProduto.usuario-id  = vsi-usr-id AND                           
                 descontoProduto.desconto-id = desconto.desconto-id NO-LOCK.            
                                                                                        
            CREATE tt-descontoprodutos.                                                 
            BUFFER-COPY descontoProduto TO tt-descontoprodutos.                         
                                                                                        
            FIND FIRST produto WHERE                                                    
                       produto.usuario-id = vsi-usr-id AND                              
                       produto.produto-id = descontoProduto.produto-id NO-LOCK NO-ERROR.
            IF AVAIL produto THEN                                                       
                ASSIGN tt-descontoprodutos.produtoNome = produto.produto-nome.          
            ELSE                                                                        
                ASSIGN tt-descontoprodutos.produtoNome = "".                            
        END.                                                                            
    END.                                                                                
                                                                                        
    {&OPEN-QUERY-br-desconto}                                                           
                                                                                        
    APPLY "VALUE-CHANGED" TO br-desconto.                                               
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
DO WITH FRAME FRAME-C:

    EMPTY TEMP-TABLE tt-produtos.

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
                                                       
        CREATE tt-produtos.                          
        BUFFER-COPY produto TO tt-produtos.    

        FIND FIRST categoria WHERE                                                
                   categoria.usuario-id   = vsi-usr-id AND                        
                   categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.
        IF AVAIL categoria THEN                                                   
            ASSIGN tt-produtos.categoriaDesc = categoria.categoria-descricao.     
        ELSE                                                                      
            ASSIGN tt-produtos.categoriaDesc = "".                                
    END.                                               

    {&OPEN-QUERY-br-produto}

    APPLY "VALUE-CHANGED" TO br-produto.
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

    APPLY "CHOOSE" TO bt-conta IN FRAME fMain.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leituraCategoria wWin 
PROCEDURE p-leituraCategoria :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-B:

    EMPTY TEMP-TABLE tt-categorias.

    ASSIGN fil-filtroIdCategoria:SCREEN-VALUE   = ""
           fil-filtroDescCategoria:SCREEN-VALUE = "".

    FOR EACH categoria WHERE
             categoria.usuario-id = vsi-usr-id NO-LOCK.

        CREATE tt-categorias.
        BUFFER-COPY categoria TO tt-categorias.
    END.

    {&OPEN-QUERY-br-categoria}

    APPLY "VALUE-CHANGED" TO br-categoria.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leituraConta wWin 
PROCEDURE p-leituraConta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:

    ASSIGN lVisualizaSenha = NO.                                                         
                                                                                         
    ASSIGN bt-senha:LABEL IN FRAME FRAME-A = "" NO-ERROR.                                
                                                                                         
    bt-senha:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\ocultar.png") IN FRAME FRAME-A.

    FIND FIRST usuario WHERE
               usuario.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.
    IF AVAIL usuario THEN DO:

        ASSIGN fil-nome:SCREEN-VALUE          = usuario.usuario-nome
               fil-email:SCREEN-VALUE         = usuario.usuario-email
               rd-tipo:SCREEN-VALUE           = string(usuario.usuario-tipoIdentificacao)
               fil-identificacao:SCREEN-VALUE = usuario.usuario-identificacao
               fil-telefone:SCREEN-VALUE      = usuario.usuario-telefone
               fil-usuario:SCREEN-VALUE       = usuario.usuario-login
               fil-senha:SCREEN-VALUE         = usuario.usuario-senha. 
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leituraDesconto wWin 
PROCEDURE p-leituraDesconto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-D:

    ASSIGN iIDdesconto = ?.

    EMPTY TEMP-TABLE tt-descontos.
    EMPTY TEMP-TABLE tt-descontoprodutos.

    ASSIGN fil-filtroDtIniDesconto:SCREEN-VALUE = ""
           fil-filtroDtFimDesconto:SCREEN-VALUE = "".

    FOR EACH desconto WHERE
             desconto.usuario-id = vsi-usr-id NO-LOCK.

        CREATE tt-descontos.
        BUFFER-COPY desconto TO tt-descontos.

        FOR EACH descontoProduto WHERE
                 descontoProduto.usuario-id  = vsi-usr-id AND
                 descontoProduto.desconto-id = desconto.desconto-id NO-LOCK.

            CREATE tt-descontoprodutos.
            BUFFER-COPY descontoProduto TO tt-descontoprodutos.

            FIND FIRST produto WHERE
                       produto.usuario-id = vsi-usr-id AND
                       produto.produto-id = descontoProduto.produto-id NO-LOCK NO-ERROR.
            IF AVAIL produto THEN
                ASSIGN tt-descontoprodutos.produtoNome = produto.produto-nome.
            ELSE
                ASSIGN tt-descontoprodutos.produtoNome = "".
        END.
    END.

    {&OPEN-QUERY-br-desconto}            
                                        
    APPLY "VALUE-CHANGED" TO br-desconto.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leituraProduto wWin 
PROCEDURE p-leituraProduto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-C:

    EMPTY TEMP-TABLE tt-produtos.

    ASSIGN imgFoto:STRETCH-TO-FIT = TRUE    
           imgFoto:RETAIN-SHAPE   = TRUE.   
                                                             
    imgFoto:LOAD-IMAGE(cImgPadrao) NO-ERROR.

    IF cb-filtroCategoria:NUM-ITEMS = 0 THEN DO:
        FOR EACH categoria WHERE                                                         
                 categoria.usuario-id = vsi-usr-id NO-LOCK.                              
                                                                                         
            cb-filtroCategoria:ADD-LAST(categoria.categoria-descricao, categoria.categoria-id).
        END.  
        cb-filtroCategoria:ADD-FIRST(" ", 0).
    END.
    ASSIGN cb-filtroCategoria:SCREEN-VALUE = cb-filtroCategoria:ENTRY(1).

    ASSIGN fil-filtroIdProduto:SCREEN-VALUE   = ""
           fil-filtroDescProduto:SCREEN-VALUE = "".

    FOR EACH produto WHERE
             produto.usuario-id = vsi-usr-id NO-LOCK.

        CREATE tt-produtos.
        BUFFER-COPY produto TO tt-produtos.

        FIND FIRST categoria WHERE                  
                   categoria.usuario-id   = vsi-usr-id AND
                   categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.
        IF AVAIL categoria THEN
            ASSIGN tt-produtos.categoriaDesc = categoria.categoria-descricao.
        ELSE
            ASSIGN tt-produtos.categoriaDesc = "".
    END.

    {&OPEN-QUERY-br-produto}

    APPLY "VALUE-CHANGED" TO br-produto.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pFrames wWin 
PROCEDURE pFrames :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

    CASE vc-frame:
        WHEN "CONTA" THEN DO:
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 15.

            HIDE FRAME FRAME-B.
            HIDE FRAME FRAME-C.
            HIDE FRAME FRAME-D.

            VIEW FRAME FRAME-A.

            RUN p-leituraConta.
        END.
        WHEN "CATEGORIA" THEN DO:                             
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 15. 
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
                                                          
            HIDE FRAME FRAME-A.
            HIDE FRAME FRAME-C.
            HIDE FRAME FRAME-D.                              
                                                          
            VIEW FRAME FRAME-B. 

            RUN p-leituraCategoria.
        END.  
        WHEN "PRODUTO" THEN DO:                             
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 15. 
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
                                                          
            HIDE FRAME FRAME-A.                   
            HIDE FRAME FRAME-B.
            HIDE FRAME FRAME-D.
                                           
            VIEW FRAME FRAME-C.   

            RUN p-leituraProduto.
        END.   
        WHEN "DESCONTO" THEN DO:                             
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 15. 
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
                                                          
            HIDE FRAME FRAME-A.                    
            HIDE FRAME FRAME-B.
            HIDE FRAME FRAME-C.
                                                          
            VIEW FRAME FRAME-D. 

            RUN p-leituraDesconto.
        END.                                              
    END CASE.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

