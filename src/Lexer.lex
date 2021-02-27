import java_cup.runtime.*;

%%
%class Lexer
%unicode
%cup
%line
%column
%states IN_COMMENT
// %debug
%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

Whitespace = \r|\n|\r\n|" "|"\t"
Letter = [a-zA-Z]
Digit = [0-9]
CharChar = {Letter} | {Digit} | " " | "!" | "#" | "$" | "%" | "&" | "(" | ")" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | "<" | "=" | ">" | "?" | "@" | "[" | \\  | "]" | "^" | "_" | "`" | "{" | "¦" |  "}" | "~"
/* ' and " ?? */
String = {CharChar}+

%%
<YYINITIAL> {
    "fdef"        { return symbol(sym.FDEF); }
    "print"       { return symbol(sym.PRINT); }
    "main"        { return symbol(sym.MAIN); }

    {Whitespace}  { /* do nothing */               }
    ";"           { return symbol(sym.SEMICOL);    }
    "("           { return symbol(sym.LPAREN);     }
    ")"           { return symbol(sym.RPAREN);     }
    "{"           { return symbol(sym.LCURL);      }
    "}"           { return symbol(sym.RCURL);      }
    \"{String}\"  {
        String str =  yytext().substring(1,yylength()-1);
        return symbol(sym.STRING, str);
    }
}

/* error fallback */
[^]  {
    System.out.println("Error in line "
        + (yyline+1) +": Invalid input '" + yytext()+"'");
    return symbol(sym.ILLEGAL_CHARACTER);
}
