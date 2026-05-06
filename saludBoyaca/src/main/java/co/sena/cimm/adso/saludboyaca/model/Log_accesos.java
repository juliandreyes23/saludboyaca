package co.sena.cimm.adso.saludboyaca.model;

import java.time.LocalDateTime;


public class Log_accesos {
    
    
    private int id;
    private int id_usuario;
    private String username;
    private String accion;
    private String ip;
    private String resultado;
    private LocalDateTime fecha;

    public Log_accesos() {
    }

    public Log_accesos(int id, int id_usuario, String username, String accion, String ip, String resultado, LocalDateTime fecha) {
        this.id = id;
        this.id_usuario = id_usuario;
        this.username = username;
        this.accion = accion;
        this.ip = ip;
        this.resultado = resultado;
        this.fecha = fecha;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getResultado() {
        return resultado;
    }

    public void setResultado(String resultado) {
        this.resultado = resultado;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }
    
    
}
