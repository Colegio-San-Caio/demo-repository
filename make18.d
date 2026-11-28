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
            double dx1 = x - 55, dy1 = y - 32;
            double d1 = sqrt(dx1*dx1 + dy1*dy1);
            double dx2 = x - 68, dy2 = y - 28;
            double d2 = sqrt(dx2*dx2 + dy2*dy2);
            ubyte v = 0;
            // crescent: big circle MINUS offset circle
            if (d1 < 25 && d2 >= 22) v = 255;
            // little star: diamond at top-right
            int sx = x - 88, sy = y - 16;
            if (sx < 0) sx = -sx;
            if (sy < 0) sy = -sy;
            if (sx + sy < 6) v = 255;
            // tiny star dot below it
            int tx = x - 78, ty = y - 30;
            if (tx < 0) tx = -tx;
            if (ty < 0) ty = -ty;
            if (tx + ty < 3) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm18.ximg", header ~ comp);
    std.file.write("rm18.raw", raw);
    writefln("made rm18.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
