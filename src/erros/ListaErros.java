package erros;

import java.util.ArrayList;

public class ListaErros {

	//Defição da classe ERRO aqui dentro mesmo para usar em ListaErros
	class Erro {
		int linha, coluna;
		String texto;
		
		Erro(int linha, int coluna, String texto) {
			this.linha = linha;
			this.coluna = coluna;
			this.texto = texto;
		}
	}
	
	private ArrayList<Erro> erros;
	private Integer quantidadeErros;

	public ListaErros() {
		erros = new ArrayList<Erro>();
		quantidadeErros = 0;
	}
	
	public int tamanho() {
		return quantidadeErros;
		// ou senao: return erros.size();
	}
	

	public void defErro(int linha, int coluna, String texto) {
		erros.add(new Erro(linha, coluna, texto));
		quantidadeErros++;
	}
	
	//sobrecarga do metodo defErro
	public void defErro(int linha, int coluna) {
		erros.add(new Erro(linha, coluna, null));
		quantidadeErros++;
	}
	
	//sobrecarga do metodo defErro
	public void defErro(String texto) {
		for (int i = quantidadeErros - 1; i >= 0; --i) {
			Erro e = erros.get(i);
			if (e.texto == null) {
				e.texto = texto;
				return;
			}
		}
	}
	
	public void dump() {
		for (int i = 0; i < quantidadeErros; ++i) {
			Erro e = erros.get(i);
			String s = e.texto;
			if (s == null) {
				s = "";
			}
			System.out.println(
					"linha=" + (e.linha + 1)
					+ " coluna=" + (e.coluna + 1)
					+ "  " + s);
		}
	}
	
}
