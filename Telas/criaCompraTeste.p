DEF VAR vsi-usr-id AS INT NO-UNDO.
DEF VAR vData AS DATE NO-UNDO.
DEF VAR vQtd AS INT NO-UNDO.
DEF VAR iAux AS INT NO-UNDO.

DEF BUFFER bf-estoque FOR estoque.
DEF BUFFER bf-compra FOR compra.

vData = DATE(MONTH(TODAY) - 1,1,YEAR(TODAY)).
vsi-usr-id = 5.

iAux = 1.
vData = vData + iAux.


FIND LAST estoque WHERE                                             
          estoque.usuario-id  = vsi-usr-id NO-LOCK NO-ERROR.
/*
CREATE estoque.                                                                       
ASSIGN estoque.usuario-id  = vsi-usr-id                                       
       estoque.estoque-id  = IF AVAIL bf-estoque THEN bf-estoque.estoque-id + 1 ELSE 1
       estoque.estoque-mes = MONTH(vData)                                             
       estoque.estoque-ano = YEAR(vData)                                              
       estoque.estoque-dataAlt = vData                                                
       estoque.estoque-horaAlt = TIME.    
*/



FIND LAST bf-compra WHERE                                                               
          bf-compra.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.                           
                                                                                        
CREATE compra.                                                                          
ASSIGN compra.usuario-id        = vsi-usr-id                                            
       compra.compra-id         = IF AVAIL bf-compra THEN bf-compra.compra-id + 1 ELSE 1
       compra.compra-data       = vData                                        
       compra.compra-hora       = TIME
       compra.compra-notafiscal = ""                                             
       compra.compra-dataAlt    = vData                                                 
       compra.compra-horaAlt    = TIME. 

FIND FIRST produto WHERE
           produto.usuario-id = vsi-usr-id AND
           produto.produto-id = iAux NO-LOCK NO-ERROR.

vQtd = 5.

CREATE compraProduto.                                                                                                 
ASSIGN compraProduto.usuario-id                 = vsi-usr-id                                                          
       compraProduto.compra-id                  = compra.compra-id                                                    
       compraProduto.produto-id                 = produto.produto-id                                         
       compraProduto.compraproduto-quantidade   = vQtd                                          
       compraProduto.compraproduto-valorUnidade = produto.produto-valorVarejo             
       compraProduto.compraproduto-valorTotal   = produto.produto-valorVarejo * vQtd                                        
       compraProduto.compraproduto-dataAlt      = vData                                                               
       compraProduto.compraproduto-horaAlt      = TIME.                                                               
                                                                                                                      
FIND LAST estoqueProduto WHERE                                                                                        
          estoqueProduto.usuario-id = vsi-usr-id AND                                                                  
          estoqueProduto.estoque-id = estoque.estoque-id AND                                                          
          estoqueProduto.produto-id = produto.produto-id EXCLUSIVE-LOCK NO-ERROR.                            
IF NOT AVAIL estoqueProduto THEN DO:                                                                                  
                                                                                                                      
    CREATE estoqueProduto.                                                                                            
    ASSIGN estoqueProduto.usuario-id = vsi-usr-id                                                                     
           estoqueProduto.estoque-id = estoque.estoque-id                                                             
           estoqueProduto.produto-id = produto.produto-id                                                    
           estoqueProduto.estoqueproduto-quantidade = 0.                                                              
END.                                                                                                                  
                                                                                                                      
ASSIGN estoqueProduto.estoqueproduto-quantidade = estoqueProduto.estoqueproduto-quantidade + vQtd
       estoqueProduto.estoqueproduto-dataAlt = vData                                                                  
       estoqueProduto.estoqueproduto-horaAlt = TIME.                                                                  















































