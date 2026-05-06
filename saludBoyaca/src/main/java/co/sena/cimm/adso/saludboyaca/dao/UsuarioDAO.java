package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.model.Usuarios;
import java.util.List;


public interface UsuarioDAO {
    
    Usuarios validarLogin (String email, String pass);
    Usuarios buscarPorId (int id);
    List<Usuarios> listarTodos();
    boolean actualizarPreferenciaIdioma(int idUsuario, String lang);
    Usuarios buscarPorUsername (String username);
}
