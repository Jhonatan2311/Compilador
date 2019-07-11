package scanner;
import java_cup.runtime.Symbol;
import parser.SymbolCodes;
import erros.ListaErros;

%%

%class Scanner
%cupsym SymbolCodes
%cup
%unicode   // permite usar caracteres unicode
%line      // permite usar yyline
%column    // permite usar yycolumn
%public

%eofval{
	return criaSimbolo(SymbolCodes.EOF);
%eofval}

%{
    private ListaErros listaErros;

    public Scanner(java.io.InputStream in, ListaErros listaErros){
        this(in);
	this.listaErros = listaErros;
    }

    public ListaErros getListaErros(){
	return listaErros;
    }

    public void defErro(int linha, int coluna, String texto){
	listaErros.defErro(linha,coluna,texto);
    }

    public void defErro(int linha, int coluna){
	listaErros.defErro(linha,coluna);
    }

    public void defErro(String texto){
	listaErros.defErro(texto);
    }

    private Symbol criaSimbolo(int code, Object value){
	return new Symbol(code, yyline, yycolumn, value);
    }

    private Symbol criaSimbolo(int code){
	return new Symbol(code, yyline, yycolumn, null);
    }
%}

FimdeLinha = \r|\n|\r\n
Espaco = {FimdeLinha} | [ \t\f]
Letra   = [a-zA-Z]
Digito  = 0 | [1-9][0-9]*
CharTexto = [^\r\n] /* tudo menos \r e \n */
ComentLinha = "//" {CharTexto}* {FimdeLinha}
Ident   = {Letra} ({Letra} | {Digito})*
Inteiro = {Digito} ({Digito})*
KwProgram = "program"
KwFinal = "final"
KwClass = "class"
KwVoid = "void"
KwNew = "new"
KwWhile = "while"
KwRead = "read"
KwIf = "if"
KwElse = "else"

OpMais = "+"
OpMenos = "-"
OpMult = "*"
OpDiv = "/"
OpMod = "%"

Atribuicao = "="
PtVirg = ";"
Virg = ","
Ponto = "."

OpComparacao = "=="
OpDiferente = "!="
OpMaior = ">"
OpMenor = "<"
OpMaiorIgual = ">="
OpMenorIgual = "<="
OpRelacional = {OpComparacao} | {OpDiferente} | {OpMaior} | {OpMenor} | {OpMaiorIgual} | {OpMenorIgual}

AbrePar = "("
FechaPar = ")"
AbreCol = "["
FechaCol = "]"
AbreChave = "{"
FechaChave = "}"

%%
{Espaco} {/*despreza*/}
{ComentLinha} {/*despreza*/}
{Inteiro} {
	int aux = Integer.parseInt (yytext());
	return criaSimbolo (SymbolCodes.INTEIRO, new Integer(aux));
}
{KwProgram} { return criaSimbolo (SymbolCodes.KW_PROGRAM);} 
{KwFinal} { return criaSimbolo (SymbolCodes.KW_FINAL);}
{KwClass} { return criaSimbolo (SymbolCodes.KW_CLASS);}
{KwVoid} { return criaSimbolo (SymbolCodes.KW_VOID);}
{KwNew} { return criaSimbolo (SymbolCodes.KW_NEW);}
{KwWhile} { return criaSimbolo (SymbolCodes.KW_WHILE);}
{KwRead} { return criaSimbolo (SymbolCodes.KW_READ);}
{KwIf} { return criaSimbolo (SymbolCodes.KW_IF);}
{KwElse} { return criaSimbolo (SymbolCodes.KW_ELSE);}

{Ident} {return criaSimbolo (SymbolCodes.IDENT);}

{OpMais} { return criaSimbolo (SymbolCodes.MAIS);}
{OpMenos} { return criaSimbolo (SymbolCodes.MENOS);}
{OpMult} { return criaSimbolo (SymbolCodes.MULT);}
{OpDiv} { return criaSimbolo (SymbolCodes.DIV);}
{OpMod} { return criaSimbolo (SymbolCodes.MOD);}

{Atribuicao} { return criaSimbolo (SymbolCodes.ATRIB);}
{PtVirg} { return criaSimbolo (SymbolCodes.PTVIRG);}
{Virg} { return criaSimbolo (SymbolCodes.VIRG);}
{Ponto} { return criaSimbolo (SymbolCodes.PONTO);}

{OpRelacional} { return criaSimbolo (SymbolCodes.OP_RELACIONAL);}

{AbrePar} { return criaSimbolo (SymbolCodes.ABREPAR);}
{FechaPar} { return criaSimbolo (SymbolCodes.FECHAPAR);}
{AbreCol} { return criaSimbolo (SymbolCodes.ABRECOL);}
{FechaCol} { return criaSimbolo (SymbolCodes.FECHACOL);}
{AbreChave} { return criaSimbolo (SymbolCodes.ABRECHAVE);}
{FechaChave} { return criaSimbolo (SymbolCodes.FECHACHAVE);}

