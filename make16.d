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
            double dx = x - 60;
            ubyte v = 0;
            // body: dome top + straight sides + wavy bottom
            if (dx > -18 && dx < 18) {
                double topY = 28 - sqrt(18*18 - dx*dx); // dome
                double bottomY = 50 + sin(x * 0.6) * 4; // wavy skirt
                if (y >= topY && y <= bottomY) v = 255;
            }
            // eyes: two black dots
            double e1x = x - 53, e1y = y - 28;
            double e2x = x - 67, e2y = y - 28;
            if (sqrt(e1x*e1x + e1y*e1y) < 3) v = 0;
            if (sqrt(e2x*e2x + e2y*e2y) < 3) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm16.ximg", header ~ comp);
    std.file.write("rm16.raw", raw);
    writefln("made rm16.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
