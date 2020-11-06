/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.Map;
import java.util.Stack;

import org.jpavlich.bot.Bot;
/**
 *
 * @author edwin
 */
public class RobotDown implements ASTNode{
	private Bot bot;
	private ASTNode steps;

    public RobotDown(ASTNode steps, Bot bot) {
        super();
        this.steps = steps;
        this.bot = bot;
    }
    
    
    
    @Override
    public Object execute(Stack pila) {
    	int steps_int = 0;
    	if(steps.execute(pila) instanceof Float) 
    	{
    		steps_int = Math.round((float) this.steps.execute(pila));
    	}
    	else if(steps.execute(pila) instanceof Integer)
    	{
    		steps_int = (int)this.steps.execute(pila);
    	}
    	else
    	{
    		System.out.println("El tipo de dato no es valido para mover el robot: " + steps.execute(pila));
    		System.exit(0);
    	}
    	this.bot.down(steps_int);
        return null;
    }
    
}
