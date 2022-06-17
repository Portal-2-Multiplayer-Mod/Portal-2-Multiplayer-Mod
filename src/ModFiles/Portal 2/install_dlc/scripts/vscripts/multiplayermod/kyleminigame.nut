pawns <- []

function pawninit() {
    class pawn {

        x = 0
        y = 0

        function update(x, y) {
            x = x
            y = y
        }

        function destroy() {
            if (self in pawns) {
                pawns.remove(pawn)
                return
            }
        }
    }

    pawns.push(pawn())
}

timee <- 60
scale <- 1

function pixel(x,y,r,g,b) {
    print(x + y + r + g + b)
    local pos = Vector(x * scale,y * scale,0)
    local offset = Vector(4170, 3226, -371)
    pos = pos + offset
    local maxs = Vector(1 * scale,1 * scale,0)
    local mins = Vector(-1 * scale,-1 * scale,-0.1)
    DebugDrawBox(pos, mins, maxs, r, g, b, 255, timee)
}


///////////////////////////////////////// I/O

linex <- 0
liney <- 0

HeldData <- []

function UpdatePlayerPos() {
        Entities.FindByName(null, "red").SetOrigin(Vector(linex, liney, -447))

}

function DumpData() {
    local lst = GetAll(HeldData)
    SendChatMessage("Server Requested Data Dump")
    SendChatMessage("Dumping data: " + lst)
    foreach (data in lst) {
        printl(data)
    }
}

LastHeartbeat <- Time() + 10
ServerConnected <- false

function Heartbeat() {
    LastHeartbeat = Time() + 5
    if (ServerConnected == false) {
        SendChatMessage("Connected to server")
        ServerConnected = true
    }
    printl("1")
    SendToConsoleP232("script printl(\"Heartbeat\")")
}

function CheckHeartbeat() {
    if (LastHeartbeat < Time() && ServerConnected) {
        printl("Connection With Server Lost")
        SendChatMessage("Connection With Server Lost")
        ServerConnected = false
    }
}