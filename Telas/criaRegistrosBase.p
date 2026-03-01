DEF VAR vsi-usr-id AS INT NO-UNDO.
DEF VAR vData AS DATE NO-UNDO.

DEF BUFFER bf-usuario FOR usuario.


vData = DATE(MONTH(TODAY) - 2,1,YEAR(TODAY)).



FIND LAST bf-usuario NO-LOCK NO-ERROR.

CREATE usuario.
ASSIGN usuario.usuario-id                = IF AVAIL bf-usuario THEN bf-usuario.usuario-id + 1 ELSE 1           
       usuario.usuario-nome              = "TesteDemo"
       usuario.usuario-email             = "teste@teste.com"
       usuario.usuario-tipoIdentificacao = 1
       usuario.usuario-identificacao     = "04814682000"
       usuario.usuario-telefone          = "5133333333"
       usuario.usuario-login             = "testedemo"
       usuario.usuario-senha             = "123456"
       usuario.usuario-dataAlt           = vData
       usuario.usuario-horaAlt           = TIME.



vsi-usr-id = usuario.usuario-id.


/*CATEGORIA*/
CREATE categoria.                        
ASSIGN categoria.usuario-id          = vsi-usr-id
       categoria.categoria-id        = 1 
       categoria.categoria-descricao = "Categoria 1"
       categoria.categoria-dataAlt   = vData                           
       categoria.categoria-horaAlt   = TIME.     

CREATE categoria.                                   
ASSIGN categoria.usuario-id          = vsi-usr-id 
       categoria.categoria-id        = 2            
       categoria.categoria-descricao = "Categoria 2"
       categoria.categoria-dataAlt   = vData        
       categoria.categoria-horaAlt   = TIME.        

CREATE categoria.                                   
ASSIGN categoria.usuario-id          = vsi-usr-id 
       categoria.categoria-id        = 3            
       categoria.categoria-descricao = "Categoria 3"
       categoria.categoria-dataAlt   = vData        
       categoria.categoria-horaAlt   = TIME.   

CREATE categoria.                                   
ASSIGN categoria.usuario-id          = vsi-usr-id  
       categoria.categoria-id        = 4            
       categoria.categoria-descricao = "Categoria 4"
       categoria.categoria-dataAlt   = vData        
       categoria.categoria-horaAlt   = TIME.     

CREATE categoria.                                   
ASSIGN categoria.usuario-id          = vsi-usr-id 
       categoria.categoria-id        = 5            
       categoria.categoria-descricao = "Categoria 5"
       categoria.categoria-dataAlt   = vData        
       categoria.categoria-horaAlt   = TIME.  

CREATE categoria.                                   
ASSIGN categoria.usuario-id          = vsi-usr-id 
       categoria.categoria-id        = 6            
       categoria.categoria-descricao = "Categoria 6"
       categoria.categoria-dataAlt   = vData        
       categoria.categoria-horaAlt   = TIME.      


/*PRODUTO*/
CREATE produto.                        
ASSIGN produto.usuario-id             = vsi-usr-id
       produto.produto-id             = 1
       produto.produto-nome           = "Produto 1"
       produto.categoria-id           = 1         
       produto.produto-valor          = 10            
       produto.produto-valorVarejo    = 15      
       produto.produto-estoqueCritico = 0      
       produto.produto-imagem         = ""                  
       produto.produto-dataAlt        = vData                      
       produto.produto-horaAlt        = TIME. 

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 2          
       produto.produto-nome           = "Produto 2"
       produto.categoria-id           = 1          
       produto.produto-valor          = 5         
       produto.produto-valorVarejo    = 10         
       produto.produto-estoqueCritico = 2          
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME.  

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 3          
       produto.produto-nome           = "Produto 3"
       produto.categoria-id           = 2          
       produto.produto-valor          = 12          
       produto.produto-valorVarejo    = 18        
       produto.produto-estoqueCritico = 5          
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME.

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 4          
       produto.produto-nome           = "Produto 4"
       produto.categoria-id           = 2          
       produto.produto-valor          = 18          
       produto.produto-valorVarejo    = 25         
       produto.produto-estoqueCritico = 8          
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME. 

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 5          
       produto.produto-nome           = "Produto 5"
       produto.categoria-id           = 3          
       produto.produto-valor          = 22          
       produto.produto-valorVarejo    = 30         
       produto.produto-estoqueCritico = 10          
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME.  

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 6          
       produto.produto-nome           = "Produto 6"
       produto.categoria-id           = 3          
       produto.produto-valor          = 8        
       produto.produto-valorVarejo    = 12         
       produto.produto-estoqueCritico = 8         
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME.  

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 7          
       produto.produto-nome           = "Produto 7"
       produto.categoria-id           = 4          
       produto.produto-valor          = 13         
       produto.produto-valorVarejo    = 17         
       produto.produto-estoqueCritico = 7         
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME.  

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 8          
       produto.produto-nome           = "Produto 8"
       produto.categoria-id           = 4         
       produto.produto-valor          = 23         
       produto.produto-valorVarejo    = 30         
       produto.produto-estoqueCritico = 5         
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME. 

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 9          
       produto.produto-nome           = "Produto 9"
       produto.categoria-id           = 5         
       produto.produto-valor          = 11         
       produto.produto-valorVarejo    = 16        
       produto.produto-estoqueCritico = 9         
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME.  

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 10          
       produto.produto-nome           = "Produto 10"
       produto.categoria-id           = 5          
       produto.produto-valor          = 1         
       produto.produto-valorVarejo    = 5         
       produto.produto-estoqueCritico = 12         
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME. 

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 11          
       produto.produto-nome           = "Produto 11"
       produto.categoria-id           = 6         
       produto.produto-valor          = 10         
       produto.produto-valorVarejo    = 16         
       produto.produto-estoqueCritico = 5         
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME.   

CREATE produto.                                    
ASSIGN produto.usuario-id             = vsi-usr-id 
       produto.produto-id             = 12          
       produto.produto-nome           = "Produto 12"
       produto.categoria-id           = 6          
       produto.produto-valor          = 5         
       produto.produto-valorVarejo    = 10         
       produto.produto-estoqueCritico = 2         
       produto.produto-imagem         = ""         
       produto.produto-dataAlt        = vData      
       produto.produto-horaAlt        = TIME.    

MESSAGE vsi-usr-id
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*
---------------------------
Informacao
---------------------------
vsi-usr-id = 5
---------------------------
OK   
---------------------------
*/
