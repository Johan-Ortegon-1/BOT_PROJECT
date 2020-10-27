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
public class Resta implements ASTNode{
    private ASTNode operand1;
    private ASTNode operand2;

    public Resta(ASTNode operand1, ASTNode operand2) {
        super();
        this.operand1 = operand1;
        this.operand2 = operand2;
    }
    
    
    @Override
    public Object execute(Stack pila) {
    	if(operand1.execute(pila) instanceof Float && operand2.execute(pila) instanceof Float) 
    	{
    		return  (float) operand1.execute(pila) - (float)operand2.execute(pila);
    	}
    	System.out.println("Error en el uso de la Resta");
        System.out.println("Op1: " + operand1.execute(pila));
        System.out.println("Op2: " + operand2.execute(pila));
        System.exit(0);
        return null;
    }
    
    
    
    
}
