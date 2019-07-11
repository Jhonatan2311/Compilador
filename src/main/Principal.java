package main;

import java.io.FileInputStream;
import java_cup.runtime.Symbol;
import erros.ListaErros;
import scanner.Scanner;
import parser.Parser;

public class Principal {
    public static void main(String[] args)
        throws Exception {
            FileInputStream in = new FileInputStream("teste02.txt");
            ListaErros listaErros = new ListaErros();
            
            Scanner scanner = new Scanner(in, listaErros);
            //Scanner scanner = new Scanner(System.in);
            Parser parser = new Parser(scanner);
            parser.parse();
            if (listaErros.tamanho() == 0) {
                System.out.println("Arquivo sem erros de sintaxe!");
            } else {
                System.out.println("Sintaxe Incorreta!");
                listaErros.dump();
            }
        }
}
