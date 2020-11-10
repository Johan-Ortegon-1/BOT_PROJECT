/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Map;
import java.util.Scanner;
import java.util.Stack;

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
    public Object execute(Stack pila) {
    	Stack stackAux=(Stack)pila.clone();
        while(!stackAux.empty())
        {
        	Map<String,Object> symbolTable=(Map<String,Object>) stackAux.pop();
        	if(symbolTable.containsKey(this.variable))
        	{
        		BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        		// Leyendo datos usando readLine
        		try {
        			System.out.println("\nIngrese el valor: ");
					String name = reader.readLine();
					symbolTable.replace(variable, name);
					return null;
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        		/*System.out.println("\nIngrese el valor: ");
                Scanner in = new Scanner(System.in);
                String s = in.nextLine(); 
                symbolTable.replace(variable, s);
                in.close();
                return null;*/
        	}
        }
        System.out.println("Error: No existe la variable:"+this.variable);
        System.exit(0); //Matar el programa
        return null;
    }
    
    
    
}