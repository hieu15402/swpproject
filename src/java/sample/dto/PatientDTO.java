/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dto;

/**
 *
 * @author MSI AD
 */
public class PatientDTO {

    private String patient_id;
    private String name;
    private String species_id;
    private String age;
    private String gender;
    private String image;
    private String user_name;
    private boolean status;

    public PatientDTO(String patient_id, String name, String species_id, String age, String gender, String image, String user_name, boolean status) {
        this.patient_id = patient_id;
        this.name = name;
        this.species_id = species_id;
        this.age = age;
        this.gender = gender;
        this.image = image;
        this.user_name = user_name;
        this.status = status;
    }

    public PatientDTO() {
    }

    public String getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(String patient_id) {
        this.patient_id = patient_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecies_id() {
        return species_id;
    }

    public void setSpecies_id(String species_id) {
        this.species_id = species_id;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "PatientDTO{" + "patient_id=" + patient_id + ", name=" + name + ", species_id=" + species_id + ", age=" + age + ", gender=" + gender + ", image=" + image + ", user_name=" + user_name + ", status=" + status + '}';
    }

}
