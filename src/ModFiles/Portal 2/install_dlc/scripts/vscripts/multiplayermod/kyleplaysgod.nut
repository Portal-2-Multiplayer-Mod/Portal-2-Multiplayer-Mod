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