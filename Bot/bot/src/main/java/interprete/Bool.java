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
public class Bool implements ASTNode{
    boolean value;

    public Bool(String value) {
        super();
        if(value.equals("@T"))
        	this.value = true;
        else if(value.equals("@F"))
        	this.value = false;
    }

    @Override
    public Object execute(Stack pila ) {
        return value;
    }
    
    
    
    
    
}
