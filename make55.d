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
            // snake body: wavy sine curve - thick line
            double cy = 38 + 12 * sin((x - 20) * 0.08);
            if (abs(y - cy) < 5) v = 255;
            // head: circle at right end
            if (sqrt(cast(double)((x-96)*(x-96) + (y-32)*(y-32))) < 8) v = 255;
            // tongue: forked - 2 small bars
            if (x >= 102 && x <= 108 && y >= 30 && y <= 32) v = 255;
            if (x >= 102 && x <= 108 && y >= 34 && y <= 36) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-96)*(x-96) + (y-30)*(y-30))) < 2) v = 0;
            // spots: black dots along body
            if (sqrt(cast(double)((x-36)*(x-36) + (y-42)*(y-42))) < 2) v = 0;
            if (sqrt(cast(double)((x-52)*(x-52) + (y-32)*(y-32))) < 2) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-44)*(y-44))) < 2) v = 0;
            if (sqrt(cast(double)((x-82)*(x-82) + (y-34)*(y-34))) < 2) v = 0;
            // tail: taper left
            if (x >= 14 && x <= 22 && y >= 36 && y <= 40) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm55.ximg", header ~ comp);
    std.file.write("rm55.raw", raw);
    writefln("made rm55.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
