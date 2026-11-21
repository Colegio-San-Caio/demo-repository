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
            // floppy ears: 2 ellipses on sides
            double e1 = ((x-38.0)*(x-38.0))/(8.0*8.0) + ((y-30.0)*(y-30.0))/(16.0*16.0);
            if (e1 < 1) v = 255;
            double e2 = ((x-82.0)*(x-82.0))/(8.0*8.0) + ((y-30.0)*(y-30.0))/(16.0*16.0);
            if (e2 < 1) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-30)*(y-30))) < 20) v = 255;
            // muzzle: ellipse
            double m = ((x-60.0)*(x-60.0))/(13.0*13.0) + ((y-38.0)*(y-38.0))/(8.0*8.0);
            if (m < 1) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-52)*(x-52) + (y-26)*(y-26))) < 2.5) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-26)*(y-26))) < 2.5) v = 0;
            // nose: black ellipse - FIXED LINE, was one extra )
            double n = ((x-60.0)*(x-60.0))/(4.0*4.0) + ((y-35.0)*(y-35.0))/(2.5*2.5);
            if (n < 1) v = 0;
            // tongue: bar hanging down + round tip
            if (x >= 58 && x <= 62 && y >= 42 && y <= 52) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-52)*(y-52))) < 3) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm31.ximg", header ~ comp);
    std.file.write("rm31.raw", raw);
    writefln("made rm31.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
