/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.config.ConexionDB;
import co.sena.cimm.adso.saludboyaca.model.Horarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author julia
 */
public class HorarioDAOImpl implements HorarioDAO {

    @Override
    public List<Horarios> listarPorMedico(int idMedico) {
        List<Horarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM horarios WHERE id_medico = ?";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idMedico);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearHorario(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public List<Horarios> listarTodos() {
        List<Horarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM horarios";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearHorario(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public List<String> obtenerHorasDisponibles(int idMedico, String fecha) {
        List<String> horasDisponibles = new ArrayList<>();
        String sql = "SELECT hora_inicio, hora_fin FROM horarios WHERE id_medico = ? AND dia_semana = DAYNAME(?)";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idMedico);
            ps.setString(2, fecha);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    horasDisponibles.add(rs.getString("hora_inicio") + " - Disponible");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return horasDisponibles;
    }

    private Horarios mapearHorario(ResultSet rs) throws SQLException {
    Horarios h = new Horarios();
    h.setId(rs.getInt("id"));
    h.setId_medico(rs.getInt("id_medico"));
    h.setDia_semana(rs.getInt("dia_semana")); 
    h.setHora_inicio(rs.getTime("hora_inicio"));
    h.setHora_fin(rs.getTime("hora_fin"));
    h.setMax_citas(rs.getInt("max_citas"));
    return h;
}

}
