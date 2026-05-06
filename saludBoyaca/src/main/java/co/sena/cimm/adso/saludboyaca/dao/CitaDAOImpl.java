/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.config.ConexionDB;
import co.sena.cimm.adso.saludboyaca.model.Citas;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author julia
 */
public class CitaDAOImpl implements CitaDAO{

    @Override
    public boolean insertar(Citas c) {
        String sql = "INSERT INTO citas (id_paciente, id_medico, id_especialidad, fecha_cita, hora_cita,motivo, estado, observaciones,fecha_registro, id_registrado_por) "
                + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, c.getId_paciente());
            ps.setInt(2, c.getId_medico());
            ps.setInt(3, c.getId_especialidad());
            ps.setTimestamp(4, c.getFecha_cita() != null ? Timestamp.valueOf(c.getFecha_cita()) : null);
            ps.setTime(5, c.getHora_cita());
            ps.setString(6, c.getMotivo());
            
            
            if (c.getEstado() != null && !c.getEstado().isEmpty()) {
                ps.setString(7, c.getEstado().toUpperCase());
            }else{
                ps.setString(7, "PROGRAMADA");
            }
            ps.setString(8, c.getObservaciones());
            
            if (c.getFecha_registro() != null) {
                ps.setTimestamp(9, Timestamp.valueOf(c.getFecha_registro()));
            } else {
                ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            }
            
            ps.setInt(10, c.getId_registrado_por());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Citas> listarPorPaciente(int idPaciente) {
        List<Citas> lista = new ArrayList<>();
        String sql = "SELECT * FROM citas WHERE id_paciente = ? ORDER BY fecha_cita DESC";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPaciente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()){
                    lista.add(mapearCita(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public List<Citas> listarTodas() {
        List<Citas> lista = new ArrayList<>();
        String sql = "SELECT * FROM citas ORDER BY fecha_cita DESC";
        try (Connection con = ConexionDB.getConexion();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while(rs.next()){
                lista.add(mapearCita(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public boolean cambiarEstado(int idCita, String nuevoEstado) {
        String sql = "UPDATE citas SET estado = ? WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado.toUpperCase());
            ps.setInt(2, idCita);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean eliminar(int idCita) {
        String sql = "DELETE FROM citas WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCita);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    @Override
public Citas buscarPorId(int id) {
    String sql = "SELECT c.*, u.nombres AS nombre_paciente FROM citas c " +
                 "LEFT JOIN usuarios u ON c.id_paciente = u.id WHERE c.id = ?";
    try (Connection con = ConexionDB.getConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return mapearCita(rs); 
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

    @Override
public List<Citas> listarPorMedico(int idMedico) {
    List<Citas> lista = new ArrayList<>();
    String sql = "SELECT c.*, u.nombres AS nombre_paciente " +
                 "FROM citas c " +
                 "LEFT JOIN usuarios u ON c.id_paciente = u.id " + 
                 "WHERE c.id_medico = ? " +
                 "ORDER BY c.fecha_cita ASC, c.hora_cita ASC";
    try (Connection con = ConexionDB.getConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, idMedico);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Citas c = mapearCita(rs);
                c.setNombre_paciente(rs.getString("nombre_paciente")); 
                lista.add(c);
            }
        }
    } catch (SQLException e) { e.printStackTrace(); }
    return lista;
}

    @Override
public boolean actualizar(Citas c) {
    String sql = "UPDATE citas SET id_paciente=?, id_especialidad=?, fecha_cita=?, "
               + "hora_cita=?, motivo=?, observaciones=?, estado=? WHERE id=?";
    try (Connection con = ConexionDB.getConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, c.getId_paciente());
        ps.setInt(2, c.getId_especialidad());
        ps.setTimestamp(3, c.getFecha_cita() != null ? Timestamp.valueOf(c.getFecha_cita()) : null);
        ps.setTime(4, c.getHora_cita());
        ps.setString(5, c.getMotivo());
        ps.setString(6, c.getObservaciones());
        ps.setString(7, c.getEstado()); 
        ps.setInt(8, c.getId());
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    private Citas mapearCita(ResultSet rs) throws SQLException {
    Citas c = new Citas();
    c.setId(rs.getInt("id"));
    c.setId_paciente(rs.getInt("id_paciente"));
    c.setId_medico(rs.getInt("id_medico"));
    c.setId_especialidad(rs.getInt("id_especialidad"));

    if (rs.getTimestamp("fecha_cita") != null) {
        c.setFecha_cita(rs.getTimestamp("fecha_cita").toLocalDateTime());
    }
    c.setHora_cita(rs.getTime("hora_cita"));
    c.setMotivo(rs.getString("motivo"));
    c.setEstado(rs.getString("estado"));
    c.setObservaciones(rs.getString("observaciones"));

    if (rs.getTimestamp("fecha_registro") != null) {
        c.setFecha_registro(rs.getTimestamp("fecha_registro").toLocalDateTime());
    }
    c.setId_registrado_por(rs.getInt("id_registrado_por"));

    try {
        String nombre = rs.getString("nombre_paciente");
        if (nombre != null) {
            c.setNombre_paciente(nombre);
        }
    } catch (SQLException e) {
        c.setNombre_paciente("No disponible");
    }

    return c;
}
    
}
