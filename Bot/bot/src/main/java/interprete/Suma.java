/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

/**
 *
 * @author edwin
 */
public class Suma implements ASTNode{
    private ASTNode operand1;
    private ASTNode operand2;

    public Suma(ASTNode operand1, ASTNode operand2) {
        super();
        this.operand1 = operand1;
        this.operand2 = operand2;
    }
    
    
    @Override
    public Object execute() {
        return  (int) operand1.execute() + (int)operand2.execute();
    }
    
    
    
    
}
