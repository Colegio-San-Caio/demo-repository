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
            // body: ellipse
            double b = ((x-56.0)*(x-56.0))/(26.0*26.0) + ((y-38.0)*(y-38.0))/(9.0*9.0);
            if (b < 1) v = 255;
            // head: circle right
            if (sqrt(cast(double)((x-84)*(x-84) + (y-36)*(y-36))) < 10) v = 255;
            // snout: small bar
            if (x >= 90 && x <= 98 && y >= 34 && y <= 40) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-84)*(x-84) + (y-32)*(y-32))) < 2) v = 0;
            // legs: 4 small bars with feet
            if (x >= 40 && x <= 46 && y >= 44 && y <= 52) v = 255;
            if (x >= 54 && x <= 60 && y >= 44 && y <= 52) v = 255;
            if (x >= 64 && x <= 70 && y >= 44 && y <= 52) v = 255;
            if (x >= 74 && x <= 80 && y >= 44 && y <= 52) v = 255;
            // tail: long curvy bar left - wavy
            double ty = 38 + 6 * sin((x - 10) * 0.2);
            if (x >= 10 && x <= 32 && abs(y - ty) < 3) v = 255;
            // back spots: black dots
            if (sqrt(cast(double)((x-48)*(x-48) + (y-36)*(y-36))) < 2) v = 0;
            if (sqrt(cast(double)((x-62)*(x-62) + (y-40)*(y-40))) < 2) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-34)*(y-34))) < 2) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm56.ximg", header ~ comp);
    std.file.write("rm56.raw", raw);
    writefln("made rm56.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
