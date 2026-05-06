package co.sena.cimm.adso.saludboyaca.model;

import java.time.LocalDateTime;


public class OTP_Tokens {
    
    
    private int id;
    private int id_usuario;
    private String codigo;
    private LocalDateTime fecha_gen;
    private LocalDateTime expira_en;
    private int usado;

    public OTP_Tokens() {
    }

    public OTP_Tokens(int id, int id_usuario, String codigo, LocalDateTime fecha_gen, LocalDateTime expira_en, int usado) {
        this.id = id;
        this.id_usuario = id_usuario;
        this.codigo = codigo;
        this.fecha_gen = fecha_gen;
        this.expira_en = expira_en;
        this.usado = usado;
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

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public LocalDateTime getFecha_gen() {
        return fecha_gen;
    }

    public void setFecha_gen(LocalDateTime fecha_gen) {
        this.fecha_gen = fecha_gen;
    }

    public LocalDateTime getExpira_en() {
        return expira_en;
    }

    public void setExpira_en(LocalDateTime expira_en) {
        this.expira_en = expira_en;
    }

    public int getUsado() {
        return usado;
    }

    public void setUsado(int usado) {
        this.usado = usado;
    }
    
    
}
