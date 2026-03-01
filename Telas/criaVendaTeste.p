DEF VAR vsi-usr-id AS INT NO-UNDO.
DEF VAR vData AS DATE NO-UNDO.
DEF VAR vQtd AS INT NO-UNDO.
DEF VAR iAux AS INT NO-UNDO.

DEF BUFFER bf-estoque FOR estoque.
DEF BUFFER bf-venda FOR venda.

vData = DATE(MONTH(TODAY) - 2,1,YEAR(TODAY)).
vsi-usr-id = 5.  

iAux = 3.

vData = vData + iAux.


FIND LAST estoque WHERE                                             
          estoque.usuario-id  = vsi-usr-id NO-LOCK NO-ERROR.

FIND LAST bf-venda WHERE                                    
          bf-venda.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.

CREATE venda.                                                                      
ASSIGN venda.usuario-id       = vsi-usr-id                                         
       venda.venda-id         = IF AVAIL bf-venda THEN bf-venda.venda-id + 1 ELSE 1
       venda.venda-data       = vData                                     
       venda.venda-hora       = TIME  
       venda.venda-notafiscal = ""                                          
       venda.venda-dataAlt    = vData                                              
       venda.venda-horaAlt    = TIME.     

FIND FIRST produto WHERE                            
           produto.usuario-id = vsi-usr-id AND      
           produto.produto-id = iAux NO-LOCK NO-ERROR. 
                                                    
vQtd = 4.        

CREATE vendaProduto.                                                                                                      
ASSIGN vendaProduto.usuario-id                = vsi-usr-id                                                                
       vendaProduto.venda-id                  = venda.venda-id                                                            
       vendaProduto.produto-id                = produto.produto-id                                               
       vendaProduto.vendaproduto-quantidade   = vQtd                                                 
       vendaProduto.vendaproduto-valorUnidade = produto.produto-valorVarejo                  
       vendaProduto.vendaproduto-valorTotal   = produto.produto-valorVarejo * vQtd                                            
       vendaProduto.vendaproduto-dataAlt      = vData                                                                     
       vendaProduto.vendaproduto-horaAlt      = TIME.                                                                     
                                                                                                                          
FIND LAST estoqueProduto WHERE                                                                                            
          estoqueProduto.usuario-id = vsi-usr-id AND                                                                      
          estoqueProduto.estoque-id = estoque.estoque-id AND                                                              
          estoqueProduto.produto-id = produto.produto-id EXCLUSIVE-LOCK NO-ERROR.                                
IF AVAIL estoqueProduto THEN DO:                                                                                          
                                                                                                                          
    ASSIGN estoqueProduto.estoqueproduto-quantidade = estoqueProduto.estoqueproduto-quantidade - vQtd
           estoqueProduto.estoqueproduto-dataAlt = vData                                                                  
           estoqueProduto.estoqueproduto-horaAlt = TIME.                                                                  
END.                                                                                                                      
