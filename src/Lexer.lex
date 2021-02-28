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
SglComment = "#" .*
MltComment = "/#" ~"#/"
Letter = [a-zA-Z]
Digit = [0-9]
CharChar = {Letter} | {Digit} | " " | "!" | "#" | "$" | "%" | "&" | "(" | ")" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | "<" | "=" | ">" | "?" | "@" | "[" | \\  | "]" | "^" | "_" | "`" | "{" | "¦" |  "}" | "~"
/* ' and " ?? */
String = {CharChar}+
PrimType = "bool" | "int" | "rat" | "float" | "char" | "str"
IdChar = {Letter} | {Digit} | "_"
Identifier = {Letter}{IdChar}*
Natural = 0|[1-9]{Digit}*
NonZeroNatural = [1-9]{Digit}*
Integer = {Natural}
Float = {Integer} "." {Digit}?
Rational = {Integer} {Whitespace}* "/" {Whitespace}* {NonZeroNatural}

%%
<YYINITIAL> {
    // Keywords
    "fdef"         { return symbol(sym.FDEF);                                }
    "tdef"         { return symbol(sym.TDEF);                                }
    "print"        { return symbol(sym.PRINT);                               }
    "if"           { return symbol(sym.IF);                                  }
    "else"         { return symbol(sym.ELSE);                                }
    "main"         { return symbol(sym.MAIN);                                }
    "return"       { return symbol(sym.RETURN);                              }
    "while"        { return symbol(sym.WHILE);                               }
    "break"        { return symbol(sym.BREAK);                               }
    "for"          { return symbol(sym.FOR);                                 }
    "of"           { return symbol(sym.OF);                                  }
    "range"        { return symbol(sym.RANGE);                               }
    "thread"       { return symbol(sym.THREAD);                              }
    "wait"         { return symbol(sym.WAIT);                                }
    "alias"        { return symbol(sym.ALIAS);                               }
    "T"            { return symbol(sym.TRUE);                                }
    "F"            { return symbol(sym.FALSE);                               }

    {PrimType}     { return symbol(sym.PRIMTYPE, yytext());                  }  /* TODO use enum? */
    "seq"          { return symbol(sym.SEQ);                                 }
    "dict"         { return symbol(sym.DICT);                                }
    "top"          { return symbol(sym.TOP);                                 }

    {Whitespace}   { /* do nothing */                                        }
    {SglComment}   { /* do nothing */                                        }
    {MltComment}   { /* do nothing */                                        }

    // Characters
    ";"            { return symbol(sym.SEMICOL);                             }
    "("            { return symbol(sym.LPAREN);                              }
    ")"            { return symbol(sym.RPAREN);                              }
    "{"            { return symbol(sym.LCURL);                               }
    "}"            { return symbol(sym.RCURL);                               }
    ":="           { return symbol(sym.ASSIGN);                              }
    "<"            { return symbol(sym.LANGLE);                              }
    ">"            { return symbol(sym.RANGLE);                              }
    "["            { return symbol(sym.LSQUARE);                             }
    "]"            { return symbol(sym.RSQUARE);                             }
    "]"            { return symbol(sym.RSQUARE);                             }
    ","            { return symbol(sym.COMMA);                               }
    "+"            { return symbol(sym.PLUS);                                }
    "-"            { return symbol(sym.MINUS);                               }
    "*"            { return symbol(sym.MULT);                                }
    "/"            { return symbol(sym.DIV);                                 }
    "!"            { return symbol(sym.NOT);                                 }
    "&&"           { return symbol(sym.AND);                                 }
    "||"           { return symbol(sym.OR);                                  }
    "="            { return symbol(sym.EQUAL);                               }
    "<="           { return symbol(sym.LEQ);                                 }
    "!="           { return symbol(sym.NEQ);                                 }
    ":"            { return symbol(sym.COLON);                               }
    "?"            { return symbol(sym.QUEST);                               }
    "."            { return symbol(sym.DOT);                                 }
    "^"            { return symbol(sym.POW);                                 }

    \'{CharChar}\' { return symbol(sym.CHAR, yytext().charAt(1));            }
    {Rational}     { return symbol(sym.RATIONAL, yytext());                  }
    {Integer}      { return symbol(sym.INTEGER, Integer.parseInt(yytext())); }
    {Float}        { return symbol(sym.FLOAT, Float.parseFloat(yytext()));   }
    {Identifier}   { return symbol(sym.IDENTIFIER, yytext());                }
    \"{String}\"   {
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
