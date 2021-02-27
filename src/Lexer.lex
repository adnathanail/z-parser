import java_cup.runtime.*;

%%
%class Lexer
%unicode
%cup
%line
%column
%states IN_COMMENT
%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

Whitespace = \r|\n|\r\n|" "|"\t"
Digit = [0-9]
Integer = (0|[1-9]{Digit}*)

%%
<YYINITIAL> {
  {Integer}     { return symbol(sym.INTEGER, Integer.parseInt(yytext())); }
  {Whitespace}  { /* do nothing */               }
  "+"           { return symbol(sym.PLUS);       }
  "*"           { return symbol(sym.MULT);       }
}

/* error fallback */
[^]  {
    System.out.println("Error in line "
        + (yyline+1) +": Invalid input '" + yytext()+"'");
    return symbol(sym.ILLEGAL_CHARACTER);
}
