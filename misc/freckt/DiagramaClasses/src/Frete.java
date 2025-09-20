import java.util.ArrayList;
import java.util.List;

public class Frete {
    // atributos
    // o que u frete tem?
    private Localizacao localOrigem, localDestino, localAtual;
    private StatusFrete statusFrete;
    private List<Produto> produtos = new ArrayList<>();

    // construtor
    // o vem assim que instancia um objeto frete?
    public Frete() {
        this.statusFrete = StatusFrete.AGUARDANDO_CONFIRMACAO;
    }

    // metodos
    // o que fazemos com um frete?
    public void adicionarProduto(Produto produto) {
        this.produtos.add(produto);
    }

    public void removerProduto(Produto produto) {
        this.produtos.remove(produto);
    }

    public void setStatusFrete(StatusFrete statusFrete) {
        this.statusFrete = statusFrete;
    }

    public StatusFrete getStatusFrete() {
        return this.statusFrete;
    }
}
