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
            double b = ((x-60.0)*(x-60.0))/(30.0*30.0) + ((y-40.0)*(y-40.0))/(16.0*16.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-30)*(y-30))) < 19) v = 255;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-40)*(x-40) + (y-30)*(y-30))) < 3) v = 0;
            if (sqrt(cast(double)((x-80)*(x-80) + (y-30)*(y-30))) < 3) v = 0;
            if (x >= 38 && x <= 82 && y >= 34 && y <= 35) v = 0;
            if (x >= 44 && x <= 76 && y >= 48 && y <= 50) v = 0;
            if (x >= 32 && x <= 40 && y >= 44 && y <= 56) v = 255;
            if (x >= 80 && x <= 88 && y >= 44 && y <= 56) v = 255;
            if (x >= 20 && x <= 100 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm74.ximg", header ~ comp);
    std.file.write("rm74.raw", raw);
    writefln("made rm74.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
