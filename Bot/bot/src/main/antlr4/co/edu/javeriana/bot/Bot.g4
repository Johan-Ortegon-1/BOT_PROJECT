grammar Bot;

@header {

import org.jpavlich.bot.*;
import java.util.Map;
import java.util.HashMap;
import java.util.Stack;
import interprete.*;
}

@parser::members {
private Bot bot;
//Map<String, Object> symbolTable = new HashMap<String, Object>();
Stack pila = new Stack();
public BotParser(TokenStream input, Bot bot) {
    this(input);
    this.bot = bot;
}

}

program: { 
            List<ASTNode> body=new ArrayList<ASTNode>();
            Map<String,Object> symbolTable=new HashMap<String,Object>();
            pila.push(symbolTable);
         }
    //robot* | 
    (componente {body.add($componente.node);})*
    {
        for(ASTNode n:body){
        	n.execute(pila);     
        }
        pila.clear();
    };

//robot returns [ASTNode node]: ((movimiento_robot{$node=$movimiento_robot.node;}|accion_robot{$node=$accion_robot.node;}) SEMICOLON)+;
robot returns [ASTNode node]: ((movimiento_robot|accion_robot) SEMICOLON)+;

//Movimientos robot
movimiento_robot: (mover_arriba | mover_izquierda | mover_derecha | mover_abajo);			
mover_arriba: ROBOT_UP pasos_robot {bot.up($pasos_robot.pasos); };
mover_izquierda: LT pasos_robot {bot.left($pasos_robot.pasos);};
mover_derecha: GT pasos_robot{bot.right($pasos_robot.pasos);};
mover_abajo: ROBOT_DOWN pasos_robot{bot.down($pasos_robot.pasos);};
pasos_robot returns[int pasos]: NUM_INT{$pasos = Integer.parseInt($NUM_INT.text);};

//Aciones robot
accion_robot: (ROBOT_PICK | ROBOT_DROP);

//SEGUNDA ENTREGA

//Tipos de datos
expresion returns [ASTNode node]:
    t1=factor{$node=$t1.node;}
    ((PLUS t2=factor{$node = new Suma($node,$t2.node);}) | (MINUS t2=factor{$node = new Resta($node,$t2.node);}))*;

factor returns [ASTNode node]:t1=term{$node=$t1.node;}
    ((MULT t2=term{$node = new Multiplicacion($node,$t2.node);}) | (DIV t2=term{$node = new Division($node,$t2.node);}))*;

term returns [ASTNode node]:
    NUM_FLOAT{$node=new Numero($NUM_FLOAT.text);}
    | NUM_INT{$node=new Numero($NUM_INT.text);}
    | factor_reverse {$node=new Inverso($factor_reverse.node);}
    | ID{$node=new VarReferencia($ID.text);}
    | PAR_OPEN expresion {$node=$expresion.node;} PAR_CLOSE;

factor_reverse returns [ASTNode node]: (REVERSE t2=term{$node = $t2.node;});

cadena returns [ASTNode node]: STRING {$node = new Cadena($STRING.text);};
bool returns [ASTNode node]: BOOLEAN {$node = new Bool($BOOLEAN.text);};
    
//Variables
variable returns [ASTNode node]: expresion {$node=$expresion.node;} | cadena {$node=$cadena.node;} | bool {$node=$bool.node;} | expresion_logica {$node=$expresion_logica.node;};
nueva_variable returns[ASTNode node]: NEW_VAR ID {$node=new VarDeclaracion($ID.text);};
nueva_variable_asig returns [ASTNode node]: NEW_VAR ID ASSIGN variable{$node=new VarDeclAsig($ID.text,$variable.node);}; //Por hacer
variable_asig returns [ASTNode node]: ID ASSIGN variable {$node=new VarAsignacion($ID.text,$variable.node);};

//Condicionales

condicional returns[ASTNode node]: IF expresion_logica THEN 
			{
                            List<ASTNode> body = new ArrayList<ASTNode>();
			}
                            (s1 = componente {body.add($s1.node);})*
			{
                            $node = new Condicional($expresion_logica.node, body, null);
			}
			(ELSE
                            {
                                //Map<String,Object> symbolTable=new HashMap<String,Object>();
                                //pila.push(symbolTable);
                                List<ASTNode> elseBody = new ArrayList<ASTNode>();
                            }
                            (s2 = componente {elseBody.add($s2.node);})*
                            {
                                $node = new Condicional($expresion_logica.node, body, elseBody);
                            })?
                        END SEMICOLON;


ciclo returns [ASTNode node]: WHILE PAR_OPEN expresion_logica PAR_CLOSE THEN
        {
            List<ASTNode> body = new ArrayList<ASTNode>();
        }
            (s1 = componente {body.add($s1.node);})*
        {
            $node = new Ciclo($expresion_logica.node, body);
	}
	END SEMICOLON;



expresion_logica returns [ASTNode node]:
    t1=factor_logico{$node=$t1.node;} (OR t2=factor_logico{$node = new Or($node,$t2.node);})*;

factor_logico returns [ASTNode node]:t1=factor_igualdad{$node=$t1.node;}
    (AND t2=factor_igualdad{$node = new And($node,$t2.node);})*;

factor_igualdad returns [ASTNode node]:t1=factor_comparacion{$node=$t1.node;}
    ((EQ t2=factor_comparacion{$node = new Igual($node,$t2.node);}) | (NEQ t2=factor_comparacion{$node = new NoIgual($node,$t2.node);}))*;

factor_comparacion returns [ASTNode node]:t1=term_logico{$node=$t1.node;}
    ((GT t2=term_logico{$node = new Mayor($node,$t2.node);}) 
    	| (GEQ t2=term_logico{$node = new MayorIgual($node,$t2.node);})
    	| (LT t2=term_logico{$node = new Menor($node,$t2.node);})
    	| (LEQ t2=term_logico{$node = new MenorIgual($node,$t2.node);})
    	| (NOT t2=term_logico {$node=new Not($t2.node);})
    )*;

factor_reverse_logico returns [ASTNode node]: (NOT t2=term_logico{$node = $t2.node;});

term_logico returns [ASTNode node]:
    expresion {$node= $expresion.node;}
    | BOOLEAN {$node=new Bool($BOOLEAN.text);}
    | STRING {$node=new Cadena($STRING.text);}
    | factor_reverse_logico {$node=new Not($factor_reverse_logico.node);}
    | PAR_OPEN expresion_logica {$node=$expresion_logica.node;} PAR_CLOSE;

sentencia returns [ASTNode node]: 
    (nueva_variable {$node=$nueva_variable.node;}
    | nueva_variable_asig {$node=$nueva_variable_asig.node;}
    | variable_asig {$node=$variable_asig.node;}
    | impresion {$node=$impresion.node;}
    | robot {$node = $robot.node;}
    | lectura{$node=$lectura.node;}
    ) SEMICOLON; 

/*funcion: NEW_FUNCT ID PAR_OPEN ((parametro)? | (parametro(COMMA parametro)*)) PAR_CLOSE THEN
	componente*
	END;

parametro: NEW_VAR ID;
*/

//componente: sentencia | ciclo | condicional;
componente returns [ASTNode node]: sentencia {$node=$sentencia.node;}
	| condicional {$node=$condicional.node;}
        | ciclo {$node=$ciclo.node;};



//impresion: PRINT (STRING (PLUS (ID|STRING))*) | ID {System.out.println()};
impresion returns [ASTNode node]: PRINT variable {$node = new Println($variable.node);};
lectura returns [ASTNode node]: READ ID {$node =new Lectura($ID.text);};

//operacion: NUM_FLOAT ((PLUS|MINUS|MULT|DIV|REVERSE) NUM_FLOAT)+;
/*start
:
	'hello' 'world' {
		bot.up(5);
		bot.down(5);
		bot.right(5);
		bot.left(5);
	} 
;*/

// Los tokens se escriben a continuación de estos comentarios.

//- Comandos del robot
ROBOT_UP: '^';
ROBOT_DOWN: 'V';
ROBOT_PICK: 'P';
ROBOT_DROP: 'D';

//- Impresion/Lectura por pantalla
READ: '?';
PRINT: '$';

//- Palabras reservadas
NEW_FUNCT: 'define';
RETURN: 'return';
END: 'end';

//- Variables
NEW_VAR: '\'';
ASSIGN: '<-';

//- Condicionales
IF: 'if';
ELSE: 'else';
THEN: '->';

//- Ciclos
WHILE: 'while';

//- Operadores - Logica
PLUS: '+';
MINUS: '-';
MULT: '*';
DIV: '/';
AND: '&';
OR: '|';
NOT: '!';
REVERSE: '~';

//- Comparacion
GT: '>';
LT: '<';
GEQ: '>=';
LEQ: '<=';
EQ: '=';
NEQ: '<>';

//- Simbolos de puntuacion
PAR_OPEN: '(';
PAR_CLOSE: ')';
SEMICOLON: ';';
COMMA: ',';

//- Identificadores
ID : [a-zA-Z] [a-zA-Z0-9]* ;

//- Constantes
NUM_INT: [0-9]+;
//NUM_FLOAT: [0-9]+('.')?[0-9]*;
NUM_FLOAT: ([0-9]+('.'[0-9]*)?|'.'[0-9]+);
BOOLEAN: ('@T'|'@F');
STRING : '"' ('\\"'|.)*? '"';

//- Comentarios
COMMEENT: [////]+ -> skip;

//- Expacios en blanco
WS: [ \t\r\n]+ -> skip;