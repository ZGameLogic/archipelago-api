package com.zgamelogic.controllers;

import com.zgamelogic.services.ArchipelagoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
public class ArchipelagoController {
    private final ArchipelagoService archipelagoService;

    public ArchipelagoController(ArchipelagoService archipelagoService) {
        this.archipelagoService = archipelagoService;
    }

    @PostMapping("generate")
    public ResponseEntity<?> generate(
            @RequestParam(value = "hist cost", required = false) Integer hintCost,
            @RequestPart("file") List<MultipartFile> files
    ){
        String directoryPath = "Archipelago/Players/";
        File directory = new File(directoryPath);
        if (!directory.exists()) directory.mkdirs();

        for (MultipartFile file : files) {
            try {
                String filePath = directory.getAbsolutePath() + "/" + file.getOriginalFilename();
                File destinationFile = new File(filePath);
                file.transferTo(destinationFile);
                log.info("Saved file: {}", destinationFile.getPath());
            } catch (IOException e) {
                log.error("Failed to save file: {}", file.getOriginalFilename(), e);
            }
        }

        // Path to the file you want to return
        String outputFilePath = "Archipelago/output/AP_09341485222687159901.zip";
        File outputFile = new File(outputFilePath);

        if (!outputFile.exists()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("File not found: " + outputFilePath);
        }

        try {
            // Prepare the response with the file and additional JSON response
            InputStreamResource resource = new InputStreamResource(new FileInputStream(outputFile));
            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=AP_09341485222687159901.zip");
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

            // Create a JSON body to accompany the file
            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("message", "Files processed successfully");
            responseBody.put("hintCost", hintCost);
            responseBody.put("fileName", "AP_09341485222687159901.zip");

            // Return the file along with the JSON body
            return ResponseEntity.ok()
                    .headers(headers)
                    .body(resource);

        } catch (IOException e) {
            log.error("Error reading the file: {}", outputFilePath, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Could not read file: " + outputFilePath);
        }
    }
}
