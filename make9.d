import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;
import std.random;

void main() {
    int w = 120, h = 64;
    int cw = 8, ch = 8;
    int cols = w / cw; // 15
    int rows = h / ch; // 8
    auto rnd = Random(12345);

    // walls: true = wall exists
    bool[][] vwall = new bool[][](rows, cols + 1);
    bool[][] hwall = new bool[][](rows + 1, cols);
    // outer border
    foreach (r; 0..rows) { vwall[r][0] = true; vwall[r][cols] = true; }
    foreach (c; 0..cols) { hwall[0][c] = true; hwall[rows][c] = true; }
    // random inner walls
    foreach (r; 0..rows) foreach (c; 0..cols) {
        if (c < cols) vwall[r][c+1] = uniform(0, 2, rnd) == 0;
        if (r < rows) hwall[r+1][c] = uniform(0, 2, rnd) == 0;
    }
    // always keep an entrance / exit open
    hwall[0][0] = false;
    hwall[rows][cols-1] = false;

    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            int cx = x / cw, cy = y / ch;
            int lx = x % cw, ly = y % ch;
            ubyte v = 255; // white corridor
            if (lx == 0 && vwall[cy][cx]) v = 0;
            if (ly == 0 && hwall[cy][cx]) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm9.ximg", header ~ comp);
    std.file.write("rm9.raw", raw);
    writefln("made rm9.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
