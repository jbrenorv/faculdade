import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public abstract class Usuario {
    // atributos
    // o que fretistas e clientes tem em comum?
    public final List<Frete> fretes = new ArrayList<>();
    public String nome;
    public String email;
    public String contato;
    public String senha;
    public Calendar nascimento;
    public String cidade, bairro;

    // metodos
    // o que, tanto clientes quanto fretistas, fazem?
}
