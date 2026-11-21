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
            // body: wide ellipse
            double b = ((x-60.0)*(x-60.0))/(26.0*26.0) + ((y-38.0)*(y-38.0))/(14.0*14.0);
            if (b < 1) v = 255;
            // eye bumps: 2 circles on top
            if (sqrt(cast(double)((x-46)*(x-46) + (y-22)*(y-22))) < 8) v = 255;
            if (sqrt(cast(double)((x-74)*(x-74) + (y-22)*(y-22))) < 8) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-46)*(x-46) + (y-22)*(y-22))) < 3) v = 0;
            if (sqrt(cast(double)((x-74)*(x-74) + (y-22)*(y-22))) < 3) v = 0;
            // smile: arc cut out
            double sm = sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32)));
            if (sm > 12 && sm < 14 && y > 32) v = 0;
            // belly: ellipse cut out
            double belly = ((x-60.0)*(x-60.0))/(16.0*16.0) + ((y-42.0)*(y-42.0))/(7.0*7.0);
            if (belly < 1) v = 0;
            // legs: 2 side ellipses
            double l1 = ((x-32.0)*(x-32.0))/(5.0*5.0) + ((y-42.0)*(y-42.0))/(10.0*10.0);
            if (l1 < 1) v = 255;
            double l2 = ((x-88.0)*(x-88.0))/(5.0*5.0) + ((y-42.0)*(y-42.0))/(10.0*10.0);
            if (l2 < 1) v = 255;
            // feet: 2 bars
            if (x >= 28 && x <= 40 && y >= 52 && y <= 54) v = 255;
            if (x >= 80 && x <= 92 && y >= 52 && y <= 54) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm34.ximg", header ~ comp);
    std.file.write("rm34.raw", raw);
    writefln("made rm34.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
