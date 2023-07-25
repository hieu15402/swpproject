/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dto;

/**
 *
 * @author sasak
 */
public class SlotDTO {

    private int slot_number;
    private String time_slot;

    public SlotDTO(int slot_number, String time_slot) {
        this.slot_number = slot_number;
        this.time_slot = time_slot.trim();
    }

    public int getSlot_number() {
        return slot_number;
    }

    public void setSlot_number(int slot_number) {
        this.slot_number = slot_number;
    }

    public String getTime_slot() {
        return time_slot.trim();
    }

    public void setTime_slot(String time_slot) {
        this.time_slot = time_slot.trim();
    }

}
