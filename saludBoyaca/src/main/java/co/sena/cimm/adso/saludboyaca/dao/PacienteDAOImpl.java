package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.config.ConexionDB;
import co.sena.cimm.adso.saludboyaca.model.Pacientes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PacienteDAOImpl implements PacienteDAO {

    @Override
    public boolean insertar(Pacientes p) {
        String sql = "INSERT INTO pacientes (nombres, apellidos, documento, fecha_nacimiento, telefono, email, eps, vereda_barrio) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getNombres());
            ps.setString(2, p.getApellidos());
            ps.setString(3, p.getDocumento());
            ps.setDate(4, p.getFechaNacimiento() != null ? Date.valueOf(p.getFechaNacimiento()) : null);
            ps.setString(5, p.getTelefono());
            ps.setString(6, p.getEmail());
            ps.setString(7, p.getEps());
            ps.setString(8, p.getVeredaBarrio());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean actualizar(Pacientes p) {
        String sql = "UPDATE pacientes SET nombres=?, apellidos=?, documento=?, fecha_nacimiento=?, telefono=?, email=?, eps=?, vereda_barrio=? WHERE id=?";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getNombres());
            ps.setString(2, p.getApellidos());
            ps.setString(3, p.getDocumento());
            ps.setDate(4, p.getFechaNacimiento() != null ? Date.valueOf(p.getFechaNacimiento()) : null);
            ps.setString(5, p.getTelefono());
            ps.setString(6, p.getEmail());
            ps.setString(7, p.getEps());
            ps.setString(8, p.getVeredaBarrio());
            ps.setInt(9, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM pacientes WHERE id = ?";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Pacientes buscarPorDocumento(String documento) {
        String sql = "SELECT * FROM pacientes WHERE documento = ?";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, documento);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearPaciente(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Pacientes buscarPorId(int id) {
        String sql = "SELECT * FROM pacientes WHERE id = ?";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearPaciente(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Pacientes> listarTodos() {
        List<Pacientes> lista = new ArrayList<>();
        String sql = "SELECT * FROM pacientes ORDER BY apellidos, nombres";
        try (Connection con = ConexionDB.getConexion(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(mapearPaciente(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public List<String> listarEps() {
        List<String> lista = new ArrayList<>();
        lista.add("Nueva EPS");
        lista.add("Sanitas");
        lista.add("Sura");
        lista.add("Compensar");
        lista.add("Famisanar");
        lista.add("Salud Total");
        lista.add("Coosalud");
        lista.add("Medimás");
        lista.add("Aliansalud");
        lista.add("Cajacopi");
        lista.add("Comfenalco Valle");
        lista.add("Mutual Ser");
        lista.add("Emssanar");
        lista.add("Coosalud");
        lista.add("Sisben / Subsidiado");
        return lista;
    }

    private Pacientes mapearPaciente(ResultSet rs) throws SQLException {
        Pacientes p = new Pacientes();
        p.setId(rs.getInt("id"));
        p.setNombres(rs.getString("nombres"));
        p.setApellidos(rs.getString("apellidos"));
        p.setDocumento(rs.getString("documento"));
        Date fecha = rs.getDate("fecha_nacimiento");
        if (fecha != null) {
            p.setFechaNacimiento(fecha.toLocalDate());
        }
        p.setTelefono(rs.getString("telefono"));
        p.setEmail(rs.getString("email"));
        p.setEps(rs.getString("eps"));
        p.setVeredaBarrio(rs.getString("vereda_barrio"));
        return p;
    }
}
