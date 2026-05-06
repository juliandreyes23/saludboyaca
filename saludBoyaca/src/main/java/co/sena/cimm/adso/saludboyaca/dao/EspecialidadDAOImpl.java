/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.config.ConexionDB;
import co.sena.cimm.adso.saludboyaca.model.Especialidades;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author julia
 */
public class EspecialidadDAOImpl implements EspecialidadDAO{

    @Override
    public List<Especialidades> listarTodas() {
        List<Especialidades> lista = new ArrayList<>();
        String sql = "SELECT * FROM especialidades";
        try (Connection con = ConexionDB.getConexion();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while(rs.next()){
                lista.add(mapearEspecialidad(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Especialidades buscarPorId(int id) {
        String sql = "SELECT * FROM especialidades WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try(ResultSet rs = ps.executeQuery()){
                if(rs.next()) 
                    return mapearEspecialidad(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Especialidades mapearEspecialidad(ResultSet rs) throws SQLException{
        Especialidades e = new Especialidades();
        e.setId(rs.getInt("id"));
        e.setNombre(rs.getString("nombre"));
        e.setDescripcion(rs.getString("descripcion"));
        return e;
    }
    
}
