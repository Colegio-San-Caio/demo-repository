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
            double b = ((x-56.0)*(x-56.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(9.0*9.0);
            if (b < 1) v = 255;
            // head: small circle right
            if (sqrt(cast(double)((x-82)*(x-82) + (y-36)*(y-36))) < 9) v = 255;
            // crest: small bar on back top
            if (x >= 44 && x <= 68 && y >= 26 && y <= 28) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-79)*(x-79) + (y-33)*(y-33))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-87)*(x-87) + (y-33)*(y-33))) < 1.5) v = 0;
            // legs: 4 small bars
            if (x >= 42 && x <= 46 && y >= 44 && y <= 52) v = 255;
            if (x >= 54 && x <= 58 && y >= 44 && y <= 52) v = 255;
            if (x >= 66 && x <= 70 && y >= 44 && y <= 52) v = 255;
            // tail: wavy bar left
            double ty = 38 + 4 * sin((x - 14) * 0.2);
            if (x >= 14 && x <= 34 && abs(y - ty) < 3) v = 255;
            // belly spots: black dots
            if (sqrt(cast(double)((x-50)*(x-50) + (y-38)*(y-38))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-62)*(x-62) + (y-38)*(y-38))) < 1.5) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm63.ximg", header ~ comp);
    std.file.write("rm63.raw", raw);
    writefln("made rm63.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
