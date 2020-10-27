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
public class Inverso implements ASTNode{
    private ASTNode operand1;

    public Inverso(ASTNode operand1) {
        super();
        this.operand1 = operand1;
    }
    
    
    @Override
    public Object execute(Stack pila) {
    	if(operand1.execute(pila) instanceof Float) 
    	{
    		return  ((float) operand1.execute(pila) * -1);
    	}
    	System.out.println("Error en el uso del inverso");
        System.out.println("Op1: " + operand1.execute(pila));
        System.exit(0);
        return null;
    }
    
    
    
    
}
