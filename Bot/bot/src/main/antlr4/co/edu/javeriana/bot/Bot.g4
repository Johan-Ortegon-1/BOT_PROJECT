grammar Bot;

@header {

import org.jpavlich.bot.*;

}

@parser::members {

private Bot bot;

public BotParser(TokenStream input, Bot bot) {
    this(input);
    this.bot = bot;
}

}

robot: ((movimiento_robot|accion_robot) SEMICOLON)+;
movimiento_robot: (ROBOT_UP | ROBOT_DOWN | GT | LT) ESPACIO NUM_INT;
accion_robot: (ROBOT_PICK | ROBOT_DROP);
/* SEGUNDA ENTREGA
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

nueva_variable: NEW_VAR ID;
nueva_variable_asig: NEW_VAR ID ASSIGN (NUM_FLOAT|STRING|BOOLEAN|operacion);
variable_asig: ID ASSIGN (NUM_FLOAT|STRING|BOOLEAN|operacion);

impresion: PRINT STRING (PLUS (ID|STRING))*;
lectura: READ ID;

condicion_compuesta: condicion ((AND|OR) condicion)*;
condicion: ((ID|NUM_FLOAT|operacion) (GT|LT|GEQ|LEQ|EQ|NEQ) (STRING|NUM_FLOAT));
operacion: NUM_FLOAT ((PLUS|MINUS|MULT|DIV|REVERSE) NUM_FLOAT)+;	*/
start
:
	'hello' 'world' {
		bot.up(5);
		bot.down(5);
		bot.right(5);
		bot.left(5);
	} 
;

// Los tokens se escriben a continuación de estos comentarios.
// Todo lo que esté en líneas previas a lo modificaremos cuando hayamos visto Análisis Sintáctico

//- Comandos del robot
ROBOT_UP: '^';
ROBOT_DOWN: 'V';
ROBOT_PICK: 'P';
ROBOT_DROP: 'D';
ESPACIO: ' ';
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