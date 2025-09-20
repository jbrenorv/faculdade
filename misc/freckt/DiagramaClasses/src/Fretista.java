import java.util.ArrayList;
import java.util.List;

public abstract class Fretista extends Usuario { //PessoaFisica {//Usuario {
    // atributos
    // o que um fretista tem que um cliente nao tem?
    public final List<Veiculo> veiculos = new ArrayList<>();
    public Localizacao atualLocalizacao;
    public String cnh;

    // metodos
    // o que o fretista pode fazer?
    public void adicionarVeiculo(Veiculo newVeiculo) {
        veiculos.add(newVeiculo);
    }
    public void removerVeiculo(Veiculo veiculo) {
        veiculos.remove(veiculo);
    }
    public void aceitarFrete(Frete frete) {
        fretes.add(frete);
    }

    // o que podemos fazer com o fretista?
    public long getQtdFretesConcluidos() {
        return this.fretes.stream().
                filter(f -> f.getStatusFrete().equals(StatusFrete.CONCLUIDO)).count();
    }
}
