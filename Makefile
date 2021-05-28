all: compiler.l lex.y
	flex compiler.l
	yacc -d lex.y
	gcc lex.yy.c y.tab.c pile.c table_symbole.c table_instructions.c -ly -o compiler.exe

debug: compiler.l
	flex -d compiler.l
	yacc -d -v -t lex.y
	gcc lex.yy.c y.tab.c pile.c table_symbole.c table_instructions.c -ly -o compiler.exe
