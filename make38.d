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
            // ears: 2 circles on sides
            if (sqrt(cast(double)((x-40)*(x-40) + (y-32)*(y-32))) < 8) v = 255;
            if (sqrt(cast(double)((x-80)*(x-80) + (y-32)*(y-32))) < 8) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 18) v = 255;
            // face: heart-ish cut out - 2 circles + muzzle
            if (sqrt(cast(double)((x-54)*(x-54) + (y-28)*(y-28))) < 8) v = 0;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-28)*(y-28))) < 8) v = 0;
            double mz = ((x-60.0)*(x-60.0))/(10.0*10.0) + ((y-38.0)*(y-38.0))/(6.0*6.0);
            if (mz < 1) v = 0;
            // eyes: 2 black dots on face
            if (sqrt(cast(double)((x-54)*(x-54) + (y-28)*(y-28))) < 2) v = 255;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-28)*(y-28))) < 2) v = 255;
            // nose: 2 tiny dots
            if (sqrt(cast(double)((x-58)*(x-58) + (y-37)*(y-37))) < 1.2) v = 255;
            if (sqrt(cast(double)((x-62)*(x-62) + (y-37)*(y-37))) < 1.2) v = 255;
            // smile: arc cut out in muzzle - actually black arc
            double sm = sqrt(cast(double)((x-60)*(x-60) + (y-36)*(y-36)));
            if (sm > 4 && sm < 6 && y > 38) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm38.ximg", header ~ comp);
    std.file.write("rm38.raw", raw);
    writefln("made rm38.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
