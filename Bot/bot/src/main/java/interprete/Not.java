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
public class Not implements ASTNode{
    private ASTNode operand1;

    public Not(ASTNode operand1) {
        super();
        this.operand1 = operand1;
    }
    
    
    @Override
    public Object execute(Stack pila) {
        return  !((boolean) operand1.execute(pila));
    }
    
    
    
    
}
