/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.List;
import java.util.Map;

/**
 *
 * @author edwin
 */
public class Condicional implements ASTNode {
    private ASTNode condicion;
    private List<ASTNode> body;
    private List<ASTNode> elseBody;

    public Condicional(ASTNode condicion, List<ASTNode> body, List<ASTNode> elseBody) {
        this.condicion = condicion;
        this.body = body;
        this.elseBody = elseBody;
    }

    @Override
    public Object execute(Map<String,Object> symbolTable) {
        if((boolean)condicion.execute(symbolTable)){
            for(ASTNode n:body)
                n.execute(symbolTable);
        }
        else{
            for(ASTNode n:elseBody)
                n.execute(symbolTable);
        }
        return null;
    }
    
    
}
