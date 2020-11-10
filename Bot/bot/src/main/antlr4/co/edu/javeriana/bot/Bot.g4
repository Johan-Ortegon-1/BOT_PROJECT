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
robot returns [ASTNode node]: ((movimiento_robot {$node=$movimiento_robot.node;}|accion_robot {$node=$accion_robot.node;}))+;

//Movimientos robot
movimiento_robot returns [ASTNode node]: (mover_arriba {$node=$mover_arriba.node;} 
											| mover_izquierda {$node=$mover_izquierda.node;} 
											| mover_derecha {$node=$mover_derecha.node;}
											| mover_abajo {$node=$mover_abajo.node;}
);
mover_arriba returns [ASTNode node]: ROBOT_UP expresion {$node = new RobotUp($expresion.node, this.bot);};
mover_izquierda returns [ASTNode node]: LT expresion {$node = new RobotLeft($expresion.node, this.bot);};
mover_derecha returns [ASTNode node]: GT expresion {$node = new RobotRight($expresion.node, this.bot);};
mover_abajo returns [ASTNode node]: ROBOT_DOWN expresion {$node = new RobotDown($expresion.node, this.bot);};

//Aciones robot
accion_robot returns [ASTNode node]: (ROBOT_PICK {$node = new RobotPick(this.bot);} | ROBOT_DROP {$node = new RobotDrop(this.bot);});

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
    | STRING{$node=new Cadena($STRING.text);}
    | BOOLEAN{$node=new Bool($BOOLEAN.text);}
    | factor_reverse {$node=new Inverso($factor_reverse.node);}
    | ID{$node=new VarReferencia($ID.text);}
    | PAR_OPEN expresion {$node=$expresion.node;} PAR_CLOSE;

factor_reverse returns [ASTNode node]: (REVERSE t2=term{$node = $t2.node;});
cadena returns [ASTNode node]: STRING {$node = new Cadena($STRING.text);};
bool returns [ASTNode node]: BOOLEAN {$node = new Bool($BOOLEAN.text);};
    
//Variables
variable returns [ASTNode node]: expresion {$node=$expresion.node;} | cadena {$node=$cadena.node;} | bool {$node=$bool.node;} | expresion_logica {$node=$expresion_logica.node;} | funcion_invo {$node=$funcion_invo.node;};
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


ciclo returns [ASTNode node]: WHILE expresion_logica THEN
        {
            List<ASTNode> body = new ArrayList<ASTNode>();
        }
            (s1 = componente {body.add($s1.node);})*
        {
            $node = new Ciclo($expresion_logica.node, body);
	}
	END SEMICOLON;

//^define fun \(['par]?|(,?['par]{1})*\);$
funcion_decl returns [ASTNode node]: 
        
        NEW_FUNCT ID PAR_OPEN 
        {
            List<String> parametros = new ArrayList<String>();
        }
        (p1=parametro{parametros.add($p1.node);} | p1=parametro? | (p1=parametro{parametros.add($p1.node);} (COMMA? p2=parametro{parametros.add($p2.node);})*) )
        PAR_CLOSE THEN
        {
            List<ASTNode> body = new ArrayList<ASTNode>();
        }
	(s1=componente{body.add($s1.node);})*
        {
            $node = new FuncDeclaration($ID.text,parametros, body);
	}
	END SEMICOLON;

funcion_invo returns [ASTNode node]: ID PAR_OPEN 
        {
            List<ASTNode> parametros = new ArrayList<ASTNode>();
        }
        (v1=variable{parametros.add($v1.node);} | v1=variable? | (v1=variable{parametros.add($v1.node);} (COMMA? v2=variable{parametros.add($v2.node);})*) ) 
        PAR_CLOSE
        {
            $node = new FuncInvocation($ID.text,parametros);
        }
        SEMICOLON?;

parametro returns [String node]: NEW_VAR ID {$node=$ID.text;};

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
    | retorno{$node=$retorno.node;}
    ) SEMICOLON; 

componente returns [ASTNode node]: sentencia {$node=$sentencia.node;}
	| condicional {$node=$condicional.node;}
    | ciclo {$node=$ciclo.node;}
    | funcion_decl {$node=$funcion_decl.node;}
    | funcion_invo {$node=$funcion_invo.node;}
    | COMMEENT {$node = null;};


impresion returns [ASTNode node]: PRINT variable {$node = new Println($variable.node);};
lectura returns [ASTNode node]: READ ID {$node =new Lectura($ID.text);};

retorno returns [ASTNode node]: RETURN variable {$node = new Retorno($variable.node);};

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