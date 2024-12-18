package com.zgamelogic.services;

import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@Service
public class ArchipelagoService {
    public void test(){
        ProcessBuilder pb = new ProcessBuilder();
        pb.command("python3", "Archipelago/Generate.py");
        try {
            Process process = pb.start();
            BufferedReader processOutput = new BufferedReader(new InputStreamReader(process.getInputStream()));

            while(process.isAlive()){
                System.out.println(processOutput.readLine());
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
