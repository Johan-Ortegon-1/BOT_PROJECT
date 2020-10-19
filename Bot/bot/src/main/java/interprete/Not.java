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
public class Not implements ASTNode{
    private ASTNode operand1;

    public Not(ASTNode operand1) {
        super();
        this.operand1 = operand1;
    }
    
    
    @Override
    public Object execute(Map<String,Object> symbolTable) {
        return  !((boolean) operand1.execute(symbolTable));
    }
    
    
    
    
}
