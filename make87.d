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
            double b = ((x-60.0)*(x-60.0))/(26.0*26.0) + ((y-38.0)*(y-38.0))/(16.0*16.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 16) v = 255;
            if (sqrt(cast(double)((x-49)*(x-49) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-49)*(x-49) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-71)*(x-71) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-71)*(x-71) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 40 && x <= 46 && y >= 16 && y <= 20) v = 255;
            if (x >= 74 && x <= 80 && y >= 16 && y <= 20) v = 255;
            if (x >= 44 && x <= 76 && y >= 32 && y <= 33) v = 0;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-42)*(y-42))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-42)*(y-42))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-46)*(y-46))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-36)*(x-36) + (y-30)*(y-30))) < 4) v = 255;
            if (sqrt(cast(double)((x-84)*(x-84) + (y-30)*(y-30))) < 4) v = 255;
            if (x >= 36 && x <= 44 && y >= 46 && y <= 54) v = 255;
            if (x >= 76 && x <= 84 && y >= 46 && y <= 54) v = 255;
            if (x >= 24 && x <= 96 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm87.ximg", header ~ comp);
    std.file.write("rm87.raw", raw);
    writefln("made rm87.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
