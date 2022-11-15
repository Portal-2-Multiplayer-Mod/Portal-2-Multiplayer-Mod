CommandList.push(
    class {
        name = "noclip"
        level = 4

        // !noclip
        function CC(p, args) {
            local pclass = FindPlayerClass(p)
            if (pclass.noclip) {
                EnableNoclip(false, p)
            } else {
                EnableNoclip(true, p)
            }
        }
    }
)