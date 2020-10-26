/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.Map;
import java.util.Stack;
/**
 *
 * @author edwin
 */
public class VarDeclAsig implements ASTNode{
    private String name;
    private ASTNode variable;

    public VarDeclAsig(String name, ASTNode variable) {
        super();
        this.name = name;
        this.variable = variable;
    }

    @Override
    public Object execute(Stack pila) {
        Map<String,Object> symbolTable=(Map<String,Object>) pila.peek();
        symbolTable.put(name,variable.execute(pila));
        return null;
    }

    
    
    
}
