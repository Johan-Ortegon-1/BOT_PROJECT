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
public class Cadena implements ASTNode{
    public String value;

    public Cadena(String value) {
        super();
        this.value = value;
    }

    @Override
    public Object execute(Stack pila) {
    	if(value.charAt(0) == '\"')
    		value = value.substring(1, value.length()-1);
        return value.replace("\\\"", "\"");
        //return value;
    }

}
