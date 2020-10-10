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
public class VarReferencia implements ASTNode {
    private String name;

    public VarReferencia(String name) {
        this.name = name;
    }

    @Override
    public Object execute(Map<String, Object> symbolTable) {
        return symbolTable.get(name);
    }
    
    
}
