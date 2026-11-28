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
            double b = ((x-60.0)*(x-60.0))/(30.0*30.0) + ((y-38.0)*(y-38.0))/(18.0*18.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 18) v = 255;
            if (x >= 60 && x <= 90 && y >= 28 && y <= 44) {
                if (fabs(cast(double)(y-36)) < (x-60)*0.5) v = 0;
            }
            if (sqrt(cast(double)((x-50)*(x-50) + (y-18)*(y-18))) < 4) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-18)*(y-18))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-18)*(y-18))) < 4) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-18)*(y-18))) < 1.5) v = 0;
            if (x >= 38 && x <= 46 && y >= 50 && y <= 56) v = 255;
            if (x >= 74 && x <= 82 && y >= 50 && y <= 56) v = 255;
            if (x >= 28 && x <= 92 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm73.ximg", header ~ comp);
    std.file.write("rm73.raw", raw);
    writefln("made rm73.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
