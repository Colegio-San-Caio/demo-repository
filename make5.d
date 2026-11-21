import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;

void main() {
    int w = 120, h = 64;
    int cx = 60, cy = 32;
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            int dx = x - cx;
            int dy = y - cy;
            int d2 = dx*dx + dy*dy;
            // default black
            ubyte v = 0;
            // face: white circle r=28
            if (d2 <= 28*28) v = 255;
            // eyes: black circles at (48,24) and (72,24) r=4
            int ex1 = x - 48, ey1 = y - 24;
            int ex2 = x - 72, ey2 = y - 24;
            if (ex1*ex1 + ey1*ey1 <= 16) v = 0;
            if (ex2*ex2 + ey2*ey2 <= 16) v = 0;
            // smile: black arc, y below center, radius 16-20
            if (dy > 2 && d2 >= 16*16 && d2 <= 20*20) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm5.ximg", header ~ comp);
    std.file.write("rm5.raw", raw);
    writefln("made rm5.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
