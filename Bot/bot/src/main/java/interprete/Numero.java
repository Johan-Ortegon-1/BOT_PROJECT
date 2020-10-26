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
public class Numero implements ASTNode{
    float value;

    public Numero(String value) {
        super();
        this.value = Float.parseFloat(value);
    }
    
    
    
    @Override
    public Object execute(Stack pila) {
        return value;
    }
    
}
