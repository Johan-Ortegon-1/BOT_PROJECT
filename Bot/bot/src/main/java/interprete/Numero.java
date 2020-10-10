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
public class Numero implements ASTNode{
    float value;

    public Numero(String value) {
        super();
        this.value = Float.parseFloat(value);
    }
    
    
    
    @Override
    public Object execute(Map<String, Object> symbolTable) {
        return value;
    }
    
    
}
