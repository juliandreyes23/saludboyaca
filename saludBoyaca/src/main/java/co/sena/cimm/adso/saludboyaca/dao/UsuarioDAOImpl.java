package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.config.ConexionDB;
import co.sena.cimm.adso.saludboyaca.model.Usuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class UsuarioDAOImpl implements UsuarioDAO{

    @Override
    public Usuarios validarLogin(String email, String pass) {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, pass);
            try (ResultSet rs = ps.executeQuery()){
                if(rs.next()){
                    return mapearUsuario(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Usuarios buscarPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try(ResultSet rs = ps.executeQuery()){
                if(rs.next()) return mapearUsuario(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Usuarios> listarTodos() {
        List<Usuarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (Connection con = ConexionDB.getConexion();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) lista.add(mapearUsuario(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public boolean actualizarPreferenciaIdioma(int idUsuario, String lang) {
        String sql = "UPDATE usuarios SET lang_preferido = ? WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, lang);
            ps.setInt(2, idUsuario);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
public Usuarios buscarPorUsername(String username) {
    String sql = "SELECT * FROM usuarios WHERE username = ?";
    try (Connection con = ConexionDB.getConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setString(1, username);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Usuarios user = mapearUsuario(rs);
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setActivo(rs.getInt("activo"));
                return user;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

    private Usuarios mapearUsuario(ResultSet rs) throws SQLException{
        Usuarios u = new Usuarios();
        u.setId(rs.getInt("id"));
        u.setNombres(rs.getString("nombres"));
        u.setApellidos(rs.getString("apellidos"));
        u.setEmail(rs.getString("email"));
        u.setRol(rs.getString("rol"));
        u.setLang_preferido(rs.getString("lang_preferido"));
        return u;
    }
    
    
}
