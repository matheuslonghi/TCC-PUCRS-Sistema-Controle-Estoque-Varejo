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

DEF VAR vc-frame AS CHAR NO-UNDO.

DEF VAR dTotVendas         AS DEC NO-UNDO.
DEF VAR dTotCompras        AS DEC NO-UNDO.
DEF VAR iNumVendas         AS INT NO-UNDO.
DEF VAR iQtdProdVendas     AS INT NO-UNDO.
DEF VAR iTamanhoEstoque    AS INT NO-UNDO.
DEF VAR iTamanhoEstoqueAnt AS INT NO-UNDO.

DEF TEMP-TABLE tt-indicadoresDisp
    FIELD id   AS INT
    FIELD nome AS CHAR.

DEF TEMP-TABLE tt-indicadoresSelec LIKE tt-indicadoresDisp.

DEF TEMP-TABLE tt-totais
    FIELD ind1  AS CHAR
    FIELD ind1V AS LOG
    FIELD ind2  AS CHAR
    FIELD ind2V AS LOG 
    FIELD ind3  AS CHAR
    FIELD ind3V AS LOG 
    FIELD ind4  AS CHAR
    FIELD ind4V AS LOG 
    FIELD ind5  AS CHAR
    FIELD ind5V AS LOG 
    FIELD ind6  AS CHAR
    FIELD ind6V AS LOG 
    FIELD ind7  AS CHAR
    FIELD ind7V AS LOG 
    FIELD ind8  AS CHAR
    FIELD ind8V AS LOG 
    FIELD ind9  AS CHAR
    FIELD ind9V AS LOG 
    FIELD ind10  AS CHAR
    FIELD ind10V AS LOG. 

DEF TEMP-TABLE tt-InfoVendaProduto
    FIELD produto-id   AS INT
    FIELD produto-nome AS CHAR
    FIELD quantidade   AS INT
    FIELD valorTot     AS DEC
    FIELD custo        AS DEC.

DEF TEMP-TABLE tt-compra LIKE compraProduto
    FIELD compra-data         AS DATE  
    FIELD compra-hora         AS INT
    FIELD nf                  AS LOG
    FIELD compra-notafiscal   AS CHAR
    FIELD produto-nome        AS CHAR.

DEF TEMP-TABLE tt-venda LIKE vendaProduto
    FIELD venda-data       AS DATE 
    FIELD venda-hora       AS INT  
    FIELD nf               AS LOG  
    FIELD venda-notafiscal AS CHAR 
    FIELD produto-nome     AS CHAR
    FIELD desconto         AS INT.

DEF TEMP-TABLE tt-desconto LIKE descontoProduto
    FIELD desconto-dataIni    AS DATE  
    FIELD desconto-dataFim    AS DATE  
    FIELD produto-nome        AS CHAR 
    FIELD categoria-id        AS INT  
    FIELD categoria-descricao AS CHAR.

DEF TEMP-TABLE tt-estoque LIKE estoqueProduto
    FIELD mes                 AS INT
    FIELD ano                 AS INT
    FIELD produto-nome        AS CHAR
    FIELD categoria-id        AS INT
    FIELD categoria-descricao AS CHAR.

DEF BUFFER bf-tt-compra           FOR tt-compra.
DEF BUFFER bf-tt-venda            FOR tt-venda.
DEF BUFFER bf-tt-desconto         FOR tt-desconto.
DEF BUFFER bf-tt-estoque          FOR tt-estoque.
DEF BUFFER bf-tt-indicadoresDisp  FOR tt-indicadoresDisp.
DEF BUFFER bf-tt-indicadoresSelec FOR tt-indicadoresSelec.
DEF BUFFER bf-tt-totais           FOR tt-totais.

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
&Scoped-define BROWSE-NAME br-compra

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-compra tt-desconto tt-estoque ~
tt-indicadoresDisp tt-indicadoresSelec tt-totais tt-venda

/* Definitions for BROWSE br-compra                                     */
&Scoped-define FIELDS-IN-QUERY-br-compra tt-compra.compra-data string(tt-compra.compra-hora,"HH:MM:SS") tt-compra.produto-id tt-compra.produto-nome tt-compra.compraproduto-quantidade tt-compra.compraproduto-valorUnidade tt-compra.compraproduto-valorTotal tt-compra.nf   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-compra   
&Scoped-define SELF-NAME br-compra
&Scoped-define QUERY-STRING-br-compra FOR EACH tt-compra BY tt-compra.compra-id                                            BY tt-compra.produto-id
&Scoped-define OPEN-QUERY-br-compra OPEN QUERY {&SELF-NAME} FOR EACH tt-compra BY tt-compra.compra-id                                            BY tt-compra.produto-id.
&Scoped-define TABLES-IN-QUERY-br-compra tt-compra
&Scoped-define FIRST-TABLE-IN-QUERY-br-compra tt-compra


/* Definitions for BROWSE br-desconto                                   */
&Scoped-define FIELDS-IN-QUERY-br-desconto tt-desconto.desconto-dataIni tt-desconto.desconto-dataFim tt-desconto.descontoproduto-valor tt-desconto.produto-id tt-desconto.produto-nome tt-desconto.categoria-id tt-desconto.categoria-descricao   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-desconto   
&Scoped-define SELF-NAME br-desconto
&Scoped-define QUERY-STRING-br-desconto FOR EACH tt-desconto BY tt-desconto.desconto-id                                              BY tt-desconto.produto-id
&Scoped-define OPEN-QUERY-br-desconto OPEN QUERY {&SELF-NAME} FOR EACH tt-desconto BY tt-desconto.desconto-id                                              BY tt-desconto.produto-id.
&Scoped-define TABLES-IN-QUERY-br-desconto tt-desconto
&Scoped-define FIRST-TABLE-IN-QUERY-br-desconto tt-desconto


/* Definitions for BROWSE br-estoque                                    */
&Scoped-define FIELDS-IN-QUERY-br-estoque tt-estoque.estoqueproduto-quantidade tt-estoque.produto-id tt-estoque.produto-nome tt-estoque.categoria-id tt-estoque.categoria-descricao   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-estoque   
&Scoped-define SELF-NAME br-estoque
&Scoped-define QUERY-STRING-br-estoque FOR EACH tt-estoque BY tt-estoque.produto-id
&Scoped-define OPEN-QUERY-br-estoque OPEN QUERY {&SELF-NAME} FOR EACH tt-estoque BY tt-estoque.produto-id.
&Scoped-define TABLES-IN-QUERY-br-estoque tt-estoque
&Scoped-define FIRST-TABLE-IN-QUERY-br-estoque tt-estoque


/* Definitions for BROWSE br-indicadoresDisp                            */
&Scoped-define FIELDS-IN-QUERY-br-indicadoresDisp tt-indicadoresDisp.id tt-indicadoresDisp.nome   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-indicadoresDisp   
&Scoped-define SELF-NAME br-indicadoresDisp
&Scoped-define QUERY-STRING-br-indicadoresDisp FOR EACH tt-indicadoresDisp BY tt-indicadoresDisp.id
&Scoped-define OPEN-QUERY-br-indicadoresDisp OPEN QUERY {&SELF-NAME} FOR EACH tt-indicadoresDisp BY tt-indicadoresDisp.id.
&Scoped-define TABLES-IN-QUERY-br-indicadoresDisp tt-indicadoresDisp
&Scoped-define FIRST-TABLE-IN-QUERY-br-indicadoresDisp tt-indicadoresDisp


/* Definitions for BROWSE br-indicadoresSelec                           */
&Scoped-define FIELDS-IN-QUERY-br-indicadoresSelec tt-indicadoresSelec.id tt-indicadoresSelec.nome   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-indicadoresSelec   
&Scoped-define SELF-NAME br-indicadoresSelec
&Scoped-define QUERY-STRING-br-indicadoresSelec FOR EACH tt-indicadoresSelec BY tt-indicadoresSelec.id
&Scoped-define OPEN-QUERY-br-indicadoresSelec OPEN QUERY {&SELF-NAME} FOR EACH tt-indicadoresSelec BY tt-indicadoresSelec.id.
&Scoped-define TABLES-IN-QUERY-br-indicadoresSelec tt-indicadoresSelec
&Scoped-define FIRST-TABLE-IN-QUERY-br-indicadoresSelec tt-indicadoresSelec


/* Definitions for BROWSE br-totais                                     */
&Scoped-define FIELDS-IN-QUERY-br-totais tt-totais.ind1 tt-totais.ind2 tt-totais.ind3 tt-totais.ind4 tt-totais.ind5 tt-totais.ind6 tt-totais.ind7 tt-totais.ind8 tt-totais.ind9 tt-totais.ind10   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-totais   
&Scoped-define SELF-NAME br-totais
&Scoped-define QUERY-STRING-br-totais FOR EACH tt-totais
&Scoped-define OPEN-QUERY-br-totais OPEN QUERY {&SELF-NAME} FOR EACH tt-totais.
&Scoped-define TABLES-IN-QUERY-br-totais tt-totais
&Scoped-define FIRST-TABLE-IN-QUERY-br-totais tt-totais


/* Definitions for BROWSE br-venda                                      */
&Scoped-define FIELDS-IN-QUERY-br-venda tt-venda.venda-data string(tt-venda.venda-hora,"HH:MM:SS") tt-venda.produto-id tt-venda.produto-nome tt-venda.vendaproduto-quantidade tt-venda.vendaproduto-valorUnidade tt-venda.vendaproduto-valorTotal tt-venda.desconto tt-venda.nf   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-venda   
&Scoped-define SELF-NAME br-venda
&Scoped-define QUERY-STRING-br-venda FOR EACH tt-venda BY tt-venda.venda-id                                           BY tt-venda.produto-id
&Scoped-define OPEN-QUERY-br-venda OPEN QUERY {&SELF-NAME} FOR EACH tt-venda BY tt-venda.venda-id                                           BY tt-venda.produto-id.
&Scoped-define TABLES-IN-QUERY-br-venda tt-venda
&Scoped-define FIRST-TABLE-IN-QUERY-br-venda tt-venda


/* Definitions for FRAME FRAME-A                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-A ~
    ~{&OPEN-QUERY-br-indicadoresDisp}~
    ~{&OPEN-QUERY-br-indicadoresSelec}~
    ~{&OPEN-QUERY-br-totais}

/* Definitions for FRAME FRAME-B                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-B ~
    ~{&OPEN-QUERY-br-compra}

/* Definitions for FRAME FRAME-C                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-C ~
    ~{&OPEN-QUERY-br-venda}

/* Definitions for FRAME FRAME-D                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-D ~
    ~{&OPEN-QUERY-br-desconto}

/* Definitions for FRAME FRAME-E                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-E ~
    ~{&OPEN-QUERY-br-estoque}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bt-totais bt-compra bt-venda bt-desconto ~
bt-estoque Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS FILL-IN-3 FILL-IN-4 FILL-IN-5 FILL-IN-6 ~
FILL-IN-7 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-diasMes wWin 
FUNCTION f-diasMes RETURNS INTEGER
  (INPUT iMes AS INT, INPUT iAno AS INT)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD f-width wWin 
FUNCTION f-width RETURNS INTEGER
  (INPUT ctexto AS CHAR)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-compra 
     LABEL "Compras" 
     SIZE 15 BY 1.1.

DEFINE BUTTON bt-desconto 
     LABEL "Descontos" 
     SIZE 15 BY 1.1.

DEFINE BUTTON bt-estoque 
     LABEL "Estoque" 
     SIZE 15 BY 1.1.

DEFINE BUTTON bt-totais 
     LABEL "Totais" 
     SIZE 15 BY 1.1.

DEFINE BUTTON bt-venda 
     LABEL "Vendas" 
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

DEFINE VARIABLE FILL-IN-7 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1.67 NO-UNDO.

DEFINE BUTTON bt-filtroTotais 
     LABEL "Filtrar" 
     SIZE 24.6 BY 1.

DEFINE BUTTON bt-imprimeTotais 
     LABEL "Imprimir" 
     SIZE 24.6 BY 1.

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

DEFINE VARIABLE fil-anoTotais AS INTEGER FORMAT ">>>>":U INITIAL 0 
     LABEL "Ano" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE fil-mesTotais AS INTEGER FORMAT ">>":U INITIAL 0 
     LABEL "Mês" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 1.48.

DEFINE BUTTON bt-filtroCompra 
     LABEL "Filtrar" 
     SIZE 24.6 BY 1.

DEFINE BUTTON bt-imprimeCompra 
     LABEL "Imprimir" 
     SIZE 24.6 BY 1.

DEFINE BUTTON bt-nfCompra 
     LABEL "Visualiza Nota Fiscal" 
     SIZE 22 BY 1.

DEFINE VARIABLE fil-anoCompra AS INTEGER FORMAT ">>>>":U INITIAL 0 
     LABEL "Ano" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE fil-mesCompra AS INTEGER FORMAT ">>":U INITIAL 0 
     LABEL "Mês" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 1.48.

DEFINE BUTTON bt-filtroVenda 
     LABEL "Filtrar" 
     SIZE 24.6 BY 1.

DEFINE BUTTON bt-imprimeVenda 
     LABEL "Imprimir" 
     SIZE 24.6 BY 1.

DEFINE BUTTON bt-nfVenda 
     LABEL "Visualiza Nota Fiscal" 
     SIZE 22 BY 1.

DEFINE VARIABLE fil-anoVenda AS INTEGER FORMAT ">>>>":U INITIAL 0 
     LABEL "Ano" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE fil-mesVenda AS INTEGER FORMAT ">>":U INITIAL 0 
     LABEL "Mês" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 1.48.

DEFINE BUTTON bt-filtroDesconto 
     LABEL "Filtrar" 
     SIZE 24.6 BY 1.

DEFINE BUTTON bt-imprimeDesconto 
     LABEL "Imprimir" 
     SIZE 24.6 BY 1.

DEFINE VARIABLE fil-anoDesconto AS INTEGER FORMAT ">>>>":U INITIAL 0 
     LABEL "Ano" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE fil-mesDesconto AS INTEGER FORMAT ">>":U INITIAL 0 
     LABEL "Mês" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 1.48.

DEFINE BUTTON bt-filtroEstoque 
     LABEL "Filtrar" 
     SIZE 24.6 BY 1.

DEFINE BUTTON bt-imprimeEstoque 
     LABEL "Imprimir" 
     SIZE 24.6 BY 1.

DEFINE VARIABLE fil-anoEstoque AS INTEGER FORMAT ">>>>":U INITIAL 0 
     LABEL "Ano" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE fil-mesEstoque AS INTEGER FORMAT ">>":U INITIAL 0 
     LABEL "Mês" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 1.48.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-compra FOR 
      tt-compra SCROLLING.

DEFINE QUERY br-desconto FOR 
      tt-desconto SCROLLING.

DEFINE QUERY br-estoque FOR 
      tt-estoque SCROLLING.

DEFINE QUERY br-indicadoresDisp FOR 
      tt-indicadoresDisp SCROLLING.

DEFINE QUERY br-indicadoresSelec FOR 
      tt-indicadoresSelec SCROLLING.

DEFINE QUERY br-totais FOR 
      tt-totais SCROLLING.

DEFINE QUERY br-venda FOR 
      tt-venda SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-compra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-compra wWin _FREEFORM
  QUERY br-compra DISPLAY
      tt-compra.compra-data                    COLUMN-LABEL "Data"        FORMAT "99/99/9999"
      string(tt-compra.compra-hora,"HH:MM:SS") COLUMN-LABEL "Hora"        WIDTH 10     
      tt-compra.produto-id                     COLUMN-LABEL "ID"          FORMAT ">>>>>"
      tt-compra.produto-nome                   COLUMN-LABEL "Produto"     FORMAT "x(50)"
      tt-compra.compraproduto-quantidade       COLUMN-LABEL "Qtd."        FORMAT ">>>>>9"
      tt-compra.compraproduto-valorUnidade     COLUMN-LABEL "Valor Uni."
      tt-compra.compraproduto-valorTotal       COLUMN-LABEL "Valor Total"
      tt-compra.nf                             COLUMN-LABEL "NF?"         FORMAT "Sim/Não"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 123.4 BY 15.33
         TITLE "Compras" FIT-LAST-COLUMN.

DEFINE BROWSE br-desconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-desconto wWin _FREEFORM
  QUERY br-desconto DISPLAY
      tt-desconto.desconto-dataIni          COLUMN-LABEL "Data Inicio" FORMAT "99/99/9999"
      tt-desconto.desconto-dataFim          COLUMN-LABEL "Data Fim"    FORMAT "99/99/9999"
      tt-desconto.descontoproduto-valor     column-label "% Desconto"  FORMAT ">>9"
      tt-desconto.produto-id                COLUMN-LABEL "ID"          FORMAT ">>>>"
      tt-desconto.produto-nome              column-label "Produto"     FORMAT "x(50)"
      tt-desconto.categoria-id              COLUMN-LABEL "ID"          FORMAT ">>>>"
      tt-desconto.categoria-descricao       column-label "Categoria"   FORMAT "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 123.4 BY 15.33
         TITLE "Descontos" FIT-LAST-COLUMN.

DEFINE BROWSE br-estoque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-estoque wWin _FREEFORM
  QUERY br-estoque DISPLAY
      tt-estoque.estoqueproduto-quantidade column-label "Qtd."      FORMAT ">>>9"
      tt-estoque.produto-id                COLUMN-LABEL "ID"        FORMAT ">>>>"
      tt-estoque.produto-nome              column-label "Produto"   FORMAT "x(50)"
      tt-estoque.categoria-id              COLUMN-LABEL "ID"        FORMAT ">>>>"
      tt-estoque.categoria-descricao       column-label "Categoria" FORMAT "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 123.4 BY 15.33
         TITLE "Estoque" FIT-LAST-COLUMN.

DEFINE BROWSE br-indicadoresDisp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-indicadoresDisp wWin _FREEFORM
  QUERY br-indicadoresDisp DISPLAY
      tt-indicadoresDisp.id   COLUMN-LABEL "ID"
      tt-indicadoresDisp.nome COLUMN-LABEL "Nome" FORMAT "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 57 BY 11.86
         TITLE "Indicadores Disponíveis" FIT-LAST-COLUMN.

DEFINE BROWSE br-indicadoresSelec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-indicadoresSelec wWin _FREEFORM
  QUERY br-indicadoresSelec DISPLAY
      tt-indicadoresSelec.id   COLUMN-LABEL "ID"
      tt-indicadoresSelec.nome COLUMN-LABEL "Nome" FORMAT "x(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 57 BY 11.86
         TITLE "Indicadores Selecionados" FIT-LAST-COLUMN.

DEFINE BROWSE br-totais
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-totais wWin _FREEFORM
  QUERY br-totais DISPLAY
      tt-totais.ind1  column-label "Ind.1"   width 9
      tt-totais.ind2  column-label "Ind.2"   width 9
      tt-totais.ind3  column-label "Ind.3"   width 9
      tt-totais.ind4  column-label "Ind.4"   width 9
      tt-totais.ind5  column-label "Ind.5" format "x(50)"  width 16
      tt-totais.ind6  column-label "Ind.6" format "x(50)"  width 16
      tt-totais.ind7  column-label "Ind.7"   width 9
      tt-totais.ind8  column-label "Ind.8"   width 9
      tt-totais.ind9  column-label "Ind.9"   width 9
      tt-totais.ind10 column-label "Ind.10"  width 9
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 123 BY 3.43
         TITLE "Totais".

DEFINE BROWSE br-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-venda wWin _FREEFORM
  QUERY br-venda DISPLAY
      tt-venda.venda-data                    COLUMN-LABEL "Data"        FORMAT "99/99/9999"
      string(tt-venda.venda-hora,"HH:MM:SS") COLUMN-LABEL "Hora"        WIDTH 10
      tt-venda.produto-id                    COLUMN-LABEL "ID"          FORMAT ">>>>>"
      tt-venda.produto-nome                  COLUMN-LABEL "Produto"     FORMAT "x(50)"
      tt-venda.vendaproduto-quantidade       COLUMN-LABEL "Qtd."        FORMAT ">>>>>9"
      tt-venda.vendaproduto-valorUnidade     COLUMN-LABEL "Valor Uni."
      tt-venda.vendaproduto-valorTotal       COLUMN-LABEL "Valor Total"
      tt-venda.desconto                      COLUMN-LABEL "% Desconto"  FORMAT ">>9"
      tt-venda.nf                            COLUMN-LABEL "NF?"         FORMAT "Sim/Não"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 123.4 BY 15.33
         TITLE "Vendas" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     FILL-IN-3 AT ROW 1.57 COL 1 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     FILL-IN-4 AT ROW 1.57 COL 20.2 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     FILL-IN-5 AT ROW 1.57 COL 39.4 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     FILL-IN-6 AT ROW 1.57 COL 58.4 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     FILL-IN-7 AT ROW 1.57 COL 77.6 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     bt-totais AT ROW 1.86 COL 4 WIDGET-ID 4
     bt-compra AT ROW 1.86 COL 23.2 WIDGET-ID 8
     bt-venda AT ROW 1.86 COL 42.4 WIDGET-ID 12
     bt-desconto AT ROW 1.86 COL 61.4 WIDGET-ID 16
     bt-estoque AT ROW 1.86 COL 80.6 WIDGET-ID 20
     Btn_Cancel AT ROW 1.86 COL 108.8 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 126.6 BY 19.91 WIDGET-ID 100.

DEFINE FRAME FRAME-A
     bt-filtroTotais AT ROW 1.38 COL 40.2 WIDGET-ID 72
     bt-imprimeTotais AT ROW 1.38 COL 64.8 WIDGET-ID 74
     fil-mesTotais AT ROW 1.43 COL 17.2 COLON-ALIGNED WIDGET-ID 78
     fil-anoTotais AT ROW 1.43 COL 28.2 COLON-ALIGNED WIDGET-ID 76
     br-indicadoresDisp AT ROW 2.71 COL 1.6 WIDGET-ID 700
     br-indicadoresSelec AT ROW 2.71 COL 68 WIDGET-ID 800
     bt-selecionaTodos AT ROW 5.62 COL 59.4 WIDGET-ID 50
     bt-seleciona AT ROW 6.81 COL 59.4 WIDGET-ID 48
     bt-retira AT ROW 9.19 COL 59.4 WIDGET-ID 54
     bt-retiraTodos AT ROW 10.38 COL 59.4 WIDGET-ID 52
     br-totais AT ROW 14.67 COL 2 WIDGET-ID 900
     "Relatório:" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 1.57 COL 2.6 WIDGET-ID 82
     RECT-9 AT ROW 1.19 COL 1.6 WIDGET-ID 80
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.38
         SIZE 125 BY 17.38 WIDGET-ID 200.

DEFINE FRAME FRAME-C
     bt-filtroVenda AT ROW 1.38 COL 40.2 WIDGET-ID 70
     bt-imprimeVenda AT ROW 1.38 COL 64.8 WIDGET-ID 68
     bt-nfVenda AT ROW 1.38 COL 102.6 WIDGET-ID 72
     fil-mesVenda AT ROW 1.43 COL 17.2 COLON-ALIGNED WIDGET-ID 64
     fil-anoVenda AT ROW 1.43 COL 28.2 COLON-ALIGNED WIDGET-ID 66
     br-venda AT ROW 2.81 COL 1.6 WIDGET-ID 1100
     "Relatório:" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 1.57 COL 2.6 WIDGET-ID 62
     RECT-10 AT ROW 1.19 COL 1.6 WIDGET-ID 56
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.38
         SIZE 125 BY 17.38 WIDGET-ID 400.

DEFINE FRAME FRAME-B
     bt-filtroCompra AT ROW 1.38 COL 40.2 WIDGET-ID 70
     bt-imprimeCompra AT ROW 1.38 COL 64.8 WIDGET-ID 68
     bt-nfCompra AT ROW 1.38 COL 102.6 WIDGET-ID 72
     fil-mesCompra AT ROW 1.43 COL 17.2 COLON-ALIGNED WIDGET-ID 64
     fil-anoCompra AT ROW 1.43 COL 28.2 COLON-ALIGNED WIDGET-ID 66
     br-compra AT ROW 2.81 COL 1.6 WIDGET-ID 1000
     "Relatório:" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 1.57 COL 2.6 WIDGET-ID 62
     RECT-8 AT ROW 1.19 COL 1.6 WIDGET-ID 56
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.38
         SIZE 125 BY 17.38 WIDGET-ID 300.

DEFINE FRAME FRAME-D
     bt-filtroDesconto AT ROW 1.38 COL 40.2 WIDGET-ID 70
     bt-imprimeDesconto AT ROW 1.38 COL 64.8 WIDGET-ID 68
     fil-mesDesconto AT ROW 1.43 COL 17.2 COLON-ALIGNED WIDGET-ID 64
     fil-anoDesconto AT ROW 1.43 COL 28.2 COLON-ALIGNED WIDGET-ID 66
     br-desconto AT ROW 2.81 COL 1.6 WIDGET-ID 1200
     "Relatório:" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 1.57 COL 2.6 WIDGET-ID 62
     RECT-11 AT ROW 1.19 COL 1.6 WIDGET-ID 56
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.38
         SIZE 125 BY 17.38 WIDGET-ID 500.

DEFINE FRAME FRAME-E
     bt-filtroEstoque AT ROW 1.38 COL 40.2 WIDGET-ID 70
     bt-imprimeEstoque AT ROW 1.38 COL 64.8 WIDGET-ID 68
     fil-mesEstoque AT ROW 1.43 COL 17.2 COLON-ALIGNED WIDGET-ID 64
     fil-anoEstoque AT ROW 1.43 COL 28.2 COLON-ALIGNED WIDGET-ID 66
     br-estoque AT ROW 2.81 COL 1.6 WIDGET-ID 1300
     "Relatório:" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 1.57 COL 2.6 WIDGET-ID 62
     RECT-12 AT ROW 1.19 COL 1.6 WIDGET-ID 56
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 3.38
         SIZE 125 BY 17.38 WIDGET-ID 600.


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
         TITLE              = "Relatórios"
         HEIGHT             = 19.91
         WIDTH              = 126.6
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
       FRAME FRAME-D:FRAME = FRAME fMain:HANDLE
       FRAME FRAME-E:FRAME = FRAME fMain:HANDLE.

/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME FRAME-E:MOVE-AFTER-TAB-ITEM (Btn_Cancel:HANDLE IN FRAME fMain)
       XXTABVALXX = FRAME FRAME-B:MOVE-BEFORE-TAB-ITEM (FRAME FRAME-C:HANDLE)
       XXTABVALXX = FRAME FRAME-A:MOVE-BEFORE-TAB-ITEM (FRAME FRAME-B:HANDLE)
       XXTABVALXX = FRAME FRAME-D:MOVE-BEFORE-TAB-ITEM (FRAME FRAME-A:HANDLE)
       XXTABVALXX = FRAME FRAME-E:MOVE-BEFORE-TAB-ITEM (FRAME FRAME-D:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FILL-IN FILL-IN-3 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN FILL-IN-4 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN FILL-IN-5 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN FILL-IN-6 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN FILL-IN-7 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-A
   NOT-VISIBLE                                                          */
/* BROWSE-TAB br-indicadoresDisp fil-anoTotais FRAME-A */
/* BROWSE-TAB br-indicadoresSelec br-indicadoresDisp FRAME-A */
/* BROWSE-TAB br-totais bt-retiraTodos FRAME-A */
ASSIGN 
       FRAME FRAME-A:HIDDEN           = TRUE.

ASSIGN 
       br-totais:RESIZABLE IN FRAME FRAME-A              = TRUE
       br-totais:MAX-DATA-GUESS IN FRAME FRAME-A         = 99999999
       br-totais:COLUMN-RESIZABLE IN FRAME FRAME-A       = TRUE
       br-totais:ROW-RESIZABLE IN FRAME FRAME-A          = TRUE.

/* SETTINGS FOR FRAME FRAME-B
   NOT-VISIBLE                                                          */
/* BROWSE-TAB br-compra fil-anoCompra FRAME-B */
ASSIGN 
       FRAME FRAME-B:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-imprimeCompra IN FRAME FRAME-B
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bt-nfCompra IN FRAME FRAME-B
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-C
   NOT-VISIBLE                                                          */
/* BROWSE-TAB br-venda fil-anoVenda FRAME-C */
ASSIGN 
       FRAME FRAME-C:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-imprimeVenda IN FRAME FRAME-C
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bt-nfVenda IN FRAME FRAME-C
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-D
   NOT-VISIBLE                                                          */
/* BROWSE-TAB br-desconto fil-anoDesconto FRAME-D */
ASSIGN 
       FRAME FRAME-D:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-imprimeDesconto IN FRAME FRAME-D
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME FRAME-E
   NOT-VISIBLE                                                          */
/* BROWSE-TAB br-estoque fil-anoEstoque FRAME-E */
ASSIGN 
       FRAME FRAME-E:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON bt-imprimeEstoque IN FRAME FRAME-E
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-compra
/* Query rebuild information for BROWSE br-compra
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-compra BY tt-compra.compra-id
                                           BY tt-compra.produto-id.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-compra */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-desconto
/* Query rebuild information for BROWSE br-desconto
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-desconto BY tt-desconto.desconto-id
                                             BY tt-desconto.produto-id.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-desconto */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-estoque
/* Query rebuild information for BROWSE br-estoque
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-estoque BY tt-estoque.produto-id.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-estoque */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-indicadoresDisp
/* Query rebuild information for BROWSE br-indicadoresDisp
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-indicadoresDisp BY tt-indicadoresDisp.id.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-indicadoresDisp */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-indicadoresSelec
/* Query rebuild information for BROWSE br-indicadoresSelec
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-indicadoresSelec BY tt-indicadoresSelec.id.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-indicadoresSelec */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-totais
/* Query rebuild information for BROWSE br-totais
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-totais.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-totais */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-venda
/* Query rebuild information for BROWSE br-venda
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-venda BY tt-venda.venda-id
                                          BY tt-venda.produto-id.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-venda */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Relatórios */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Relatórios */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-compra
&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME br-compra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-compra wWin
ON VALUE-CHANGED OF br-compra IN FRAME FRAME-B /* Compras */
DO:
    DO WITH FRAME FRAME-B:

        FIND CURRENT tt-compra NO-LOCK NO-ERROR.
        IF AVAIL tt-compra AND
           tt-compra.nf THEN
            ENABLE bt-nfCompra.
        ELSE
            DISABLE bt-nfCompra.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-venda
&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME br-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-venda wWin
ON VALUE-CHANGED OF br-venda IN FRAME FRAME-C /* Vendas */
DO:
    DO WITH FRAME FRAME-C:

        FIND CURRENT tt-venda NO-LOCK NO-ERROR.
        IF AVAIL tt-venda AND
           tt-venda.nf THEN
            ENABLE bt-nfVenda.
        ELSE
            DISABLE bt-nfVenda.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&Scoped-define SELF-NAME bt-compra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-compra wWin
ON CHOOSE OF bt-compra IN FRAME fMain /* Compras */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN vc-frame = "COMPRA".

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


&Scoped-define SELF-NAME bt-estoque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-estoque wWin
ON CHOOSE OF bt-estoque IN FRAME fMain /* Estoque */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN vc-frame = "ESTOQUE".

        RUN pFrames.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME bt-filtroCompra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroCompra wWin
ON CHOOSE OF bt-filtroCompra IN FRAME FRAME-B /* Filtrar */
DO:
    DO WITH FRAME FRAME-B:

        IF INPUT fil-mesCompra = ? AND INPUT fil-anoCompra = ? THEN
            RETURN NO-APPLY.

        IF (INPUT fil-mesCompra <> ? AND INPUT fil-anoCompra = ?) OR
           (INPUT fil-mesCompra = ? AND INPUT fil-anoCompra <> ?)  THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.       
            RETURN NO-APPLY.                             
        END.

        IF INPUT fil-mesCompra > 12 OR 
           INPUT fil-mesCompra < 1  or
           INPUT fil-anoCompra < 1 THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        RUN p-filtroCompra.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-D
&Scoped-define SELF-NAME bt-filtroDesconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroDesconto wWin
ON CHOOSE OF bt-filtroDesconto IN FRAME FRAME-D /* Filtrar */
DO:
    DO WITH FRAME FRAME-D:

        IF INPUT fil-mesDesconto = ? AND INPUT fil-anoDesconto = ? THEN
            RETURN NO-APPLY.

        IF (INPUT fil-mesDesconto <> ? AND INPUT fil-anoDesconto = ?) OR
           (INPUT fil-mesDesconto = ? AND INPUT fil-anoDesconto <> ?)  THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.       
            RETURN NO-APPLY.                             
        END.

        IF INPUT fil-mesDesconto > 12 OR 
           INPUT fil-mesDesconto < 1  or
           INPUT fil-anoDesconto < 1 THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        RUN p-filtroDesconto.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-E
&Scoped-define SELF-NAME bt-filtroEstoque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroEstoque wWin
ON CHOOSE OF bt-filtroEstoque IN FRAME FRAME-E /* Filtrar */
DO:
    DO WITH FRAME FRAME-D:

        IF INPUT fil-mesEstoque = ? AND INPUT fil-anoEstoque = ? THEN
            RETURN NO-APPLY.

        IF (INPUT fil-mesEstoque <> ? AND INPUT fil-anoEstoque = ?) OR
           (INPUT fil-mesEstoque = ? AND INPUT fil-anoEstoque <> ?)  THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.       
            RETURN NO-APPLY.                             
        END.

        IF INPUT fil-mesEstoque > 12 OR 
           INPUT fil-mesEstoque < 1  or
           INPUT fil-anoEstoque < 1 THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        RUN p-filtroEstoque.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-A
&Scoped-define SELF-NAME bt-filtroTotais
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroTotais wWin
ON CHOOSE OF bt-filtroTotais IN FRAME FRAME-A /* Filtrar */
DO:
    DO WITH FRAME FRAME-A:

        IF INPUT fil-mesTotais = ? AND INPUT fil-anoTotais = ? THEN
            RETURN NO-APPLY.

        IF (INPUT fil-mesTotais <> ? AND INPUT fil-anoTotais = ?) OR
           (INPUT fil-mesTotais = ? AND INPUT fil-anoTotais <> ?)  THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.       
            RETURN NO-APPLY.                             
        END.

        IF INPUT fil-mesTotais > 12 OR 
           INPUT fil-mesTotais < 1  or
           INPUT fil-anoTotais < 1 THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        RUN p-filtroTotais.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME bt-filtroVenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-filtroVenda wWin
ON CHOOSE OF bt-filtroVenda IN FRAME FRAME-C /* Filtrar */
DO:
    DO WITH FRAME FRAME-C:

        IF INPUT fil-mesVenda = ? AND INPUT fil-anoVenda = ? THEN
            RETURN NO-APPLY.

        IF (INPUT fil-mesVenda <> ? AND INPUT fil-anoVenda = ?) OR
           (INPUT fil-mesVenda = ? AND INPUT fil-anoVenda <> ?)  THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.       
            RETURN NO-APPLY.                             
        END.

        IF INPUT fil-mesVenda > 12 OR 
           INPUT fil-mesVenda < 1  or
           INPUT fil-anoVenda < 1 THEN DO:

            MESSAGE "Favor selecionar um período válido."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

        RUN p-filtroVenda.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME bt-imprimeCompra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-imprimeCompra wWin
ON CHOOSE OF bt-imprimeCompra IN FRAME FRAME-B /* Imprimir */
DO:
    RUN p-imprimeCompra.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-D
&Scoped-define SELF-NAME bt-imprimeDesconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-imprimeDesconto wWin
ON CHOOSE OF bt-imprimeDesconto IN FRAME FRAME-D /* Imprimir */
DO:
    RUN p-imprimeDesconto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-E
&Scoped-define SELF-NAME bt-imprimeEstoque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-imprimeEstoque wWin
ON CHOOSE OF bt-imprimeEstoque IN FRAME FRAME-E /* Imprimir */
DO:
    RUN p-imprimeEstoque.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-A
&Scoped-define SELF-NAME bt-imprimeTotais
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-imprimeTotais wWin
ON CHOOSE OF bt-imprimeTotais IN FRAME FRAME-A /* Imprimir */
DO:
    RUN p-imprimeTotais.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME bt-imprimeVenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-imprimeVenda wWin
ON CHOOSE OF bt-imprimeVenda IN FRAME FRAME-C /* Imprimir */
DO:
    RUN p-imprimeVenda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME bt-nfCompra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-nfCompra wWin
ON CHOOSE OF bt-nfCompra IN FRAME FRAME-B /* Visualiza Nota Fiscal */
DO:
    RUN p-nfCompra.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-C
&Scoped-define SELF-NAME bt-nfVenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-nfVenda wWin
ON CHOOSE OF bt-nfVenda IN FRAME FRAME-C /* Visualiza Nota Fiscal */
DO:
    RUN p-nfVenda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-A
&Scoped-define SELF-NAME bt-retira
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-retira wWin
ON CHOOSE OF bt-retira IN FRAME FRAME-A
DO:
    DO WITH FRAME FRAME-A:
       FIND CURRENT tt-indicadoresSelec EXCLUSIVE-LOCK NO-ERROR.
       IF AVAIL tt-indicadoresSelec THEN DO:

           CREATE tt-indicadoresDisp.
           BUFFER-COPY tt-indicadoresSelec TO tt-indicadoresDisp.

           DELETE tt-indicadoresSelec.   
       END.

       RUN p-manipulaBrowse.

       {&OPEN-QUERY-br-indicadoresDisp} 
       {&OPEN-QUERY-br-indicadoresSelec}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-retiraTodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-retiraTodos wWin
ON CHOOSE OF bt-retiraTodos IN FRAME FRAME-A
DO:
    DO WITH FRAME FRAME-A:
       FOR EACH tt-indicadoresSelec EXCLUSIVE-LOCK.

           CREATE tt-indicadoresDisp.
           BUFFER-COPY tt-indicadoresSelec TO tt-indicadoresDisp.

           DELETE tt-indicadoresSelec.   
       END.

       RUN p-manipulaBrowse.

       {&OPEN-QUERY-br-indicadoresDisp} 
       {&OPEN-QUERY-br-indicadoresSelec}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-seleciona
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-seleciona wWin
ON CHOOSE OF bt-seleciona IN FRAME FRAME-A
DO:
    DO WITH FRAME FRAME-A:
       FIND CURRENT tt-indicadoresDisp EXCLUSIVE-LOCK NO-ERROR.
       IF AVAIL tt-indicadoresDisp THEN DO:

           CREATE tt-indicadoresSelec.
           BUFFER-COPY tt-indicadoresDisp TO tt-indicadoresSelec.

           DELETE tt-indicadoresDisp.   
       END.

       RUN p-manipulaBrowse.

       {&OPEN-QUERY-br-indicadoresDisp} 
       {&OPEN-QUERY-br-indicadoresSelec}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-selecionaTodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-selecionaTodos wWin
ON CHOOSE OF bt-selecionaTodos IN FRAME FRAME-A
DO:
    DO WITH FRAME FRAME-A:
       FOR EACH tt-indicadoresDisp EXCLUSIVE-LOCK.

           CREATE tt-indicadoresSelec.
           BUFFER-COPY tt-indicadoresDisp TO tt-indicadoresSelec.

           DELETE tt-indicadoresDisp.   
       END.

       RUN p-manipulaBrowse.

       {&OPEN-QUERY-br-indicadoresDisp} 
       {&OPEN-QUERY-br-indicadoresSelec}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&Scoped-define SELF-NAME bt-totais
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-totais wWin
ON CHOOSE OF bt-totais IN FRAME fMain /* Totais */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN vc-frame = "TOTAIS".

        RUN pFrames.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-venda wWin
ON CHOOSE OF bt-venda IN FRAME fMain /* Vendas */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        ASSIGN vc-frame = "VENDA".

        RUN pFrames.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-compra
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
  DISPLAY FILL-IN-3 FILL-IN-4 FILL-IN-5 FILL-IN-6 FILL-IN-7 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE bt-totais bt-compra bt-venda bt-desconto bt-estoque Btn_Cancel 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  DISPLAY fil-mesTotais fil-anoTotais 
      WITH FRAME FRAME-A IN WINDOW wWin.
  ENABLE RECT-9 bt-filtroTotais bt-imprimeTotais fil-mesTotais fil-anoTotais 
         br-indicadoresDisp br-indicadoresSelec bt-selecionaTodos bt-seleciona 
         bt-retira bt-retiraTodos br-totais 
      WITH FRAME FRAME-A IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
  DISPLAY fil-mesCompra fil-anoCompra 
      WITH FRAME FRAME-B IN WINDOW wWin.
  ENABLE RECT-8 bt-filtroCompra fil-mesCompra fil-anoCompra br-compra 
      WITH FRAME FRAME-B IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-B}
  DISPLAY fil-mesVenda fil-anoVenda 
      WITH FRAME FRAME-C IN WINDOW wWin.
  ENABLE RECT-10 bt-filtroVenda fil-mesVenda fil-anoVenda br-venda 
      WITH FRAME FRAME-C IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-C}
  DISPLAY fil-mesDesconto fil-anoDesconto 
      WITH FRAME FRAME-D IN WINDOW wWin.
  ENABLE RECT-11 bt-filtroDesconto fil-mesDesconto fil-anoDesconto br-desconto 
      WITH FRAME FRAME-D IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-D}
  DISPLAY fil-mesEstoque fil-anoEstoque 
      WITH FRAME FRAME-E IN WINDOW wWin.
  ENABLE RECT-12 bt-filtroEstoque fil-mesEstoque fil-anoEstoque br-estoque 
      WITH FRAME FRAME-E IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-E}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-filtroCompra wWin 
PROCEDURE p-filtroCompra :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-B:
    EMPTY TEMP-TABLE tt-compra.

    FOR EACH compra WHERE
             compra.usuario-id = vsi-usr-id NO-LOCK.

        IF MONTH(compra.compra-data) = INPUT fil-mesCompra AND
           YEAR(compra.compra-data)  = INPUT fil-anoCompra THEN.
        ELSE
            NEXT.

        FOR EACH compraProduto WHERE
                 compraProduto.usuario-id = vsi-usr-id AND
                 compraProduto.compra-id  = compra.compra-id NO-LOCK.

            CREATE tt-compra.
            BUFFER-COPY compraProduto TO tt-compra.
            ASSIGN tt-compra.compra-data = compra.compra-data
                   tt-compra.compra-hora = compra.compra-hora
                   tt-compra.nf = IF (compra.compra-notafiscal <> "" AND compra.compra-notafiscal <> ?) THEN YES ELSE NO
                   tt-compra.compra-notafiscal = compra.compra-notafiscal.

            FIND FIRST produto WHERE                                                                                                                                                              
                       produto.usuario-id = vsi-usr-id AND                                                                                                                                        
                       produto.produto-id = compraProduto.produto-id NO-LOCK NO-ERROR.                                                                                                           
            IF AVAIL produto AND    
               produto.produto-dataAlt <= compra.compra-data THEN                                                                                                                                                                                                                                                  
                ASSIGN tt-compra.produto-nome = produto.produto-nome.                                                                                                                                                                                                                                                                                                                       
            ELSE DO:                                                                                                                                                                                 
                                                                                                                                                                                                     
                FIND LAST histProduto WHERE                                                                                                                                                          
                          histProduto.usuario-id = vsi-usr-id AND                                                                                                                                    
                          histProduto.produto-id = compraProduto.produto-id AND                                                                                                                     
                          histProduto.histproduto-dataAlt <= compra.compra-data NO-LOCK NO-ERROR.                
                IF AVAIL histProduto THEN                                                                                                                                                                                                                                                                                                                                                            
                    ASSIGN tt-compra.produto-nome = histProduto.histProduto-nome.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
            END.                                                                                                                                                                                     
                                                                                                                                                                                                     
            RELEASE tt-compra.                                                                                                                                                                      
            RELEASE produto.                                                                                                                                                                         
            RELEASE histProduto.                                                                                                                                                                                                                                                                                                                                      
        END.
    END.

    {&OPEN-QUERY-br-compra}               
                                           
    FIND FIRST tt-compra NO-LOCK NO-ERROR.
    IF AVAIL tt-compra THEN               
        ENABLE bt-imprimeCompra.          
    ELSE                                   
        DISABLE bt-imprimeCompra.    

    APPLY "VALUE-CHANGED" TO br-compra.
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
    EMPTY TEMP-TABLE tt-desconto.

    FOR EACH desconto WHERE
             desconto.usuario-id  = vsi-usr-id NO-LOCK.

        IF INPUT fil-mesDesconto = 12 THEN DO:
            IF desconto.desconto-dataIni <= DATE(1,1,INPUT fil-anoDesconto + 1) - 1 AND  
               desconto.desconto-dataFim >= DATE(INPUT fil-mesDesconto,1,INPUT fil-anoDesconto) THEN.
            ELSE NEXT.  
        END.
        ELSE DO:
            IF desconto.desconto-dataIni <= DATE(INPUT fil-mesDesconto + 1,1,INPUT fil-anoDesconto) - 1 AND            
               desconto.desconto-dataFim >= DATE(INPUT fil-mesDesconto,1,INPUT fil-anoDesconto) THEN.
            ELSE NEXT.                                                                               
        END.

        FOR EACH descontoProduto WHERE
                 descontoProduto.usuario-id  = vsi-usr-id AND
                 descontoProduto.desconto-id = desconto.desconto-id NO-LOCK.

            CREATE tt-desconto.
            BUFFER-COPY descontoProduto TO tt-desconto
            ASSIGN tt-desconto.desconto-dataIni = desconto.desconto-dataIni
                   tt-desconto.desconto-dataFim = desconto.desconto-dataFim
                   tt-desconto.produto-nome = "".

            FIND FIRST produto WHERE                                                                                                                                                                 
                       produto.usuario-id = vsi-usr-id AND                                                                                                                                           
                       produto.produto-id = descontoProduto.produto-id NO-LOCK NO-ERROR.                                                                                                              
            IF AVAIL produto AND                                                                                                                                                                     
               produto.produto-dataAlt <= desconto.desconto-dataIni THEN DO:                                                    
                                                                                                                                                                                                     
                ASSIGN tt-desconto.produto-nome = produto.produto-nome                                                                                                                                
                       tt-desconto.categoria-id = produto.categoria-id                                                                                                                                
                       tt-desconto.categoria-descricao = "".                                                                                                                                          
                                                                                                                                                                                                     
                FIND FIRST categoria WHERE                                                                                                                                                           
                           categoria.usuario-id   = vsi-usr-id AND                                                                                                                                   
                           categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.                                                                                                           
                IF AVAIL categoria AND                                                                                                                                                               
                   categoria.categoria-dataAlt <= desconto.desconto-dataIni THEN                                            
                    ASSIGN tt-desconto.categoria-descricao = categoria.categoria-descricao.                                                                                                           
                ELSE DO:                                                                                                                                                                             
                                                                                                                                                                                                     
                    FIND LAST histCategoria WHERE                                                                                                                                                    
                              histCategoria.usuario-id = vsi-usr-id AND                                                                                                                              
                              histCategoria.categoria-id = produto.categoria-id AND                                                                                                                  
                              histCategoria.histcategoria-dataAlt <= desconto.desconto-dataIni NO-LOCK NO-ERROR.    
                    IF AVAIL histCategoria THEN                                                                                                                                                      
                        ASSIGN tt-desconto.categoria-descricao = histCategoria.histcategoria-descricao.                                                                                               
                END. 

                IF tt-desconto.categoria-descricao = "" THEN DO:

                    FIND FIRST categoria WHERE                                                
                               categoria.usuario-id   = vsi-usr-id AND                        
                               categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.
                    IF AVAIL categoria THEN                                            
                        ASSIGN tt-desconto.categoria-descricao = categoria.categoria-descricao.                                                    
                END.
            END.                                                                                                                                                                                     
            ELSE DO:                                                                                                                                                                                 
                                                                                                                                                                                                     
                FIND LAST histProduto WHERE                                                                                                                                                          
                          histProduto.usuario-id = vsi-usr-id AND                                                                                                                                    
                          histProduto.produto-id = descontoProduto.produto-id AND                                                                                                                     
                          histProduto.histproduto-dataAlt <= desconto.desconto-dataIni NO-LOCK NO-ERROR.                
                IF AVAIL histProduto THEN DO:                                                                                                                                                        
                                                                                                                                                                                                     
                    ASSIGN tt-desconto.produto-nome = histProduto.histProduto-nome                                                                                                                    
                           tt-desconto.categoria-id = histProduto.categoria-id                                                                                                                        
                           tt-desconto.categoria-descricao = "".                                                                                                                                      
                                                                                                                                                                                                     
                    FIND FIRST categoria WHERE                                                                                                                                                       
                               categoria.usuario-id   = vsi-usr-id AND                                                                                                                               
                               categoria.categoria-id = histProduto.categoria-id NO-LOCK NO-ERROR.                                                                                                   
                    IF AVAIL categoria AND                                                                                                                                                           
                       categoria.categoria-dataAlt <= desconto.desconto-dataIni THEN                                        
                        ASSIGN tt-desconto.categoria-descricao = categoria.categoria-descricao.                                                                                                       
                    ELSE DO:                                                                                                                                                                         
                                                                                                                                                                                                     
                        FIND LAST histCategoria WHERE                                                                                                                                                
                                  histCategoria.usuario-id = vsi-usr-id AND                                                                                                                          
                                  histCategoria.categoria-id = histProduto.categoria-id AND                                                                                                          
                                  histCategoria.histcategoria-dataAlt <= desconto.desconto-dataIni NO-LOCK NO-ERROR.
                        IF AVAIL histCategoria THEN                                                                                                                                                  
                            ASSIGN tt-desconto.categoria-descricao = histCategoria.histcategoria-descricao.                                                                                           
                    END.  

                    IF tt-desconto.categoria-descricao = "" THEN DO:                               
                                                                                                   
                        FIND FIRST categoria WHERE                                                 
                                   categoria.usuario-id   = vsi-usr-id AND                         
                                   categoria.categoria-id = histProduto.categoria-id NO-LOCK NO-ERROR. 
                        IF AVAIL categoria THEN                                                    
                            ASSIGN tt-desconto.categoria-descricao = categoria.categoria-descricao.
                    END.                                                                           
                END.                                                                                                                                                                                 
            END.                                                                                                                                                                                     

            IF tt-desconto.produto-nome = "" THEN DO:

                FIND FIRST produto WHERE                                                    
                           produto.usuario-id = vsi-usr-id AND                              
                           produto.produto-id = descontoProduto.produto-id NO-LOCK NO-ERROR.
                IF AVAIL produto THEN DO:

                    ASSIGN tt-desconto.produto-nome = produto.produto-nome
                           tt-desconto.categoria-id = produto.categoria-id
                           tt-desconto.categoria-descricao = "".   

                    FIND FIRST categoria WHERE                                                                      
                               categoria.usuario-id   = vsi-usr-id AND                                              
                               categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.                      
                    IF AVAIL categoria AND                                                                          
                       categoria.categoria-dataAlt <= desconto.desconto-dataIni THEN                                
                        ASSIGN tt-desconto.categoria-descricao = categoria.categoria-descricao.                     
                    ELSE DO:                                                                                        
                                                                                                                    
                        FIND LAST histCategoria WHERE                                                               
                                  histCategoria.usuario-id = vsi-usr-id AND                                         
                                  histCategoria.categoria-id = produto.categoria-id AND                             
                                  histCategoria.histcategoria-dataAlt <= desconto.desconto-dataIni NO-LOCK NO-ERROR.
                        IF AVAIL histCategoria THEN                                                                 
                            ASSIGN tt-desconto.categoria-descricao = histCategoria.histcategoria-descricao.         
                    END.                                                                                            
                                                                                                                    
                    IF tt-desconto.categoria-descricao = "" THEN DO:                                                
                                                                                                                    
                        FIND FIRST categoria WHERE                                                                  
                                   categoria.usuario-id   = vsi-usr-id AND                                          
                                   categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.                  
                        IF AVAIL categoria THEN                                                                     
                            ASSIGN tt-desconto.categoria-descricao = categoria.categoria-descricao.                 
                    END.                                                                                            
                END.
            END.

            RELEASE tt-desconto.
            RELEASE produto.
            RELEASE histProduto.
            RELEASE categoria.
            RELEASE histCategoria.
        END.
    END.

    {&OPEN-QUERY-br-desconto}               
                                         
    FIND FIRST tt-desconto NO-LOCK NO-ERROR.
    IF AVAIL tt-desconto THEN               
        ENABLE bt-imprimeDesconto.          
    ELSE                                 
        DISABLE bt-imprimeDesconto.         
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-filtroEstoque wWin 
PROCEDURE p-filtroEstoque :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-E:
    EMPTY TEMP-TABLE tt-estoque.

    FIND LAST estoque WHERE
              estoque.usuario-id  = vsi-usr-id AND
              estoque.estoque-mes = INPUT fil-mesEstoque AND
              estoque.estoque-ano = INPUT fil-anoEstoque NO-LOCK NO-ERROR.
    IF AVAIL estoque THEN DO:

        FOR EACH estoqueProduto WHERE
                 estoqueProduto.usuario-id = vsi-usr-id AND
                 estoqueProduto.estoque-id = estoque.estoque-id NO-LOCK.

            CREATE tt-estoque.
            BUFFER-COPY estoqueProduto TO tt-estoque.
            ASSIGN tt-estoque.mes = estoque.estoque-mes
                   tt-estoque.ano = estoque.estoque-ano.

            FIND FIRST produto WHERE
                       produto.usuario-id = vsi-usr-id AND
                       produto.produto-id = estoqueProduto.produto-id NO-LOCK NO-ERROR.
            IF AVAIL produto AND
               DATE(MONTH(produto.produto-dataAlt),1,YEAR(produto.produto-dataAlt)) <= DATE(INPUT fil-mesEstoque,1,INPUT fil-anoEstoque) THEN DO:

                ASSIGN tt-estoque.produto-nome = produto.produto-nome
                       tt-estoque.categoria-id = produto.categoria-id
                       tt-estoque.categoria-descricao = "".

                FIND FIRST categoria WHERE
                           categoria.usuario-id   = vsi-usr-id AND
                           categoria.categoria-id = produto.categoria-id NO-LOCK NO-ERROR.
                IF AVAIL categoria AND
                   DATE(MONTH(categoria.categoria-dataAlt),1,YEAR(categoria.categoria-dataAlt)) <= DATE(INPUT fil-mesEstoque,1,INPUT fil-anoEstoque) THEN
                    ASSIGN tt-estoque.categoria-descricao = categoria.categoria-descricao.
                ELSE DO:

                    FIND LAST histCategoria WHERE
                              histCategoria.usuario-id = vsi-usr-id AND
                              histCategoria.categoria-id = produto.categoria-id AND
                              DATE(MONTH(histCategoria.histcategoria-dataAlt),1,YEAR(histCategoria.histcategoria-dataAlt)) <= DATE(INPUT fil-mesEstoque,1,INPUT fil-anoEstoque) NO-LOCK NO-ERROR.
                    IF AVAIL histCategoria THEN
                        ASSIGN tt-estoque.categoria-descricao = histCategoria.histcategoria-descricao.
                END.
            END.
            ELSE DO:

                FIND LAST histProduto WHERE 
                          histProduto.usuario-id = vsi-usr-id AND
                          histProduto.produto-id = estoqueProduto.produto-id AND
                          DATE(MONTH(histProduto.histproduto-dataAlt),1,YEAR(histProduto.histproduto-dataAlt)) <= DATE(INPUT fil-mesEstoque,1,INPUT fil-anoEstoque) NO-LOCK NO-ERROR.
                IF AVAIL histProduto THEN DO:

                    ASSIGN tt-estoque.produto-nome = histProduto.histProduto-nome                                                                                                                            
                           tt-estoque.categoria-id = histProduto.categoria-id                                                                                                                            
                           tt-estoque.categoria-descricao = "".                                                                                                                                      
                                                                                                                                                                                                     
                    FIND FIRST categoria WHERE                                                                                                                                                       
                               categoria.usuario-id   = vsi-usr-id AND                                                                                                                               
                               categoria.categoria-id = histProduto.categoria-id NO-LOCK NO-ERROR.                                                                                                       
                    IF AVAIL categoria AND                                                                                                                                                           
                       DATE(MONTH(categoria.categoria-dataAlt),1,YEAR(categoria.categoria-dataAlt)) <= DATE(INPUT fil-mesEstoque,1,INPUT fil-anoEstoque) THEN                                                
                        ASSIGN tt-estoque.categoria-descricao = categoria.categoria-descricao.                                                                                                       
                    ELSE DO:                                                                                                                                                                         
                                                                                                                                                                                                     
                        FIND LAST histCategoria WHERE                                                                                                                                                
                                  histCategoria.usuario-id = vsi-usr-id AND                                                                                                                          
                                  histCategoria.categoria-id = histProduto.categoria-id AND                                                                                                              
                                  DATE(MONTH(histCategoria.histcategoria-dataAlt),1,YEAR(histCategoria.histcategoria-dataAlt)) <= DATE(INPUT fil-mesEstoque,1,INPUT fil-anoEstoque) NO-LOCK NO-ERROR.
                        IF AVAIL histCategoria THEN                                                                                                                                                  
                            ASSIGN tt-estoque.categoria-descricao = histCategoria.histcategoria-descricao.                                                                                           
                    END.                                                                                                                                                                             
                END.
            END.

            RELEASE tt-estoque.
            RELEASE produto.
            RELEASE histProduto.
            RELEASE categoria.
            RELEASE histCategoria.
        END.
    END.

    {&OPEN-QUERY-br-estoque}

    FIND FIRST tt-estoque NO-LOCK NO-ERROR.
    IF AVAIL tt-estoque THEN
        ENABLE bt-imprimeEstoque.
    ELSE
        DISABLE bt-imprimeEstoque.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-filtroTotais wWin 
PROCEDURE p-filtroTotais :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:
    EMPTY TEMP-TABLE tt-totais.
    EMPTY TEMP-TABLE tt-InfoVendaProduto.

    ASSIGN dTotVendas         = 0
           dTotCompras        = 0
           iNumVendas         = 0
           iQtdProdVendas     = 0
           iTamanhoEstoque    = 0
           iTamanhoEstoqueAnt = 0.

    FIND FIRST tt-indicadoresSelec NO-LOCK NO-ERROR.
    IF AVAIL tt-indicadoresSelec THEN DO:

        FOR EACH venda WHERE venda.usuario-id = vsi-usr-id NO-LOCK.  

            IF MONTH(venda.venda-data) = INPUT fil-mesTotais AND YEAR(venda.venda-data)  = INPUT fil-anoTotais THEN.
            ELSE NEXT. 

            ASSIGN iNumVendas = iNumVendas + 1.

            FOR EACH vendaProduto WHERE vendaProduto.usuario-id = vsi-usr-id AND         
                                        vendaProduto.venda-id   = venda.venda-id NO-LOCK.

                ASSIGN dTotVendas     = dTotVendas + vendaProduto.vendaproduto-valorTotal
                       iQtdProdVendas = iQtdProdVendas + vendaProduto.vendaproduto-quantidade.

                FIND FIRST produto WHERE produto.usuario-id = vsi-usr-id AND
                                         produto.produto-id = vendaProduto.produto-id NO-LOCK NO-ERROR.
                IF AVAIL produto THEN DO:

                    FIND FIRST tt-InfoVendaProduto WHERE tt-InfoVendaProduto.produto-id = produto.produto-id NO-LOCK NO-ERROR.
                    IF NOT AVAIL tt-InfoVendaProduto THEN DO:

                        CREATE tt-InfoVendaProduto.
                        ASSIGN tt-InfoVendaProduto.produto-id   = produto.produto-id
                               tt-InfoVendaProduto.produto-nome = produto.produto-nome
                               tt-InfoVendaProduto.quantidade   = 0
                               tt-InfoVendaProduto.valorTot     = 0
                               tt-InfoVendaProduto.custo        = 0.
                    END.

                    ASSIGN tt-InfoVendaProduto.quantidade = tt-InfoVendaProduto.quantidade + vendaProduto.vendaproduto-quantidade
                           tt-InfoVendaProduto.valorTot   = tt-InfoVendaProduto.valorTot + vendaproduto-valorTotal
                           tt-InfoVendaProduto.custo      = tt-InfoVendaProduto.custo + (produto.produto-valor * vendaProduto.vendaproduto-quantidade).
                END.
            END.
        END.

        FOR EACH compra WHERE compra.usuario-id = vsi-usr-id NO-LOCK. 

            IF MONTH(compra.compra-data) = INPUT fil-mesTotais AND YEAR(compra.compra-data)  = INPUT fil-anoTotais THEN.
            ELSE NEXT. 

            FOR EACH compraProduto WHERE compraProduto.usuario-id = vsi-usr-id AND           
                                         compraProduto.compra-id  = compra.compra-id NO-LOCK.

                ASSIGN dTotCompras = dTotCompras + compraProduto.compraproduto-valorTotal.
            END.
        END.

        FIND LAST estoque WHERE estoque.usuario-id  = vsi-usr-id AND                        
                                estoque.estoque-mes = INPUT fil-mesTotais AND              
                                estoque.estoque-ano = INPUT fil-anoTotais NO-LOCK NO-ERROR.
        IF AVAIL estoque THEN DO: 

            FOR EACH estoqueProduto WHERE estoqueProduto.usuario-id = vsi-usr-id AND             
                                          estoqueProduto.estoque-id = estoque.estoque-id NO-LOCK.

                ASSIGN iTamanhoEstoque = iTamanhoEstoque + estoqueProduto.estoqueproduto-quantidade.
            END.
        END.

        IF INPUT fil-mesTotais = 1 THEN DO:

            FIND LAST estoque WHERE estoque.usuario-id  = vsi-usr-id AND                                
                                    estoque.estoque-mes = 12 AND                      
                                    estoque.estoque-ano = (INPUT fil-anoTotais) - 1 NO-LOCK NO-ERROR.        
            IF AVAIL estoque THEN DO:                                                                   
                                                                                                        
                FOR EACH estoqueProduto WHERE estoqueProduto.usuario-id = vsi-usr-id AND                
                                              estoqueProduto.estoque-id = estoque.estoque-id NO-LOCK.   
                                                                                                        
                    ASSIGN iTamanhoEstoqueAnt = iTamanhoEstoqueAnt + estoqueProduto.estoqueproduto-quantidade.
                END.  
            END.                                                                                        
        END.
        ELSE DO:

            FIND LAST estoque WHERE estoque.usuario-id  = vsi-usr-id AND                                
                                    estoque.estoque-mes = (INPUT fil-mesTotais) - 1 AND                      
                                    estoque.estoque-ano = INPUT fil-anoTotais NO-LOCK NO-ERROR.        
            IF AVAIL estoque THEN DO:                                                                   
                                                                                                        
                FOR EACH estoqueProduto WHERE estoqueProduto.usuario-id = vsi-usr-id AND                
                                              estoqueProduto.estoque-id = estoque.estoque-id NO-LOCK.   
                                                                                                        
                    ASSIGN iTamanhoEstoqueAnt = iTamanhoEstoqueAnt + estoqueProduto.estoqueproduto-quantidade.
                END.                                                                                    
            END.                                                                                        
        END.

        RUN p-totais.

        {&OPEN-QUERY-br-totais}
        ENABLE bt-imprimeTotais.
    END.
    ELSE DO:

        {&OPEN-QUERY-br-totais}
        DISABLE bt-imprimeTotais.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-filtroVenda wWin 
PROCEDURE p-filtroVenda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-C:
    EMPTY TEMP-TABLE tt-venda.

    FOR EACH venda WHERE                                                                                               
             venda.usuario-id = vsi-usr-id NO-LOCK.                                                                    
                                                                                                                        
        IF MONTH(venda.venda-data) = INPUT fil-mesVenda AND                                                          
           YEAR(venda.venda-data)  = INPUT fil-anoVenda THEN.                                                        
        ELSE                                                                                                            
            NEXT.                                                                                                       
                                                                                                                        
        FOR EACH vendaProduto WHERE                                                                                    
                 vendaProduto.usuario-id = vsi-usr-id AND                                                              
                 vendaProduto.venda-id   = venda.venda-id NO-LOCK.                                                   
                                                                                                                        
            CREATE tt-venda.                                                                                           
            BUFFER-COPY vendaProduto TO tt-venda.                                                                     
            ASSIGN tt-venda.venda-data = venda.venda-data                                                           
                   tt-venda.venda-hora = venda.venda-hora                                                           
                   tt-venda.nf = IF (venda.venda-notafiscal <> "" AND venda.venda-notafiscal <> ?) THEN YES ELSE NO
                   tt-venda.venda-notafiscal = venda.venda-notafiscal
                   tt-venda.desconto = 0.
                                                                                                                        
            FIND FIRST produto WHERE                                                                                    
                       produto.usuario-id = vsi-usr-id AND                                                              
                       produto.produto-id = vendaProduto.produto-id NO-LOCK NO-ERROR.                                  
            IF AVAIL produto AND                                                                                        
               produto.produto-dataAlt <= venda.venda-data THEN                                                       
                ASSIGN tt-venda.produto-nome = produto.produto-nome.                                                   
            ELSE DO:                                                                                                    
                                                                                                                        
                FIND LAST histProduto WHERE                                                                             
                          histProduto.usuario-id = vsi-usr-id AND                                                       
                          histProduto.produto-id = vendaProduto.produto-id AND                                         
                          histProduto.histproduto-dataAlt <= venda.venda-data NO-LOCK NO-ERROR.                       
                IF AVAIL histProduto THEN                                                                               
                    ASSIGN tt-venda.produto-nome = histProduto.histProduto-nome.                                       
            END.   

            FOR EACH desconto WHERE
                     desconto.usuario-id = vsi-usr-id and
                     desconto.desconto-dataIni <= venda.venda-data AND
                     desconto.desconto-dataFim >= venda.venda-data NO-LOCK.

                FIND FIRST descontoProduto WHERE
                           descontoProduto.usuario-id  = vsi-usr-id AND
                           descontoProduto.desconto-id = desconto.desconto-id AND
                           descontoProduto.produto-id  = vendaProduto.venda-id NO-LOCK NO-ERROR.
                IF AVAIL descontoProduto THEN
                    ASSIGN tt-venda.desconto = descontoproduto-valor.
            END.
                                                                                                                        
            RELEASE tt-venda.                                                                                          
            RELEASE produto.                                                                                            
            RELEASE histProduto.  
            RELEASE descontoProduto.
        END.                                                                                                            
    END.                                                                                                                
                                                                                                                        
    {&OPEN-QUERY-br-venda}                                                                                             
                                                                                                                        
    FIND FIRST tt-venda NO-LOCK NO-ERROR.                                                                              
    IF AVAIL tt-venda THEN                                                                                             
        ENABLE bt-imprimeVenda.                                                                                        
    ELSE                                                                                                                
        DISABLE bt-imprimeVenda.   

    APPLY "VALUE-CHANGED" TO br-venda.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-imprimeCompra wWin 
PROCEDURE p-imprimeCompra :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-B:  
    /* Excel COM */
    DEFINE VARIABLE hExcel AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hBook  AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hSheet AS COM-HANDLE NO-UNDO.
    
    /* Controle de linhas e agrupamento */
    DEFINE VARIABLE iRow     AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iLastID  AS INTEGER   NO-UNDO INITIAL ?.
    
    /* 1) Abre Excel */
    CREATE "Excel.Application" hExcel NO-ERROR.
    IF NOT VALID-HANDLE(hExcel) THEN DO:
      MESSAGE "Excel não disponível nesta máquina." VIEW-AS ALERT-BOX ERROR.
      RETURN.
    END.
    hBook  = hExcel:Workbooks:Add().
    hSheet = hBook:Sheets:Item(1).
    hSheet:Name = "Compras".
    
    /* 2) Cabeçalho */
    hSheet:Cells(1, 1):Value = "Data".
    hSheet:Cells(1, 2):Value = "Hora".
    hSheet:Cells(1, 3):Value = "ID".
    hSheet:Cells(1, 4):Value = "Produto".
    hSheet:Cells(1, 5):Value = "Qtd.".
    hSheet:Cells(1, 6):Value = "Valor Uni.".
    hSheet:Cells(1, 7):Value = "Valor Total".
    hSheet:Cells(1, 8):Value = "Nota Fiscal?".
    
    /* 3) Dados — agrupar por compra-id (sem exibir compra-id) */
    iRow = 2.
    
    FOR EACH bf-tt-compra NO-LOCK
        BY bf-tt-compra.compra-id
        BY bf-tt-compra.produto-id:
    
      IF iLastID <> bf-tt-compra.compra-id THEN DO:
        hSheet:Cells(iRow, 1):Value = STRING(bf-tt-compra.compra-data, "99/99/9999").
        hSheet:Cells(iRow, 2):Value = STRING(bf-tt-compra.compra-hora, "HH:MM:SS").
        iLastID = bf-tt-compra.compra-id.
      END.
      ELSE DO:
        hSheet:Cells(iRow, 1):Value = "".
        hSheet:Cells(iRow, 2):Value = "".
      END.
    
      hSheet:Cells(iRow, 3):Value = bf-tt-compra.produto-id.
      hSheet:Cells(iRow, 4):Value = bf-tt-compra.produto-nome.
      hSheet:Cells(iRow, 5):Value = bf-tt-compra.compraproduto-quantidade.
      hSheet:Cells(iRow, 6):Value = string(bf-tt-compra.compraproduto-valorUnidade,">>>>>9.99").
      hSheet:Cells(iRow, 7):Value = string(bf-tt-compra.compraproduto-valorTotal,">>>>>9.99").
      hSheet:Cells(iRow, 8):Value = (IF bf-tt-compra.nf THEN "Sim" ELSE "Não").
    
      iRow = iRow + 1.
    END.
    
    /* 4) Aparência */
    /* Mostra o Excel e ativa a planilha antes de mexer no ActiveWindow */
    hExcel:Visible = TRUE NO-ERROR.
    hSheet:Activate NO-ERROR.
    
    /* Cabeçalho em negrito */
    hSheet:Rows:Item(1):Font:Bold = TRUE NO-ERROR.
    
    /* AutoFit nas colunas A..H */
    hSheet:Columns("A:H"):AutoFit NO-ERROR.

    hSheet:Range("A2:A" + STRING(iRow)):NumberFormat = "mm/dd/yyyy" NO-ERROR.
    hSheet:Range("F2:F" + STRING(iRow)):NumberFormat = "#,##0.00" NO-ERROR.   
    hSheet:Range("G2:G" + STRING(iRow)):NumberFormat = "#,##0.00" NO-ERROR.  
    
    /* Mantém o Excel aberto para o usuário */
    RELEASE OBJECT hSheet NO-ERROR.
    RELEASE OBJECT hBook  NO-ERROR.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-imprimeDesconto wWin 
PROCEDURE p-imprimeDesconto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-D:  
    /* Excel COM */
    DEFINE VARIABLE hExcel AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hBook  AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hSheet AS COM-HANDLE NO-UNDO.
    
    /* Controle de linhas e agrupamento */
    DEFINE VARIABLE iRow     AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iLastID  AS INTEGER   NO-UNDO INITIAL ?.
    
    /* 1) Abre Excel */
    CREATE "Excel.Application" hExcel NO-ERROR.
    IF NOT VALID-HANDLE(hExcel) THEN DO:
      MESSAGE "Excel não disponível nesta máquina." VIEW-AS ALERT-BOX ERROR.
      RETURN.
    END.
    hBook  = hExcel:Workbooks:Add().
    hSheet = hBook:Sheets:Item(1).
    hSheet:Name = "Descontos".
    
    /* 2) Cabeçalho */
    hSheet:Cells(1, 1):Value = "Data Inicio".
    hSheet:Cells(1, 2):Value = "Hora Fim".
    hSheet:Cells(1, 3):Value = "Desconto".
    hSheet:Cells(1, 4):Value = "ID".
    hSheet:Cells(1, 5):Value = "Produto".
    hSheet:Cells(1, 6):Value = "ID".
    hSheet:Cells(1, 7):Value = "Categoria".
    
    /* 3) Dados — agrupar por compra-id (sem exibir compra-id) */
    iRow = 2.
    
    FOR EACH bf-tt-desconto NO-LOCK
        BY bf-tt-desconto.desconto-id
        BY bf-tt-desconto.produto-id:
    
      IF iLastID <> bf-tt-desconto.desconto-id THEN DO:
        hSheet:Cells(iRow, 1):Value = STRING(bf-tt-desconto.desconto-dataIni, "99/99/9999").
        hSheet:Cells(iRow, 2):Value = STRING(bf-tt-desconto.desconto-dataFim, "99/99/9999").
        iLastID = bf-tt-desconto.desconto-id.
      END.
      ELSE DO:
        hSheet:Cells(iRow, 1):Value = "".
        hSheet:Cells(iRow, 2):Value = "".
      END.

      hSheet:Cells(iRow, 3):Value = string(bf-tt-desconto.descontoproduto-valor,">>9%").
      hSheet:Cells(iRow, 4):Value = bf-tt-desconto.produto-id.  
      hSheet:Cells(iRow, 5):Value = bf-tt-desconto.produto-nome.
      hSheet:Cells(iRow, 6):Value = bf-tt-desconto.categoria-id.  
      hSheet:Cells(iRow, 7):Value = bf-tt-desconto.categoria-descricao.
    
      iRow = iRow + 1.
    END.
    
    /* 4) Aparência */
    /* Mostra o Excel e ativa a planilha antes de mexer no ActiveWindow */
    hExcel:Visible = TRUE NO-ERROR.
    hSheet:Activate NO-ERROR.
    
    /* Cabeçalho em negrito */
    hSheet:Rows:Item(1):Font:Bold = TRUE NO-ERROR.
    
    /* AutoFit nas colunas A..H */
    hSheet:Columns("A:G"):AutoFit NO-ERROR.

    hSheet:Range("A2:A" + STRING(iRow)):NumberFormat = "mm/dd/yyyy" NO-ERROR.
    hSheet:Range("B2:B" + STRING(iRow)):NumberFormat = "mm/dd/yyyy" NO-ERROR.
    
    /* Mantém o Excel aberto para o usuário */
    RELEASE OBJECT hSheet NO-ERROR.
    RELEASE OBJECT hBook  NO-ERROR.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-imprimeEstoque wWin 
PROCEDURE p-imprimeEstoque :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-E:  
    /* Excel COM */
    DEFINE VARIABLE hExcel AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hBook  AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hSheet AS COM-HANDLE NO-UNDO.
    
    /* Controle de linhas e agrupamento */
    DEFINE VARIABLE iRow     AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iLastID  AS INTEGER   NO-UNDO INITIAL ?.
    
    /* 1) Abre Excel */
    CREATE "Excel.Application" hExcel NO-ERROR.
    IF NOT VALID-HANDLE(hExcel) THEN DO:
      MESSAGE "Excel não disponível nesta máquina." VIEW-AS ALERT-BOX ERROR.
      RETURN.
    END.
    hBook  = hExcel:Workbooks:Add().
    hSheet = hBook:Sheets:Item(1).
    hSheet:Name = "Estoque".
    
    /* 2) Cabeçalho */
    hSheet:Cells(1, 1):Value = "Qtd.".
    hSheet:Cells(1, 2):Value = "ID".
    hSheet:Cells(1, 3):Value = "Produto".
    hSheet:Cells(1, 4):Value = "ID".       
    hSheet:Cells(1, 5):Value = "Categoria".
    
    /* 3) Dados — agrupar por compra-id (sem exibir compra-id) */
    iRow = 2.
    
    FOR EACH bf-tt-estoque NO-LOCK
        BY bf-tt-estoque.estoque-id:

      hSheet:Cells(iRow, 1):Value = bf-tt-estoque.estoqueproduto-quantidade.
      hSheet:Cells(iRow, 2):Value = bf-tt-estoque.produto-id.  
      hSheet:Cells(iRow, 3):Value = bf-tt-estoque.produto-nome.
      hSheet:Cells(iRow, 4):Value = bf-tt-estoque.categoria-id.  
      hSheet:Cells(iRow, 5):Value = bf-tt-estoque.categoria-descricao.
    
      iRow = iRow + 1.
    END.
    
    /* 4) Aparência */
    /* Mostra o Excel e ativa a planilha antes de mexer no ActiveWindow */
    hExcel:Visible = TRUE NO-ERROR.
    hSheet:Activate NO-ERROR.
    
    /* Cabeçalho em negrito */
    hSheet:Rows:Item(1):Font:Bold = TRUE NO-ERROR.
    
    /* AutoFit nas colunas A..H */
    hSheet:Columns("A:E"):AutoFit NO-ERROR.
    
    /* Mantém o Excel aberto para o usuário */
    RELEASE OBJECT hSheet NO-ERROR.
    RELEASE OBJECT hBook  NO-ERROR.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-imprimeTotais wWin 
PROCEDURE p-imprimeTotais :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-E:  
    DEF VAR iAuxInd AS INT NO-UNDO.

    /* Excel COM */
    DEFINE VARIABLE hExcel AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hBook  AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hSheet AS COM-HANDLE NO-UNDO.
    
    /* Controle de linhas e agrupamento */
    DEFINE VARIABLE iRow     AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iLastID  AS INTEGER   NO-UNDO INITIAL ?.
    
    /* 1) Abre Excel */
    CREATE "Excel.Application" hExcel NO-ERROR.
    IF NOT VALID-HANDLE(hExcel) THEN DO:
      MESSAGE "Excel não disponível nesta máquina." VIEW-AS ALERT-BOX ERROR.
      RETURN.
    END.
    hBook  = hExcel:Workbooks:Add().
    hSheet = hBook:Sheets:Item(1).
    hSheet:Name = "Totais".

    iAuxInd = 0.

    /* 2) Cabeçalho */
    FOR EACH bf-tt-indicadoresSelec NO-LOCK.
        iAuxInd = iAuxInd + 1.
        hSheet:Cells(1, iAuxInd):Value = bf-tt-indicadoresSelec.nome.
    END.
    
    /* 3) Dados — agrupar por compra-id (sem exibir compra-id) */
    iRow = 2.
    iAuxInd = 0.
    
    FIND FIRST bf-tt-totais NO-LOCK NO-ERROR.
    IF AVAIL bf-tt-totais THEN DO:

      IF bf-tt-totais.ind1V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind1.

      IF bf-tt-totais.ind2V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind2.

      IF bf-tt-totais.ind3V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind3.

      IF bf-tt-totais.ind4V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind4. 

      IF bf-tt-totais.ind5V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind5.

      IF bf-tt-totais.ind6V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind6.

      IF bf-tt-totais.ind7V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind7.

      IF bf-tt-totais.ind8V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind8.

      IF bf-tt-totais.ind9V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value  = bf-tt-totais.ind9. 

      IF bf-tt-totais.ind10V THEN
         ASSIGN iAuxInd = iAuxInd + 1
                hSheet:Cells(iRow, iAuxInd):Value = bf-tt-totais.ind10.      
    END.
    
    /* 4) Aparência */
    /* Mostra o Excel e ativa a planilha antes de mexer no ActiveWindow */
    hExcel:Visible = TRUE NO-ERROR.
    hSheet:Activate NO-ERROR.
    
    /* Cabeçalho em negrito */
    hSheet:Rows:Item(1):Font:Bold = TRUE NO-ERROR.
    
    /* AutoFit nas colunas A..H */
    hSheet:Columns("A:J"):AutoFit NO-ERROR.
    
    /* Mantém o Excel aberto para o usuário */
    RELEASE OBJECT hSheet NO-ERROR.
    RELEASE OBJECT hBook  NO-ERROR.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-imprimeVenda wWin 
PROCEDURE p-imprimeVenda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-C:  
    /* Excel COM */
    DEFINE VARIABLE hExcel AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hBook  AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE hSheet AS COM-HANDLE NO-UNDO.
    
    /* Controle de linhas e agrupamento */
    DEFINE VARIABLE iRow     AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iLastID  AS INTEGER   NO-UNDO INITIAL ?.
    
    /* 1) Abre Excel */
    CREATE "Excel.Application" hExcel NO-ERROR.
    IF NOT VALID-HANDLE(hExcel) THEN DO:
      MESSAGE "Excel não disponível nesta máquina." VIEW-AS ALERT-BOX ERROR.
      RETURN.
    END.
    hBook  = hExcel:Workbooks:Add().
    hSheet = hBook:Sheets:Item(1).
    hSheet:Name = "Vendas".
    
    /* 2) Cabeçalho */
    hSheet:Cells(1, 1):Value = "Data".
    hSheet:Cells(1, 2):Value = "Hora".
    hSheet:Cells(1, 3):Value = "ID".
    hSheet:Cells(1, 4):Value = "Produto".
    hSheet:Cells(1, 5):Value = "Qtd.".
    hSheet:Cells(1, 6):Value = "Valor Uni.".
    hSheet:Cells(1, 7):Value = "Valor Total".
    hSheet:Cells(1, 8):Value = "Desconto".
    hSheet:Cells(1, 9):Value = "Nota Fiscal?".
    
    /* 3) Dados — agrupar por compra-id (sem exibir compra-id) */
    iRow = 2.
    
    FOR EACH bf-tt-venda NO-LOCK
        BY bf-tt-venda.venda-id
        BY bf-tt-venda.produto-id:
    
      IF iLastID <> bf-tt-venda.venda-id THEN DO:
        hSheet:Cells(iRow, 1):Value = STRING(bf-tt-venda.venda-data, "99/99/9999").
        hSheet:Cells(iRow, 2):Value = STRING(bf-tt-venda.venda-hora, "HH:MM:SS").
        iLastID = bf-tt-venda.venda-id.
      END.
      ELSE DO:
        hSheet:Cells(iRow, 1):Value = "".
        hSheet:Cells(iRow, 2):Value = "".
      END.
    
      hSheet:Cells(iRow, 3):Value = bf-tt-venda.produto-id.
      hSheet:Cells(iRow, 4):Value = bf-tt-venda.produto-nome.
      hSheet:Cells(iRow, 5):Value = bf-tt-venda.vendaproduto-quantidade.
      hSheet:Cells(iRow, 6):Value = string(bf-tt-venda.vendaproduto-valorUnidade,">>>>>9.99").
      hSheet:Cells(iRow, 7):Value = string(bf-tt-venda.vendaproduto-valorTotal,">>>>>9.99").
      hSheet:Cells(iRow, 8):Value = string(bf-tt-venda.desconto,">>9%").
      hSheet:Cells(iRow, 9):Value = (IF bf-tt-venda.nf THEN "Sim" ELSE "Não").
    
      iRow = iRow + 1.
    END.
    
    /* 4) Aparência */
    /* Mostra o Excel e ativa a planilha antes de mexer no ActiveWindow */
    hExcel:Visible = TRUE NO-ERROR.
    hSheet:Activate NO-ERROR.
    
    /* Cabeçalho em negrito */
    hSheet:Rows:Item(1):Font:Bold = TRUE NO-ERROR.
    
    /* AutoFit nas colunas A..H */
    hSheet:Columns("A:I"):AutoFit NO-ERROR.

    hSheet:Range("A2:A" + STRING(iRow)):NumberFormat = "mm/dd/yyyy" NO-ERROR.
    hSheet:Range("F2:F" + STRING(iRow)):NumberFormat = "#,##0.00" NO-ERROR.   
    hSheet:Range("G2:G" + STRING(iRow)):NumberFormat = "#,##0.00" NO-ERROR. 
    
    /* Mantém o Excel aberto para o usuário */
    RELEASE OBJECT hSheet NO-ERROR.
    RELEASE OBJECT hBook  NO-ERROR.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-indicadores wWin 
PROCEDURE p-indicadores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:

    CREATE tt-indicadoresDisp.
    ASSIGN tt-indicadoresDisp.id      = 1
           tt-indicadoresDisp.nome    = "Total de vendas".

    CREATE tt-indicadoresDisp.                           
    ASSIGN tt-indicadoresDisp.id      = 2                
           tt-indicadoresDisp.nome    = "Total de compras".  

    CREATE tt-indicadoresDisp.                            
    ASSIGN tt-indicadoresDisp.id      = 3                 
           tt-indicadoresDisp.nome    = "Lucro bruto".  

    CREATE tt-indicadoresDisp.                       
    ASSIGN tt-indicadoresDisp.id      = 4            
           tt-indicadoresDisp.nome    = "Ticket médio".  

    CREATE tt-indicadoresDisp.                        
    ASSIGN tt-indicadoresDisp.id      = 5             
           tt-indicadoresDisp.nome    = "Produto mais vendido".     

    CREATE tt-indicadoresDisp.                        
    ASSIGN tt-indicadoresDisp.id      = 6             
           tt-indicadoresDisp.nome    = "Produto mais lucrativo".      

    CREATE tt-indicadoresDisp.                                  
    ASSIGN tt-indicadoresDisp.id      = 7                       
           tt-indicadoresDisp.nome    = "Margem de lucro média".  

    CREATE tt-indicadoresDisp.                                 
    ASSIGN tt-indicadoresDisp.id      = 8                      
           tt-indicadoresDisp.nome    = "Estoque final".  

    CREATE tt-indicadoresDisp.                         
    ASSIGN tt-indicadoresDisp.id      = 9              
           tt-indicadoresDisp.nome    = "Giro de estoque".     

    CREATE tt-indicadoresDisp.                           
    ASSIGN tt-indicadoresDisp.id      = 10                
           tt-indicadoresDisp.nome    = "Índice de Cobertura de Estoque".              

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

    ASSIGN bt-retiraTodos:LABEL IN FRAME FRAME-A = ""
           bt-retira:LABEL IN FRAME FRAME-A = ""
           bt-selecionaTodos:LABEL IN FRAME FRAME-A = ""
           bt-seleciona:LABEL IN FRAME FRAME-A = ""
           NO-ERROR.

    bt-retiraTodos:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\setas-esquerda.png") IN FRAME FRAME-A.
    bt-retira:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\seta-esquerda.png") IN FRAME FRAME-A.
    bt-selecionaTodos:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\setas-direita.png") IN FRAME FRAME-A.
    bt-seleciona:LOAD-IMAGE("C:\Users\Totvs\Documents\Imagens\seta-direita.png") IN FRAME FRAME-A.

    APPLY "CHOOSE" TO bt-totais IN FRAME fMain.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leituraCompra wWin 
PROCEDURE p-leituraCompra :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-B:
    EMPTY TEMP-TABLE tt-compra.

    ASSIGN fil-mesCompra:SCREEN-VALUE = STRING(MONTH(TODAY))
           fil-anoCompra:SCREEN-VALUE = STRING(YEAR(TODAY)).

    APPLY "CHOOSE" TO bt-filtroCompra.
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
    EMPTY TEMP-TABLE tt-desconto.

    ASSIGN fil-mesDesconto:SCREEN-VALUE = STRING(MONTH(TODAY))
           fil-anoDesconto:SCREEN-VALUE = STRING(YEAR(TODAY)).

    APPLY "CHOOSE" TO bt-filtroDesconto.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leituraEstoque wWin 
PROCEDURE p-leituraEstoque :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-E:
    EMPTY TEMP-TABLE tt-estoque.

    ASSIGN fil-mesEstoque:SCREEN-VALUE = STRING(MONTH(TODAY))
           fil-anoEstoque:SCREEN-VALUE = STRING(YEAR(TODAY)).

    APPLY "CHOOSE" TO bt-filtroEstoque.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leituraTotais wWin 
PROCEDURE p-leituraTotais :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:
    EMPTY TEMP-TABLE tt-indicadoresDisp.
    EMPTY TEMP-TABLE tt-indicadoresSelec.
    EMPTY TEMP-TABLE tt-totais.
    EMPTY TEMP-TABLE tt-InfoVendaProduto.

    RUN p-indicadores.

    ASSIGN fil-mesTotais:SCREEN-VALUE = STRING(MONTH(TODAY))
           fil-anoTotais:SCREEN-VALUE = STRING(YEAR(TODAY)).

    RUN p-manipulaBrowse.

    {&OPEN-QUERY-br-indicadoresDisp} 
    {&OPEN-QUERY-br-indicadoresSelec}                                                                         
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-leituraVenda wWin 
PROCEDURE p-leituraVenda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-C:
    EMPTY TEMP-TABLE tt-venda.

    ASSIGN fil-mesVenda:SCREEN-VALUE = STRING(MONTH(TODAY))
           fil-anoVenda:SCREEN-VALUE = STRING(YEAR(TODAY)).

    APPLY "CHOOSE" TO bt-filtroVenda.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-manipulaBrowse wWin 
PROCEDURE p-manipulaBrowse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:
    DEF VAR hanCol as HANDLE NO-UNDO.
    DEF VAR iCol   AS INT    NO-UNDO.

    hanCol = BROWSE br-totais:FIRST-COLUMN NO-ERROR.
    iCol   = 1.
                     
    DO WHILE VALID-HANDLE(hanCol):

        FIND FIRST bf-tt-indicadoresSelec WHERE
                   bf-tt-indicadoresSelec.id = iCol NO-LOCK NO-ERROR.
        IF AVAIL bf-tt-indicadoresSelec THEN
            view hanCol.
        ELSE
            hide hanCol.  
                       
        iCol   = iCol + 1.
        hanCol = hanCol:NEXT-COLUMN NO-ERROR.                   
    end.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-nfCompra wWin 
PROCEDURE p-nfCompra :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-B:

    FIND CURRENT tt-compra NO-LOCK.
    IF AVAIL tt-compra THEN DO:

        IF SEARCH(tt-compra.compra-notafiscal) = ? THEN DO:
            MESSAGE "Imagem da Nota Fiscal não localizada."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
        END.
        ELSE DO:
            OS-COMMAND NO-WAIT VALUE('"' + tt-compra.compra-notafiscal + '"').
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-nfVenda wWin 
PROCEDURE p-nfVenda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-C:

    FIND CURRENT tt-venda NO-LOCK.
    IF AVAIL tt-venda THEN DO:

        IF SEARCH(tt-venda.venda-notafiscal) = ? THEN DO:
            MESSAGE "Imagem da Nota Fiscal não localizada."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
        END.
        ELSE DO:
            OS-COMMAND NO-WAIT VALUE('"' + tt-venda.venda-notafiscal + '"').
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-totais wWin 
PROCEDURE p-totais :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:
    DEF VAR dVlrAux AS DEC NO-UNDO.
    DEF VAR iQtdAux AS INT NO-UNDO.

    CREATE tt-totais.

    FOR EACH tt-indicadoresSelec NO-LOCK.

        IF tt-indicadoresSelec.id = 1 THEN DO:
            ASSIGN tt-totais.ind1  = STRING(dTotVendas,">>>>>9.99")
                   tt-totais.ind1V = YES.
        END.

        IF tt-indicadoresSelec.id = 2 THEN DO:                      
            ASSIGN tt-totais.ind2  = STRING(dTotCompras,">>>>>9.99") 
                   tt-totais.ind2V = YES.                           
        END.    

        IF tt-indicadoresSelec.id = 3 THEN DO:
            ASSIGN dVlrAux = 0.

            FOR EACH tt-InfoVendaProduto NO-LOCK.
                ASSIGN dVlrAux = dVlrAux + custo.
            END.

            ASSIGN dVlrAux         = dTotVendas - dVlrAux
                   tt-totais.ind3  = STRING(dVlrAux,">>>>>9.99")
                   tt-totais.ind3V = YES.                           
        END.

        IF tt-indicadoresSelec.id = 4 THEN DO:                   
            ASSIGN dVlrAux         = dTotVendas - iNumVendas        
                   tt-totais.ind4  = STRING(dVlrAux,">>>>>9.99") 
                   tt-totais.ind4V = YES.                        
        END.  

        IF tt-indicadoresSelec.id = 5 THEN DO:                  
            ASSIGN iQtdAux = 0.                                 
                                                                
            FOR EACH tt-InfoVendaProduto NO-LOCK.               
                IF tt-InfoVendaProduto.quantidade > iQtdAux THEN
                    ASSIGN iQtdAux         = tt-InfoVendaProduto.quantidade       
                           tt-totais.ind5  = tt-InfoVendaProduto.produto-nome. /*+ " : " + string(tt-InfoVendaProduto.quantidade) + " Unid."*/
                           tt-totais.ind5V = YES.                       
            END.                                                
        END.    

        IF tt-indicadoresSelec.id = 6 THEN DO:                                                                                            
            ASSIGN dVlrAux = 0.                                                                                                           
                                                                                                                                          
            FOR EACH tt-InfoVendaProduto NO-LOCK.                                                                                         
                IF (tt-InfoVendaProduto.valorTot - tt-InfoVendaProduto.custo) > dVlrAux THEN                                                                          
                    ASSIGN dVlrAux         = (tt-InfoVendaProduto.valorTot - tt-InfoVendaProduto.custo)                                                               
                           tt-totais.ind6  = tt-InfoVendaProduto.produto-nome. /*+ " : R$" + string(dVlrAux,">>>>>9.99") + " Unid." */
                           tt-totais.ind6V = YES.                                                                                         
            END.                                                                                                                          
        END.    

        IF tt-indicadoresSelec.id = 7 THEN DO: 
            ASSIGN dVlrAux = 0.                  
                                                 
            FOR EACH tt-InfoVendaProduto NO-LOCK.
                ASSIGN dVlrAux = dVlrAux + custo.
            END.                                 

            ASSIGN dVlrAux         = dTotVendas - dVlrAux
                   dVlrAux         = (dVlrAux / dTotVendas) * 100
                   tt-totais.ind7  = STRING(dVlrAux,">>>>>9.99")
                   tt-totais.ind7V = YES.
        END.

        IF tt-indicadoresSelec.id = 8 THEN DO:                     
            ASSIGN tt-totais.ind8  = STRING(iTamanhoEstoque)
                   tt-totais.ind8V = YES.                          
        END.     

        IF tt-indicadoresSelec.id = 9 THEN DO:
            ASSIGN dVlrAux         = (iTamanhoEstoqueAnt + iTamanhoEstoque) / 2     
                   dVlrAux         = iQtdProdVendas / dVlrAux
                   tt-totais.ind9  = STRING(dVlrAux,">>>>>9.99")  
                   tt-totais.ind9V = YES.                         
        END.

        IF tt-indicadoresSelec.id = 10 THEN DO:
            ASSIGN iQtdAux          = f-diasMes(INT(fil-mesTotais:SCREEN-VALUE),INT(fil-anoTotais:SCREEN-VALUE))
                   dVlrAux          = iQtdProdVendas / iQtdAux
                   dVlrAux          = iTamanhoEstoque / iQtdAux
                   tt-totais.ind10  = STRING(dVlrAux,">>>>>9.99")          
                   tt-totais.ind10V = YES.                                 
        END.
    END.
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
        WHEN "TOTAIS" THEN DO:
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-7:BGCOLOR IN FRAME {&FRAME-NAME} = 15.

            HIDE FRAME FRAME-B.
            HIDE FRAME FRAME-C.
            HIDE FRAME FRAME-D.
            HIDE FRAME FRAME-E.

            VIEW FRAME FRAME-A.

            RUN p-leituraTotais.
        END.
        WHEN "COMPRA" THEN DO:                             
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 15. 
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-7:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
                                                          
            HIDE FRAME FRAME-A.
            HIDE FRAME FRAME-C.
            HIDE FRAME FRAME-D.
            HIDE FRAME FRAME-E.
                                                          
            VIEW FRAME FRAME-B.    

            RUN p-leituraCompra.
        END.  
        WHEN "VENDA" THEN DO:                             
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 15. 
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-7:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
                                                          
            HIDE FRAME FRAME-A.                   
            HIDE FRAME FRAME-B.
            HIDE FRAME FRAME-D.
            HIDE FRAME FRAME-E.
                                           
            VIEW FRAME FRAME-C.   

            RUN p-leituraVenda.
        END.    
        WHEN "DESCONTO" THEN DO:                             
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 15. 
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
            FILL-IN-7:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
                                                          
            HIDE FRAME FRAME-A.                           
            HIDE FRAME FRAME-B.                           
            HIDE FRAME FRAME-C.                           
            HIDE FRAME FRAME-E.                           
                                                          
            VIEW FRAME FRAME-D.  

            RUN p-leituraDesconto.
        END. 
        WHEN "ESTOQUE" THEN DO:                          
            FILL-IN-3:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-4:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-5:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
            FILL-IN-6:BGCOLOR IN FRAME {&FRAME-NAME} = 15. 
            FILL-IN-7:BGCOLOR IN FRAME {&FRAME-NAME} = 9.
                                                          
            HIDE FRAME FRAME-A.                           
            HIDE FRAME FRAME-B.                           
            HIDE FRAME FRAME-C.                           
            HIDE FRAME FRAME-D.                           
                                                          
            VIEW FRAME FRAME-E.  

            RUN p-leituraEstoque.
        END.                                              
    END CASE.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-diasMes wWin 
FUNCTION f-diasMes RETURNS INTEGER
  (INPUT iMes AS INT, INPUT iAno AS INT) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VARIABLE dtInicio AS DATE NO-UNDO.
    DEFINE VARIABLE dtFim    AS DATE NO-UNDO.

    dtInicio = DATE(iMes,1,iAno).

    IF iMes = 12 THEN
        dtFim = DATE(1, 1, iAno + 1) - 1.
    ELSE
        dtFim = DATE(iMes + 1, 1, iAno) - 1.

    RETURN DAY(dtFim).   

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION f-width wWin 
FUNCTION f-width RETURNS INTEGER
  (INPUT ctexto AS CHAR) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR iAux AS INT NO-UNDO.

  IF ctexto = "" OR
     ctexto = ? THEN
      RETURN 5.

  iAux = LENGTH(ctexto).
  iAux = iAux + 2.

  RETURN iAux.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

