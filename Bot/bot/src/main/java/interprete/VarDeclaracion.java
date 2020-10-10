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
public class VarDeclaracion implements ASTNode {
    
    private String name;

    public VarDeclaracion(String name) {
        this.name = name;
    }

    @Override
    public Object execute(Map<String, Object> symbolTable) {
        symbolTable.put(name, new Object());
        return null;
    }
    
    
    
}
