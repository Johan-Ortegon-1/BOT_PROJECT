/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;
/**
 *
 * @author edwin
 */
public class FuncDeclaration implements ASTNode {
    private List<ASTNode> parametros;
    private List<ASTNode> body;

    public FuncDeclaration(List<ASTNode> parametros, List<ASTNode> body) {
        this.parametros = parametros;
        this.body = body;
    }

    @Override
    public Object execute(Stack pila) {
        Map<String,Object> symbolTable=new HashMap<String,Object>();
        /*for(ASTNode i:parametros)
            symbolTable.put(key, value);*/
        pila.push(symbolTable);
        for(ASTNode n:body)
            n.execute(pila);
        pila.pop();
        return null;
    }
    
    
}
