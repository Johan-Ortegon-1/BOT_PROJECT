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
public class VarAsignacion implements ASTNode{
    private String name;
    private ASTNode variable;

    public VarAsignacion(String name, ASTNode variable) {
        super();
        this.name = name;
        this.variable = variable;
    }

    @Override
    public Object execute(Map<String,Object> symbolTable) {
        symbolTable.put(name,variable.execute(symbolTable));
        return null;
    }
    
    
    
    
}
