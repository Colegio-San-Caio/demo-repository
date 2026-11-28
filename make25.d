import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;
import std.math;

void main() {
    int w = 120, h = 64;
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            ubyte v = 0;
            // walls: square
            if (x >= 35 && x <= 85 && y >= 30 && y <= 58) v = 255;
            // roof: triangle
            if (y >= 8 && y <= 30 && x >= 60 - (y - 8) * 1.8 && x <= 60 + (y - 8) * 1.8) v = 255;
            // door: black rectangle cut out
            if (x >= 54 && x <= 66 && y >= 42 && y <= 58) v = 0;
            // window: black square cut out
            if (x >= 70 && x <= 80 && y >= 36 && y <= 46) v = 0;
            // window cross: white lines back in
            if ((x == 75 && y >= 36 && y <= 46) || (y == 41 && x >= 70 && x <= 80)) v = 255;
            // chimney
            if (x >= 76 && x <= 84 && y >= 12 && y <= 24) v = 255;
            // doorknob: white dot
            if (sqrt(cast(double)((x-64)*(x-64) + (y-50)*(y-50))) < 1.5) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm25.ximg", header ~ comp);
    std.file.write("rm25.raw", raw);
    writefln("made rm25.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
