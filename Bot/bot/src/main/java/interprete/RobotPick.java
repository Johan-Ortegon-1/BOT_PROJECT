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
public class RobotPick implements ASTNode{
	private Bot bot;

    public RobotPick(Bot bot) {
        super();
        this.bot = bot;
    }
    
    
    
    @Override
    public Object execute(Stack pila) {
    	this.bot.pick();
        return null;
    }
    
}
