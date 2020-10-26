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
public class Println implements ASTNode{
    private ASTNode data;

    public Println(ASTNode data) {
        super();
        this.data=data;
    }
    
    
    @Override
    public Object execute(Stack pila) {
        System.out.println(data.execute(pila));     
        return null;
    } 
    
    
    
    
    
}
