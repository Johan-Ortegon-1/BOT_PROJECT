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
public class VarAsignacion implements ASTNode{
    private String name;
    private ASTNode variable;

    public VarAsignacion(String name, ASTNode variable) {
        super();
        this.name = name;
        this.variable = variable;
    }

    @Override
    public Object execute(Stack pila) {
        Stack stackAux=(Stack)pila.clone();
        while(!stackAux.empty()){
            Map<String,Object> symbolTable=(Map<String,Object>) stackAux.pop();
            if(symbolTable.containsKey(name)){
                symbolTable.replace(name,variable.execute(pila));
                return null;
            }
        }
        System.err.println("Error asignacion");
        System.err.println("Error: No existe la variable:"+name);
        System.exit(0); //Matar el programa
        return null;
    }
    
    
    
    
}
