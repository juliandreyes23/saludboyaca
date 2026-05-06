package co.sena.cimm.adso.saludboyaca.model;

import java.sql.Time;


public class Horarios {
    
    private int id;
    private int id_medico;
    private int dia_semana;
    private Time hora_inicio;
    private Time hora_fin;
    private int max_citas;

    public Horarios() {
    }

    public Horarios(int id, int id_medico, int dia_semana, Time hora_inicio, Time hora_fin, int max_citas) {
        this.id = id;
        this.id_medico = id_medico;
        this.dia_semana = dia_semana;
        this.hora_inicio = hora_inicio;
        this.hora_fin = hora_fin;
        this.max_citas = max_citas;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_medico() {
        return id_medico;
    }

    public void setId_medico(int id_medico) {
        this.id_medico = id_medico;
    }

    public int getDia_semana() {
        return dia_semana;
    }

    public void setDia_semana(int dia_semana) {
        this.dia_semana = dia_semana;
    }

    public Time getHora_inicio() {
        return hora_inicio;
    }

    public void setHora_inicio(Time hora_inicio) {
        this.hora_inicio = hora_inicio;
    }

    public Time getHora_fin() {
        return hora_fin;
    }

    public void setHora_fin(Time hora_fin) {
        this.hora_fin = hora_fin;
    }

    public int getMax_citas() {
        return max_citas;
    }

    public void setMax_citas(int max_citas) {
        this.max_citas = max_citas;
    }

    
    
    
}
