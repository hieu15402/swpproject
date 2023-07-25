/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

/**
 *
 * @author Minh
 */
public class OtpManager {

    private int otpvalue;

    public void generateOtp() {
        Random rand = new Random();
        otpvalue = rand.nextInt(900000) + 100000;

        // Schedule a timer to remove otpvalue after 60 seconds
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                otpvalue = 0;
                timer.cancel(); // Cancel the timer after otpvalue is removed
            }
        }, 60000); // 60 seconds
    }

    public int getOtpValue() {
        return otpvalue;
    }

    // Rest of the code...
}
