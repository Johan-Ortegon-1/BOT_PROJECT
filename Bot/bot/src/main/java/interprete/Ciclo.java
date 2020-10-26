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
public class Ciclo implements ASTNode {
    private ASTNode condicion;
    private List<ASTNode> body;

    public Ciclo(ASTNode condicion, List<ASTNode> body) {
        this.condicion = condicion;
        this.body = body;
    }

    @Override
    public Object execute(Stack pila) {
        Map<String,Object> symbolTable=new HashMap<String,Object>();
        pila.push(symbolTable);
        while((boolean)condicion.execute(pila)){
            for(ASTNode n:body)
                n.execute(pila);
        }
        pila.pop();
        return null;
    }
    
    
}
