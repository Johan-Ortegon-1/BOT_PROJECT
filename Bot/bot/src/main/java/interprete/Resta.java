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
        return  (float) operand1.execute(pila) - (float)operand2.execute(pila);
    }
    
    
    
    
}
