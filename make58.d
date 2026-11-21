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
            double b = ((x-56.0)*(x-56.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(10.0*10.0);
            if (b < 1) v = 255;
            // head: wide circle right
            if (sqrt(cast(double)((x-84)*(x-84) + (y-36)*(y-36))) < 11) v = 255;
            // big eyes: 2 black dots with white ring
            if (sqrt(cast(double)((x-82)*(x-82) + (y-32)*(y-32))) < 3) v = 255;
            if (sqrt(cast(double)((x-82)*(x-82) + (y-32)*(y-32))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-90)*(x-90) + (y-32)*(y-32))) < 3) v = 255;
            if (sqrt(cast(double)((x-90)*(x-90) + (y-32)*(y-32))) < 1.5) v = 0;
            // legs: 4 bars with toe pads - wider feet
            if (x >= 40 && x <= 48 && y >= 44 && y <= 54) v = 255;
            if (x >= 54 && x <= 62 && y >= 44 && y <= 54) v = 255;
            if (x >= 64 && x <= 72 && y >= 44 && y <= 54) v = 255;
            // tail: fat curvy bar left
            double ty = 38 + 5 * sin((x - 12) * 0.15);
            if (x >= 12 && x <= 34 && abs(y - ty) < 4) v = 255;
            // spots: black dots
            if (sqrt(cast(double)((x-48)*(x-48) + (y-36)*(y-36))) < 2) v = 0;
            if (sqrt(cast(double)((x-62)*(x-62) + (y-40)*(y-40))) < 2) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm58.ximg", header ~ comp);
    std.file.write("rm58.raw", raw);
    writefln("made rm58.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
