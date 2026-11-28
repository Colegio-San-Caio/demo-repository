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
            double b = ((x-56.0)*(x-56.0))/(22.0*22.0) + ((y-38.0)*(y-38.0))/(12.0*12.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-76)*(x-76) + (y-34)*(y-34))) < 10) v = 255;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-24)*(y-24))) < 4) v = 255;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-24)*(y-24))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-82)*(x-82) + (y-24)*(y-24))) < 4) v = 255;
            if (sqrt(cast(double)((x-82)*(x-82) + (y-24)*(y-24))) < 1.5) v = 0;
            if (x >= 28 && x <= 90 && y >= 52 && y <= 54) v = 255;
            if (x >= 40 && x <= 44 && y >= 46 && y <= 54) v = 255;
            if (x >= 58 && x <= 62 && y >= 46 && y <= 54) v = 255;
            if (sqrt(cast(double)((x-42)*(x-42) + (y-54)*(y-54))) < 3) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-54)*(y-54))) < 3) v = 255;
            if (x >= 74 && x <= 82 && y >= 38 && y <= 40) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm65.ximg", header ~ comp);
    std.file.write("rm65.raw", raw);
    writefln("made rm65.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
