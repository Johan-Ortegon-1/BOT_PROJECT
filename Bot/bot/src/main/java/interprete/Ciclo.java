/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.List;
import java.util.Map;

/**
 *
 * @author edwin
 */
public class Ciclo implements ASTNode {
    private ASTNode condicion;
    private List<ASTNode> body;

    public Ciclo(ASTNode condicion, List<ASTNode> body) {
        this.condicion = condicion;
        this.body = body;
    }

    @Override
    public Object execute(Map<String,Object> symbolTable) {
        while((boolean)condicion.execute(symbolTable)){
            for(ASTNode n:body)
                n.execute(symbolTable);
        }
        return null;
    }
    
    
}
