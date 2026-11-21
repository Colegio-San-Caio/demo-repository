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
            // ears: 2 triangles
            if (x >= 44 && x <= 52 && y >= 10 && y <= 10 + (52 - x)) v = 255;
            if (x >= 68 && x <= 76 && y >= 10 && y <= 10 + (x - 68)) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 20) v = 255;
            // snout: ellipse cut out
            double sn = ((x-60.0)*(x-60.0))/(9.0*9.0) + ((y-38.0)*(y-38.0))/(7.0*7.0);
            if (sn < 1) v = 0;
            // nostrils: 2 dots back on snout
            if (sqrt(cast(double)((x-57)*(x-57) + (y-38)*(y-38))) < 1.5) v = 255;
            if (sqrt(cast(double)((x-63)*(x-63) + (y-38)*(y-38))) < 1.5) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-52)*(x-52) + (y-26)*(y-26))) < 2) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-26)*(y-26))) < 2) v = 0;
            // smile: arc below snout
            double sm = sqrt(cast(double)((x-60)*(x-60) + (y-42)*(y-42)));
            if (sm > 5 && sm < 7 && y > 44) v = 0;
            // curly tail: small spiral on right - dot + arc
            if (sqrt(cast(double)((x-84)*(x-84) + (y-40)*(y-40))) < 3) v = 255;
            if (sqrt(cast(double)((x-84)*(x-84) + (y-40)*(y-40))) < 1.5) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm42.ximg", header ~ comp);
    std.file.write("rm42.raw", raw);
    writefln("made rm42.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
