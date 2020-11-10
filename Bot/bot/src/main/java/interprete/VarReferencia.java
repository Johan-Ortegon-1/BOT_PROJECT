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
public class VarReferencia implements ASTNode {
    private String name;

    public VarReferencia(String name) {
        this.name = name;
    }

    @Override
    public Object execute(Stack pila) {
        Stack stackAux=(Stack)pila.clone();
        while(!stackAux.empty()){
            Map<String,Object> symbolTable=(Map<String,Object>) stackAux.pop();
            if(symbolTable.get(name)!=null)
                return symbolTable.get(name);
        }
        System.err.println("Error: No existe la variable:"+name);
        System.exit(0); //Matar el programa
        return null;
        
    }
    
    
}
