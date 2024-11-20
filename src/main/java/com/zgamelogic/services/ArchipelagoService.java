package com.zgamelogic.services;

import com.zgamelogic.data.ArchipelagoWorld;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;

@Service
public class ArchipelagoService {
    private final HashMap<String, ArchipelagoWorld> archipelagoGenerations;

    public ArchipelagoService() {
        archipelagoGenerations = new HashMap<>();
    }

    public void generateArchipelago() {
        // TODO get the seed from the process
        String seed = "";

    }

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
