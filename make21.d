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
            double dx = x - 60, dy = y - 32;
            double d = sqrt(dx*dx + dy*dy);
            // canopy: half-circle
            if (d < 28 && y <= 32) v = 255;
            // scalloped bottom edge: cut 3 little half-circles out
            foreach (cx; [38, 60, 82]) {
                double sx = x - cx, sy = y - 32;
                if (sqrt(sx*sx + sy*sy) < 8 && y >= 32) v = 0;
            }
            // stem
            if (x >= 58 && x <= 61 && y >= 32 && y <= 52) v = 255;
            // hook: ring at bottom-left of stem
            double hx = x - 50, hy = y - 52;
            double hd = sqrt(hx*hx + hy*hy);
            if (hd >= 5 && hd <= 8 && y >= 50 && x <= 58) v = 255;
            // ribs
            if ((x == 42 || x == 78) && y >= 10 && y <= 32) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm21.ximg", header ~ comp);
    std.file.write("rm21.raw", raw);
    writefln("made rm21.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
