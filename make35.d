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
            // shell: wide ellipse
            double s = ((x-60.0)*(x-60.0))/(28.0*28.0) + ((y-34.0)*(y-34.0))/(18.0*18.0);
            if (s < 1) v = 255;
            // shell pattern: 3 black dots
            if (sqrt(cast(double)((x-48)*(x-48) + (y-30)*(y-30))) < 3) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-26)*(y-26))) < 3) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-30)*(y-30))) < 3) v = 0;
            if (sqrt(cast(double)((x-54)*(x-54) + (y-40)*(y-40))) < 3) v = 0;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-40)*(y-40))) < 3) v = 0;
            // head: circle on right
            if (sqrt(cast(double)((x-94)*(x-94) + (y-32)*(y-32))) < 7) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-96)*(x-96) + (y-30)*(y-30))) < 1.8) v = 0;
            // tail: small triangle on left
            if (x >= 28 && x <= 34 && y >= 30 + (x - 28) * 0.3 && y <= 36 - (x - 28) * 0.3) v = 255;
            // legs: 4 small ellipses
            double l1 = ((x-46.0)*(x-46.0))/(4.0*4.0) + ((y-52.0)*(y-52.0))/(4.0*4.0);
            if (l1 < 1) v = 255;
            double l2 = ((x-74.0)*(x-74.0))/(4.0*4.0) + ((y-52.0)*(y-52.0))/(4.0*4.0);
            if (l2 < 1) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm35.ximg", header ~ comp);
    std.file.write("rm35.raw", raw);
    writefln("made rm35.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
