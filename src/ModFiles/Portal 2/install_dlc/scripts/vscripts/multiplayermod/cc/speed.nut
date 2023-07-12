CommandList.push(
    class {
        name = "speed"
        level = 4

        // !speed (float arg)
        function CC(p, args) {
            if (args.len() == 0) {
                SendChatMessage("[ERROR] Input a number.", p)
                return
            }

            args[0] = Strip(args[0]).tofloat()

            if (typeof args[0] != "integer" && typeof args[0] != "float") {
                SendChatMessage("[ERROR] Input a number.", p)
                return
            }

            SetSpeed(p, args[0])
        }
    }
)