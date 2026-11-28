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
            double b = ((x-60.0)*(x-60.0))/(30.0*30.0) + ((y-40.0)*(y-40.0))/(17.0*17.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-30)*(y-30))) < 19) v = 255;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 40 && x <= 56 && y >= 16 && y <= 18) v = 255;
            if (x >= 64 && x <= 80 && y >= 16 && y <= 18) v = 255;
            if (sqrt(cast(double)((x-38)*(x-38) + (y-30)*(y-30))) < 4) v = 255;
            if (sqrt(cast(double)((x-82)*(x-82) + (y-30)*(y-30))) < 4) v = 255;
            if (x >= 38 && x <= 82 && y >= 34 && y <= 35) v = 0;
            if (sqrt(cast(double)((x-52)*(x-52) + (y-42)*(y-42))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-42)*(y-42))) < 1.5) v = 0;
            if (x >= 34 && x <= 42 && y >= 46 && y <= 56) v = 255;
            if (x >= 78 && x <= 86 && y >= 46 && y <= 56) v = 255;
            if (x >= 22 && x <= 98 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm81.ximg", header ~ comp);
    std.file.write("rm81.raw", raw);
    writefln("made rm81.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
