DEF VAR vsi-usr-id AS INT NO-UNDO.
DEF VAR vData AS DATE NO-UNDO.  

DEF BUFFER bf-desconto FOR desconto.

vData = DATE(MONTH(TODAY) - 2,1,YEAR(TODAY)).
vsi-usr-id = 5.


FIND LAST bf-desconto WHERE                                                                     
          bf-desconto.usuario-id = vsi-usr-id NO-LOCK NO-ERROR.                                 
                                                                                                
CREATE desconto.                                                                                
ASSIGN desconto.usuario-id       = vsi-usr-id                                                   
       desconto.desconto-id      = IF AVAIL bf-desconto THEN bf-desconto.desconto-id + 1 ELSE 1 
       desconto.desconto-dataIni = vData                                        
       desconto.desconto-dataFim = vData + 5                                        
       desconto.desconto-dataAlt = vData                                                        
       desconto.desconto-horaAlt = TIME.                                                        
                                                                                                                                                                                                                                                            
CREATE descontoProduto.                                                                     
ASSIGN descontoProduto.usuario-id              = vsi-usr-id                                 
       descontoProduto.desconto-id             = desconto.desconto-id                       
       descontoProduto.produto-id              = 1                        
       descontoProduto.descontoproduto-valor   = 10                
       descontoProduto.descontoproduto-dataAlt = vData                                      
       descontoProduto.descontoproduto-horaAlt = TIME. 

CREATE descontoProduto.                                               
ASSIGN descontoProduto.usuario-id              = vsi-usr-id           
       descontoProduto.desconto-id             = desconto.desconto-id 
       descontoProduto.produto-id              = 2                    
       descontoProduto.descontoproduto-valor   = 15                   
       descontoProduto.descontoproduto-dataAlt = vData                
       descontoProduto.descontoproduto-horaAlt = TIME.

CREATE descontoProduto.                                               
ASSIGN descontoProduto.usuario-id              = vsi-usr-id           
       descontoProduto.desconto-id             = desconto.desconto-id 
       descontoProduto.produto-id              = 3                    
       descontoProduto.descontoproduto-valor   = 20                   
       descontoProduto.descontoproduto-dataAlt = vData                
       descontoProduto.descontoproduto-horaAlt = TIME.                
