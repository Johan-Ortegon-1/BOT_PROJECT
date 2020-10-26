/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interprete;

import java.util.Map;
import java.util.HashMap;
import java.util.Stack;
/**
 *
 * @author edwin
 */

public interface ASTNode {
    public Object execute(Stack pila);
}
