if (IsOnSingleplayerMaps) {
    // We had to modify this source file a little bit, but
    // nothing changed severely in terms of in-game functionality
    IncludeScript("multiplayermod/speedrunmod_src/speedrunmod")
    OnPostSpawn()
}
