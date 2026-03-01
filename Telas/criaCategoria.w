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
DEF INPUT PARAM viID  AS INT  NO-UNDO.

DEF SHARED VAR vsi-usr-id AS INT NO-UNDO.

DEF BUFFER bf-categoria FOR categoria.
DEF BUFFER bf-histCategoria FOR histCategoria.

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
&Scoped-Define ENABLED-OBJECTS fil-categoria Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS fil-categoria 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fil-categoria AS CHARACTER FORMAT "X(256)":U 
     LABEL "Categoria" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 51.4 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME gDialog
     fil-categoria AT ROW 1.52 COL 10.6 COLON-ALIGNED WIDGET-ID 2
     Btn_OK AT ROW 2.76 COL 34
     Btn_Cancel AT ROW 2.76 COL 49
     SPACE(1.19) SKIP(0.14)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Manutenção de Categorias"
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
ON WINDOW-CLOSE OF FRAME gDialog /* Manutenção de Categorias */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK gDialog
ON CHOOSE OF Btn_OK IN FRAME gDialog /* OK */
DO:
    DO WITH FRAME {&FRAME-NAME}:

        IF TRIM(fil-categoria:SCREEN-VALUE) = "" THEN DO:

            MESSAGE "Favor informar uma descrição válida."
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.
        END.

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
  DISPLAY fil-categoria 
      WITH FRAME gDialog.
  ENABLE fil-categoria Btn_OK Btn_Cancel 
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

        FIND FIRST categoria WHERE                                
                   categoria.usuario-id   = vsi-usr-id AND        
                   categoria.categoria-id = viID EXCLUSIVE-LOCK NO-ERROR.

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
    END.
    ELSE DO:

        CREATE categoria.
        ASSIGN categoria.usuario-id = vsi-usr-id.

        FIND LAST bf-categoria WHERE
                  bf-categoria.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.
        IF AVAIL bf-categoria THEN
            ASSIGN categoria.categoria-id = bf-categoria.categoria-id + 1.
        ELSE
            ASSIGN categoria.categoria-id = 1.

        FIND LAST histCategoria WHERE                                                  
                  histCategoria.usuario-id   = vsi-usr-id NO-LOCK NO-ERROR.
        IF AVAIL histCategoria THEN
            IF histCategoria.categoria-id + 1 > categoria.categoria-id THEN
                ASSIGN categoria.categoria-id = histCategoria.categoria-id + 1.
    END.

    ASSIGN categoria.categoria-descricao = TRIM(fil-categoria:SCREEN-VALUE)
           categoria.categoria-dataAlt   = TODAY
           categoria.categoria-horaAlt   = TIME.

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

    IF viOPC = "A" THEN DO:

        FIND FIRST categoria WHERE
                   categoria.usuario-id   = vsi-usr-id AND
                   categoria.categoria-id = viID NO-LOCK NO-ERROR.
        IF AVAIL categoria THEN DO:

            ASSIGN fil-categoria:SCREEN-VALUE = categoria.categoria-descricao. 
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

