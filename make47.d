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
            // wool: big fluffy circle cluster - main body
            if (sqrt(cast(double)((x-56)*(x-56) + (y-38)*(y-38))) < 22) v = 255;
            if (sqrt(cast(double)((x-40)*(x-40) + (y-34)*(y-34))) < 10) v = 255;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-34)*(y-34))) < 10) v = 255;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-22)*(y-22))) < 10) v = 255;
            if (sqrt(cast(double)((x-64)*(x-64) + (y-22)*(y-22))) < 10) v = 255;
            // head: black circle right
            if (sqrt(cast(double)((x-82)*(x-82) + (y-30)*(y-30))) < 10) v = 0;
            // ear: small bar
            if (x >= 72 && x <= 78 && y >= 28 && y <= 32) v = 0;
            // eye: white dot on head
            if (sqrt(cast(double)((x-84)*(x-84) + (y-28)*(y-28))) < 2) v = 255;
            // legs: 4 bars
            if (x >= 40 && x <= 44 && y >= 54 && y <= 60) v = 255;
            if (x >= 52 && x <= 56 && y >= 54 && y <= 60) v = 255;
            if (x >= 62 && x <= 66 && y >= 54 && y <= 60) v = 255;
            if (x >= 70 && x <= 74 && y >= 54 && y <= 60) v = 255;
            // tail: small circle left
            if (sqrt(cast(double)((x-34)*(x-34) + (y-38)*(y-38))) < 5) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm47.ximg", header ~ comp);
    std.file.write("rm47.raw", raw);
    writefln("made rm47.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
