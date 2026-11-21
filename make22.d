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
            // body: ellipse
            double ex = (x - 60) / 10.0, ey = (y - 32) / 20.0;
            if (ex*ex + ey*ey < 1) v = 255;
            // nose: triangle on top
            if (x >= 50 && x <= 70 && y >= 8 && y <= 22) {
                double dy = y - 32;
                if (dy < 0) dy = -dy;
                if (x >= 60 - (y - 8) * 0.6 && x <= 60 + (y - 8) * 0.6) v = 255;
            }
            // fins: left + right triangles
            if (y >= 42 && y <= 55) {
                if (x >= 40 && x <= 50 && x >= 50 - (y - 42) * 0.8) v = 255;
                if (x >= 70 && x <= 80 && x <= 70 + (y - 42) * 0.8) v = 255;
            }
            // window: black circle cut out
            double wx = x - 60, wy = y - 28;
            if (sqrt(wx*wx + wy*wy) < 4) v = 0;
            // flame: triangle below
            if (x >= 55 && x <= 65 && y >= 54 && y <= 62) {
                double fy = y - 54;
                if (x >= 60 - (8 - fy) * 0.6 && x <= 60 + (8 - fy) * 0.6) v = 255;
            }
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm22.ximg", header ~ comp);
    std.file.write("rm22.raw", raw);
    writefln("made rm22.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
