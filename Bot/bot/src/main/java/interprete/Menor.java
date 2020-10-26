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
public class Menor implements ASTNode{
    private ASTNode operand1;
    private ASTNode operand2;

    public Menor(ASTNode operand1, ASTNode operand2) {
        super();
        this.operand1 = operand1;
        this.operand2 = operand2;
    }
    
    
    @Override
    public Object execute(Stack pila) {
        if(operand1.execute(pila) instanceof Float && operand2.execute(pila) instanceof Float) {
        	if ((float) operand1.execute(pila) < (float) operand2.execute(pila))
            {
            	return true;
            }
        	else {
        		return false;
        	}
        }
        else if(operand1.execute(pila) instanceof String && operand2.execute(pila) instanceof String) {
        	if (((String)operand1.execute(pila)).compareTo((String)operand2.execute(pila)) == -1)
            {
            	return true;
            }
        	else {
        		return false;
        	}
        }
        else {
        	System.out.println("Error en la comparacion!");
        	return null;
        }
    }
    
    
    /*Para los String también debemos tener definidos operadores de mayor y menor, o con la comparación es suficiente? */
    
}
