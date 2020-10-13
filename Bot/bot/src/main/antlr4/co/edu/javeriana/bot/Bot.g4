grammar Bot;

@header {

import org.jpavlich.bot.*;
import java.util.Map;
import java.util.HashMap;
import interprete.*;
}

@parser::members {

private Bot bot;
//Map<String, Object> symbolTable = new HashMap<String, Object>();
public BotParser(TokenStream input, Bot bot) {
    this(input);
    this.bot = bot;
}

}

program: { 
            List<ASTNode> body=new ArrayList<ASTNode>();
            Map<String,Object> symbolTable=new HashMap<String,Object>();
         }
    //robot* | 
    (componente {body.add($componente.node);})*
    {
        for(ASTNode n:body){
        	n.execute(symbolTable);	
        }
    };

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
    ((PLUS t2=factor{$node = new Suma($node,$t2.node);}) | (MINUS t2=factor{$node = new Resta($node,$t2.node);}) | (REVERSE t2=factor{$node = new Inverso($node);}))*;

factor returns [ASTNode node]:t1=term{$node=$t1.node;}
    ((MULT t2=term{$node = new Multiplicacion($node,$t2.node);}) | (DIV t2=term{$node = new Division($node,$t2.node);}))*;

term returns [ASTNode node]:
    NUM_FLOAT{$node=new Numero($NUM_FLOAT.text);}
    | NUM_INT{$node=new Numero($NUM_INT.text);}
    | ID{$node=new VarReferencia($ID.text);}
    | PAR_OPEN expresion {$node=$expresion.node;} PAR_CLOSE;

cadena returns [ASTNode node]: STRING {$node = new Cadena($STRING.text);};
bool returns [ASTNode node]: BOOLEAN {$node = new Bool($BOOLEAN.text);};
    
//Variables
variable returns [ASTNode node]: expresion {$node=$expresion.node;}| cadena {$node=$cadena.node;}| bool {$node=$bool.node;};
nueva_variable returns[ASTNode node]: NEW_VAR ID {$node=new VarDeclaracion($ID.text);};
nueva_variable_asig : NEW_VAR ID ASSIGN variable; //Por hacer
variable_asig returns [ASTNode node]: ID ASSIGN variable {$node=new VarAsignacion($ID.text,$variable.node);};

//Condicionales
 
/*condicional: IF condicion_compuesta THEN 
	componente+
	(ELSE
	componente+)?
END SEMICOLON;*/

condicional returns[ASTNode node]: IF condicion_compuesta THEN //Falta trabajar
			{
				List<ASTNode> body = new ArrayList<ASTNode>();
			}
				(s1 = componente {body.add($s1.node);})*
			{
				$node = new Condicional($condicion_compuesta.node, body, null);
			}
			(ELSE
				{
					List<ASTNode> elseBody = new ArrayList<ASTNode>();
				}
				(s2 = componente {elseBody.add($s2.node);})*
				{
					$node = new Condicional($condicion_compuesta.node, body, elseBody);
				})?
END SEMICOLON;


condicion_compuesta returns[ASTNode node]: condicion ((AND|OR) condicion)*;
condicion returns[ASTNode node]: ((ID|NUM_FLOAT|expresion) (GT|LT|GEQ|LEQ|EQ|NEQ) (STRING|NUM_FLOAT|expresion));

//

sentencia returns [ASTNode node]: 
    (nueva_variable {$node=$nueva_variable.node;}
    //| nueva_variable_asig {$node=$nueva_variable_asig.node;}
    | variable_asig {$node=$variable_asig.node;}
    | impresion {$node=$impresion.node;}
    | robot {$node = $robot.node;}
    //| lectura{$node=$lectura.node;}
    ) SEMICOLON; 

/*funcion: NEW_FUNCT ID PAR_OPEN ((parametro)? | (parametro(COMMA parametro)*)) PAR_CLOSE THEN
	componente*
	END;

parametro: NEW_VAR ID;
*/

//componente: sentencia | ciclo | condicional;
componente returns [ASTNode node]: sentencia {
	$node=$sentencia.node;
};



/*ciclo: WHILE condicion_compuesta THEN
	componente*
	END SEMICOLON;
*/
//impresion: PRINT (STRING (PLUS (ID|STRING))*) | ID {System.out.println()};
impresion returns [ASTNode node]: PRINT variable {$node = new Println($variable.node);};
lectura: READ ID;

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
// Todo lo que esté en líneas previas a lo modificaremos cuando hayamos visto Análisis Sintáctico

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
COMMEENT
:
	[////]+ -> skip
;
//- Expacios en blanco
WS
:
	[ \t\r\n]+ -> skip
;