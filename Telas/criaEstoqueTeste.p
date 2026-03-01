DEF VAR vsi-usr-id AS INT NO-UNDO.
DEF VAR vData AS DATE NO-UNDO.

DEF BUFFER bf-estoque FOR estoque.
DEF BUFFER bf-estoqueProduto FOR estoqueProduto.

vData = DATE(MONTH(TODAY) - 1,1,YEAR(TODAY)).
vsi-usr-id = 5.


FIND LAST bf-estoque WHERE                                             
          bf-estoque.usuario-id  = vsi-usr-id NO-LOCK NO-ERROR.

CREATE estoque.                                                                       
ASSIGN estoque.usuario-id  = vsi-usr-id                                       
       estoque.estoque-id  = IF AVAIL bf-estoque THEN bf-estoque.estoque-id + 1 ELSE 1
       estoque.estoque-mes = MONTH(vData)                                             
       estoque.estoque-ano = YEAR(vData)                                              
       estoque.estoque-dataAlt = vData                                                
       estoque.estoque-horaAlt = TIME.   

FOR EACH bf-estoqueProduto WHERE                                                                 
         bf-estoqueProduto.usuario-id = vsi-usr-id AND                                   
         bf-estoqueProduto.estoque-id = bf-estoque.estoque-id NO-LOCK.                           
                                                                                                 
    CREATE estoqueProduto.                                                                       
    ASSIGN estoqueProduto.usuario-id                = vsi-usr-id                        
           estoqueProduto.estoque-id                = estoque.estoque-id                         
           estoqueProduto.produto-id                = bf-estoqueProduto.produto-id               
           estoqueProduto.estoqueproduto-quantidade = bf-estoqueProduto.estoqueproduto-quantidade
           estoqueProduto.estoqueproduto-dataAlt    = bf-estoqueProduto.estoqueproduto-dataAlt   
           estoqueProduto.estoqueproduto-horaAlt    = bf-estoqueProduto.estoqueproduto-horaAlt.  
END.                                                                                             
