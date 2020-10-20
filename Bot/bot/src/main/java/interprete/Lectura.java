/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.Map;
import java.util.Scanner;

/**
 *
 * @author edwin
 */
public class Lectura implements ASTNode{
    String variable;

    public Lectura(String variable) {
        this.variable = variable;
    }
    
    
    @Override
    public Object execute(Map<String, Object> symbolTable) {
        System.out.println("\nIngrese el valor");
        Scanner in = new Scanner(System.in);
        String s = in.nextLine(); 
        symbolTable.replace(variable, s);
        return null;
    }
    
    
    
}