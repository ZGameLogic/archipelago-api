package com.zgamelogic.application.controllers;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@Controller
@Slf4j
public class TestController {
    @PostConstruct
    public void init() {
        log.info("Running generate.py");
        try {
            // Define the path to the Python interpreter and the script
            String pythonPath = "python3"; // or the full path to python, e.g., "C:\\Python39\\python.exe"
            String scriptPath = "../Archipelago/Generate.py"; // Replace with the actual path to your Python script

            // Create a ProcessBuilder to run the Python script
            ProcessBuilder processBuilder = new ProcessBuilder(pythonPath, scriptPath);

            // Redirect error stream to output stream to capture error messages
            processBuilder.redirectErrorStream(true);

            // Start the process
            Process process = processBuilder.start();

            // Capture the output from the Python script
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line); // Print the output from the Python script
            }

            // Wait for the process to exit and get the exit code
            int exitCode = process.waitFor();
            System.out.println("Python script exited with code: " + exitCode);
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
