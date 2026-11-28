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
            // ears: 2 circles on top
            if (sqrt(cast(double)((x-44)*(x-44) + (y-18)*(y-18))) < 8) v = 255;
            if (sqrt(cast(double)((x-76)*(x-76) + (y-18)*(y-18))) < 8) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 18) v = 255;
            // muzzle: ellipse cut out
            double mz = ((x-60.0)*(x-60.0))/(10.0*10.0) + ((y-38.0)*(y-38.0))/(7.0*7.0);
            if (mz < 1) v = 0;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-54)*(x-54) + (y-28)*(y-28))) < 2) v = 0;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-28)*(y-28))) < 2) v = 0;
            // nose: dot back on muzzle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-36)*(y-36))) < 2.5) v = 255;
            // mouth: arc
            double sm = sqrt(cast(double)((x-60)*(x-60) + (y-38)*(y-38)));
            if (sm > 3 && sm < 5 && y > 40) v = 255;
            // body: ellipse below head
            double b = ((x-60.0)*(x-60.0))/(16.0*16.0) + ((y-54.0)*(y-54.0))/(8.0*8.0);
            if (b < 1) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm41.ximg", header ~ comp);
    std.file.write("rm41.raw", raw);
    writefln("made rm41.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
