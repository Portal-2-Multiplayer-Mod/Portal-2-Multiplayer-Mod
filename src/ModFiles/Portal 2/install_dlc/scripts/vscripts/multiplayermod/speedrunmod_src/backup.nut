//Save-load backup system
//Prevents mod-specific informations to be stored or lost between saves
//it uses the fact that save file saves the state of scripts

SLBS_initiated <- false
SLBS_key <- "";
SLBS_params <- {};
SLBS_mode <- 0;



function SLBS_Backup(){
    if(!SLBS_initiated){
        //sets the key
        SLBS_key = RandomInt(100000000,999999999)+"";
        smsm.SetBackupKey(SLBS_key);

        modlog("Created mode parameters backup with random key '"+SLBS_key+"'.");
        SLBS_initiated = true;
    }

    if(smsm.AreModeParamsChanged()){
        //backups mode and parameters
        SLBS_mode = smsm.GetMode();
        
        local paramLen = smsm.GetModeParamsNumber();
        local params = {};
        for(local i=0;i<paramLen;i++){
            params[i] <- smsm.GetModeParam(i);
        }
        SLBS_params = params;
    }
    
}

//this function is plugged into main loop
function SLBS_Check(){
    if(SLBS_initiated && SLBS_key != smsm.GetBackupKey()){
        modlog("Backup key variance detected ("+SLBS_key +" <-> "+ smsm.GetBackupKey()+"). Restoring variables...");

        smsm.SetBackupKey(SLBS_key);
        //restore mode and parameters
        smsm.SetMode(SLBS_mode);
        
        local paramLen = smsm.GetModeParamsNumber();
        for(local i=0;i<paramLen;i++){
            smsm.SetModeParam(i, SLBS_params[i]);
        }
    }
    SLBS_Backup();
}