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
            // ears: 2 tall ellipses
            double e1 = ((x-50.0)*(x-50.0))/(4.0*4.0) + ((y-16.0)*(y-16.0))/(12.0*12.0);
            if (e1 < 1) v = 255;
            double e2 = ((x-70.0)*(x-70.0))/(4.0*4.0) + ((y-16.0)*(y-16.0))/(12.0*12.0);
            if (e2 < 1) v = 255;
            // inner ears: cut out
            double i1 = ((x-50.0)*(x-50.0))/(1.5*1.5) + ((y-16.0)*(y-16.0))/(8.0*8.0);
            if (i1 < 1) v = 0;
            double i2 = ((x-70.0)*(x-70.0))/(1.5*1.5) + ((y-16.0)*(y-16.0))/(8.0*8.0);
            if (i2 < 1) v = 0;
            // head: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 16) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-54)*(x-54) + (y-30)*(y-30))) < 2) v = 0;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-30)*(y-30))) < 2) v = 0;
            // nose: small triangle
            if (x >= 58 && x <= 62 && y >= 35 && y <= 35 + (2 - abs(x - 60)) * 1.5) v = 0;
            // teeth: bar below nose
            if (x >= 58 && x <= 62 && y >= 40 && y <= 44) v = 0;
            // whiskers: cut out lines
            if (y == 34 && x >= 36 && x <= 44) v = 0;
            if (y == 38 && x >= 36 && x <= 44) v = 0;
            if (y == 34 && x >= 76 && x <= 84) v = 0;
            if (y == 38 && x >= 76 && x <= 84) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm36.ximg", header ~ comp);
    std.file.write("rm36.raw", raw);
    writefln("made rm36.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
