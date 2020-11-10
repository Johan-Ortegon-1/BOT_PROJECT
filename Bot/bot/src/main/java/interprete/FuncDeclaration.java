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
    private String nombre;
    private List<String> parametros;
    private List<ASTNode> body;

    public FuncDeclaration(String nombre,List<String> parametros, List<ASTNode> body) {
        this.nombre = nombre;
        this.parametros = parametros;
        this.body = body;
    }

    @Override
    public Object execute(Stack pila) {
        Map<String,Object> symbolTable = (Map<String,Object>)pila.peek();
        symbolTable.put(nombre, this);
        return null;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public List<String> getParametros() {
        return parametros;
    }

    public void setParametros(List<String> parametros) {
        this.parametros = parametros;
    }

    public List<ASTNode> getBody() {
        return body;
    }

    public void setBody(List<ASTNode> body) {
        this.body = body;
    }
    
    
    
}
