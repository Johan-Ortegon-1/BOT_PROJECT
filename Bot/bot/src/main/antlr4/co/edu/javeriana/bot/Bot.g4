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
ROBOT_UP: [^][0-9]+;
ROBOT_DOWN: [V][0-9]+;
ROBOT_LEFT: [<][0-9]+;
ROBOT_RIGHT: [>][0-9]+;
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
REVERSE: [~]+[0-9]+;

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

//- Identificadores
ID : [a-zA-Z] [a-zA-Z0-9]* ;

//- Constantes
NUM_FLOAT: [0-9]+('.')?[0-9]*;
BOOLEAN: ('@T'|'@F');
STRING : '"' ('\\"'|.)*? '"';

//- Comentarios
COMMEENT
:
	[#]+ -> skip
;
//- Expacios en blanco
WS
:
	[ \t\r\n]+ -> skip
;