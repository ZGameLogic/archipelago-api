package com.zgamelogic.controllers;

import com.zgamelogic.services.ArchipelagoService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ArchipelagoController {
    private final ArchipelagoService archipelagoService;

    public ArchipelagoController(ArchipelagoService archipelagoService) {
        this.archipelagoService = archipelagoService;
    }

    @PostMapping("generate")
    public void generate(){
        archipelagoService.test();
    }
}
