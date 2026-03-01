DEF BUFFER bf-estoque FOR estoque.
DEF BUFFER bf-estoqueProduto FOR estoqueProduto.

FOR EACH usuario NO-LOCK.

    FIND FIRST estoque WHERE
               estoque.usuario-id  = usuario.usuario-id AND
               estoque.estoque-mes = MONTH(TODAY) AND
               estoque.estoque-ano = YEAR(TODAY) EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAIL estoque THEN DO:

        FIND LAST bf-estoque WHERE                                             
                  bf-estoque.usuario-id  = usuario.usuario-id NO-LOCK NO-ERROR.

        CREATE estoque.
        ASSIGN estoque.usuario-id  = usuario.usuario-id
               estoque.estoque-id  = IF AVAIL bf-estoque THEN bf-estoque.estoque-id + 1 ELSE 1
               estoque.estoque-mes = MONTH(TODAY)
               estoque.estoque-ano = YEAR(TODAY)
               estoque.estoque-dataAlt = TODAY
               estoque.estoque-horaAlt = TIME.

        IF AVAIL bf-estoque THEN DO:

            FOR EACH bf-estoqueProduto WHERE                           
                     bf-estoqueProduto.usuario-id = usuario.usuario-id AND
                     bf-estoqueProduto.estoque-id = bf-estoque.estoque-id NO-LOCK.

                CREATE estoqueProduto.
                ASSIGN estoqueProduto.usuario-id                = usuario.usuario-id
                       estoqueProduto.estoque-id                = estoque.estoque-id
                       estoqueProduto.produto-id                = bf-estoqueProduto.produto-id
                       estoqueProduto.estoqueproduto-quantidade = bf-estoqueProduto.estoqueproduto-quantidade
                       estoqueProduto.estoqueproduto-dataAlt    = bf-estoqueProduto.estoqueproduto-dataAlt
                       estoqueProduto.estoqueproduto-horaAlt    = bf-estoqueProduto.estoqueproduto-horaAlt.
            END.  
        END.

        FOR EACH produto WHERE                                   
                 produto.usuario-id = usuario.usuario-id NO-LOCK.

            FIND FIRST estoqueProduto WHERE                                             
                       estoqueProduto.usuario-id = usuario.usuario-id AND               
                       estoqueProduto.estoque-id = estoque.estoque-id AND            
                       estoqueProduto.produto-id = produto.produto-id NO-LOCK NO-ERROR. 
            IF NOT AVAIL estoqueProduto THEN DO:

                CREATE estoqueProduto.                                                                       
                ASSIGN estoqueProduto.usuario-id                = usuario.usuario-id               
                       estoqueProduto.estoque-id                = estoque.estoque-id                         
                       estoqueProduto.produto-id                = produto.produto-id               
                       estoqueProduto.estoqueproduto-quantidade = 0
                       estoqueProduto.estoqueproduto-dataAlt    = TODAY   
                       estoqueProduto.estoqueproduto-horaAlt    = TIME.  
            END.                                                                                                                      
        END.                                                     
    END.
    ELSE DO:

        FIND LAST bf-estoque WHERE                                              
                  bf-estoque.usuario-id  = usuario.usuario-id and
                  bf-estoque.estoque-id <> estoque.estoque-id NO-LOCK NO-ERROR.
        IF AVAIL bf-estoque THEN DO:

            FOR EACH bf-estoqueProduto WHERE                                               
                     bf-estoqueProduto.usuario-id = usuario.usuario-id AND                 
                     bf-estoqueProduto.estoque-id = bf-estoque.estoque-id NO-LOCK.

                FIND FIRST estoqueProduto WHERE                                            
                           estoqueProduto.usuario-id = usuario.usuario-id AND              
                           estoqueProduto.estoque-id = estoque.estoque-id AND              
                           estoqueProduto.produto-id = bf-estoqueProduto.produto-id NO-LOCK NO-ERROR.
                IF NOT AVAIL estoqueProduto THEN DO:   

                    CREATE estoqueProduto.                                                                       
                    ASSIGN estoqueProduto.usuario-id                = usuario.usuario-id                         
                           estoqueProduto.estoque-id                = estoque.estoque-id                         
                           estoqueProduto.produto-id                = bf-estoqueProduto.produto-id               
                           estoqueProduto.estoqueproduto-quantidade = bf-estoqueProduto.estoqueproduto-quantidade
                           estoqueProduto.estoqueproduto-dataAlt    = bf-estoqueProduto.estoqueproduto-dataAlt   
                           estoqueProduto.estoqueproduto-horaAlt    = bf-estoqueProduto.estoqueproduto-horaAlt.  
                END.
            END.
        END.

        FOR EACH produto WHERE                                                          
                 produto.usuario-id = usuario.usuario-id NO-LOCK.                       
                                                                                        
            FIND FIRST estoqueProduto WHERE                                             
                       estoqueProduto.usuario-id = usuario.usuario-id AND               
                       estoqueProduto.estoque-id = estoque.estoque-id AND               
                       estoqueProduto.produto-id = produto.produto-id NO-LOCK NO-ERROR. 
            IF NOT AVAIL estoqueProduto THEN DO:                                        
                                                                                        
                CREATE estoqueProduto.                                                  
                ASSIGN estoqueProduto.usuario-id                = usuario.usuario-id    
                       estoqueProduto.estoque-id                = estoque.estoque-id    
                       estoqueProduto.produto-id                = produto.produto-id    
                       estoqueProduto.estoqueproduto-quantidade = 0                     
                       estoqueProduto.estoqueproduto-dataAlt    = TODAY                 
                       estoqueProduto.estoqueproduto-horaAlt    = TIME.                 
            END.                                                                        
        END.                                                                            
    END.
END.
