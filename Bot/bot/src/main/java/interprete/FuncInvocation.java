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
public class FuncInvocation implements ASTNode {
    private String nombre;
    private List<ASTNode> parametros;

    public FuncInvocation(String nombre,List<ASTNode> parametros) {
        this.nombre=nombre;
        this.parametros = parametros;
    }

    @Override
    public Object execute(Stack pila) {
        Stack stackAux=(Stack)pila.clone();
        FuncDeclaration funcion=null;
        while(!stackAux.empty()){
            Map<String,Object> symbolTable=(Map<String,Object>) stackAux.pop();
            if(symbolTable.containsKey(nombre)){
                funcion = (FuncDeclaration)symbolTable.get(nombre);
                break;  
            }
        }
        if(funcion!=null){
            List<ASTNode> body=funcion.getBody();
            List<String> params=funcion.getParametros();
            Map<String,Object> symbolTable=new HashMap<String,Object>();
            if(parametros.size()==params.size()){
                for(int i=0;i<parametros.size();i++){
                    symbolTable.put(params.get(i),parametros.get(i).execute(pila));
                }
            }
            else{
                System.out.println("Error: Numero esperado de parametros incorrectos");
                //System.exit(0); //Matar el programa
            }
            pila.push(symbolTable);
            for(ASTNode n:body)
                n.execute(pila);
            pila.pop();
        }
        else{
            System.out.println("Error: No existe la funcion:"+nombre);
            //System.exit(0); //Matar el programa
        }
        return null;
    }
    
    
}
