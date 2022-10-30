CommandList.push(
    class {
        name = "speed"
        level = 4

        // !speed (float arg)
        function CC(p, args) {
            try {
                SetSpeed(p, args[0].tofloat())
            } catch (exception) {
                EntFireByHandle(p2mm_clientcommand, "Command", "say [ERROR] Input a number.", 0, p, p)
            }
        }
    }
)