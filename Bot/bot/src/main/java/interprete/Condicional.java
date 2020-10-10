/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.List;

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
    public Object execute() {
        if((boolean)condicion.execute()){
            for(ASTNode n:body)
                n.execute();
        }
        else{
            for(ASTNode n:elseBody)
                n.execute();
        }
        return null;
    }
    
    
}
