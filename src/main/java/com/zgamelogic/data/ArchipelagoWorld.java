package com.zgamelogic.data;

import lombok.Getter;

@Getter
public class ArchipelagoWorld {
    private final String seed;
    private final String statusURL;
    private final String logURL;

    private boolean completed;

    public ArchipelagoWorld(String logURL, String seed, String statusURL) {
        this.logURL = logURL;
        this.seed = seed;
        this.statusURL = statusURL;
        completed = false;
    }

    public void completedGeneration(){
        completed = true;
    }
}
