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
public class Retorno implements ASTNode{
    public ASTNode variable;

    public Retorno(ASTNode variable) {
        super();
        this.variable = variable;
    }

    @Override
    public Object execute(Stack pila) {
    	Stack stackAux=(Stack)pila.clone();
    	while(!stackAux.empty()){
            Map<String,Object> symbolTable=(Map<String,Object>) stackAux.pop();
            if(symbolTable.get("return")!=null)
            {
            	symbolTable.put("return", this.variable.execute(pila));
            	break;
            }
        }
    	return null;
    }

}
