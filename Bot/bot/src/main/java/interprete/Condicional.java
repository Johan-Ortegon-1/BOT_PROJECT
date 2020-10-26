/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;
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
    public Object execute(Stack pila) {
        Map<String,Object> symbolTable=new HashMap<String,Object>();
        pila.push(symbolTable);
        if((boolean)condicion.execute(pila)){
            for(ASTNode n:body)
                n.execute(pila);
        }
        else{
        	if(elseBody != null)
        	{
                    for(ASTNode n:elseBody)
                        n.execute(pila);
        	}
        }
        pila.pop();
        return null;
    }
    
    
}
