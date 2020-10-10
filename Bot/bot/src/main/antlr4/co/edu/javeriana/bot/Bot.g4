grammar Bot;

@header {

import org.jpavlich.bot.*;
import java.util.Map;
import java.util.HashMap;
}

@parser::members {

private Bot bot;
Map<String, Object> symbolTable = new HashMap<String, Object>();
public BotParser(TokenStream input, Bot bot) {
    this(input);
    this.bot = bot;
}

}

program: (robot | sentencia)*;
robot: ((movimiento_robot|accion_robot) SEMICOLON)+;
movimiento_robot: (mover_arriba | mover_izquierda | mover_derecha | mover_abajo);
				
mover_arriba: ROBOT_UP pasos_robot
				{
					bot.up($pasos_robot.pasos);
				};
mover_izquierda: LT pasos_robot
				{
					bot.left($pasos_robot.pasos);
				};
mover_derecha: GT pasos_robot
				{
					bot.right($pasos_robot.pasos);
				};
mover_abajo: ROBOT_DOWN pasos_robot
				{
					bot.down($pasos_robot.pasos);
				};
pasos_robot returns[int pasos]: NUM_INT{$pasos = Integer.parseInt($NUM_INT.text);};
accion_robot: (ROBOT_PICK | ROBOT_DROP);



/*Implementacion del analisis semantico */

	//Declaracion de variables y asignacion
nueva_variable: NEW_VAR ID 
	{symbolTable.put($ID.text,0);};

nueva_variable_asig: NEW_VAR ID ASSIGN (expresion|STRING|BOOLEAN); //Por hacer

variable_asig: ID ASSIGN (expresion|STRING|BOOLEAN) {symbolTable.put($ID.text,$expresion.value);};

impresion: PRINT expresion {System.out.println($expresion.value);};

/*expresion returns [Object value]:
    t1=factor{$value=Float.parseFloat($t1.value);}
    (PLUS t2=factor{$value=Float.parseFloat($value)+Float.parseFloat($t2.value);})*;*/

expresion returns [Object value]:
    t1=factor{$value=(Float)$t1.value;}
    (PLUS t2=factor{$value=(Float)$value+(Float)$t2.value;})*;

factor returns [Object value] :t1=term{$value=(Float)$t1.value;}
    (MULT t2=term{$value=(Float)$value * (Float)$t2.value;})*;

term returns [Object value]:
    NUM_FLOAT{$value=Float.parseFloat($NUM_FLOAT.text);}
    | ID {$value = symbolTable.get($ID.text);}
    | PAR_OPEN expresion {$value=$expresion.value;} PAR_CLOSE;










//SEGUNDA ENTREGA
funcion: NEW_FUNCT ID PAR_OPEN ((parametro)? | (parametro(COMMA parametro)*)) PAR_CLOSE THEN
	componente*
	END;

parametro: NEW_VAR ID;


componente: sentencia | ciclo | condicional;

condicional: IF condicion_compuesta THEN 
	componente+
	(ELSE
	componente+)?
END SEMICOLON;

ciclo: WHILE condicion_compuesta THEN
	componente*
	END SEMICOLON;
    
sentencia: (nueva_variable | nueva_variable_asig | impresion | lectura) SEMICOLON; 

//impresion: PRINT (STRING (PLUS (ID|STRING))*) | ID {System.out.println()};
lectura: READ ID;

condicion_compuesta: condicion ((AND|OR) condicion)*;
condicion: ((ID|NUM_FLOAT|expresion) (GT|LT|GEQ|LEQ|EQ|NEQ) (STRING|NUM_FLOAT|expresion));
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
NUM_FLOAT: [0-9]+('.')?[0-9]*;
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