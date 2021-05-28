/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tIF = 258,
    tELSE = 259,
    tWHILE = 260,
    tMAIN = 261,
    tACCG = 262,
    tACCD = 263,
    tPRINTF = 264,
    tPG = 265,
    tPD = 266,
    tCONST = 267,
    tINT = 268,
    tFLOAT = 269,
    tINT_NUM = 270,
    tFLOAT_NUM = 271,
    tNAME = 272,
    tPLUS = 273,
    tMOINS = 274,
    tSLASH = 275,
    tSTAR = 276,
    tEQUAL = 277,
    tINF = 278,
    tSUP = 279,
    tSPACE = 280,
    tCOMA = 281,
    tET = 282,
    tPCOMA = 283,
    tTAB = 284,
    tENTREE = 285
  };
#endif
/* Tokens.  */
#define tIF 258
#define tELSE 259
#define tWHILE 260
#define tMAIN 261
#define tACCG 262
#define tACCD 263
#define tPRINTF 264
#define tPG 265
#define tPD 266
#define tCONST 267
#define tINT 268
#define tFLOAT 269
#define tINT_NUM 270
#define tFLOAT_NUM 271
#define tNAME 272
#define tPLUS 273
#define tMOINS 274
#define tSLASH 275
#define tSTAR 276
#define tEQUAL 277
#define tINF 278
#define tSUP 279
#define tSPACE 280
#define tCOMA 281
#define tET 282
#define tPCOMA 283
#define tTAB 284
#define tENTREE 285

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 15 "lex.y" /* yacc.c:1909  */

	int integer;
    char * string;
	

#line 120 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
