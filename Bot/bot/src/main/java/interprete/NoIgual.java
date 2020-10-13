/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.Map;

/**
 *
 * @author edwin
 */
public class NoIgual implements ASTNode{
    private ASTNode operand1;
    private ASTNode operand2;

    public NoIgual(ASTNode operand1, ASTNode operand2) {
        super();
        this.operand1 = operand1;
        this.operand2 = operand2;
    }
    
    
    @Override
    public Object execute(Map<String,Object> symbolTable) {
        if(operand1.execute(symbolTable) instanceof Float && operand2.execute(symbolTable) instanceof Float) {
        	if ((float) operand1.execute(symbolTable) > (float) operand2.execute(symbolTable))
            {
            	return true;
            }
        	else {
        		return false;
        	}
        }
        else if(operand1.execute(symbolTable) instanceof String && operand2.execute(symbolTable) instanceof String) {
        	if (((String)operand1.execute(symbolTable)).compareTo((String)operand2.execute(symbolTable)) == 1)
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
