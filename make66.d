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
            // body: small round frog - dart frog is tiny and round
            double b = ((x-60.0)*(x-60.0))/(18.0*18.0) + ((y-38.0)*(y-38.0))/(14.0*14.0);
            if (b < 1) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-26)*(y-26))) < 12) v = 255;
            // big eyes: 2 circles
            if (sqrt(cast(double)((x-53)*(x-53) + (y-22)*(y-22))) < 4) v = 255;
            if (sqrt(cast(double)((x-53)*(x-53) + (y-22)*(y-22))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-67)*(x-67) + (y-22)*(y-22))) < 4) v = 255;
            if (sqrt(cast(double)((x-67)*(x-67) + (y-22)*(y-22))) < 1.5) v = 0;
            // spots: poison pattern - dots on back
            if (sqrt(cast(double)((x-52)*(x-52) + (y-38)*(y-38))) < 2) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-42)*(y-42))) < 2) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-38)*(y-38))) < 2) v = 0;
            if (sqrt(cast(double)((x-56)*(x-56) + (y-32)*(y-32))) < 2) v = 0;
            if (sqrt(cast(double)((x-64)*(x-64) + (y-32)*(y-32))) < 2) v = 0;
            // legs: 4 splayed legs
            if (x >= 38 && x <= 46 && y >= 42 && y <= 44) v = 255;
            if (x >= 74 && x <= 82 && y >= 42 && y <= 44) v = 255;
            if (x >= 44 && x <= 48 && y >= 46 && y <= 48) v = 255;
            if (x >= 72 && x <= 76 && y >= 46 && y <= 48) v = 255;
            // toe pads: 4 dots
            if (sqrt(cast(double)((x-38)*(x-38) + (y-43)*(y-43))) < 2) v = 255;
            if (sqrt(cast(double)((x-82)*(x-82) + (y-43)*(y-43))) < 2) v = 255;
            // leaf under frog: bar
            if (x >= 30 && x <= 90 && y >= 52 && y <= 54) v = 255;
            // smile: bar
            if (x >= 56 && x <= 64 && y >= 30 && y <= 32) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm66.ximg", header ~ comp);
    std.file.write("rm66.raw", raw);
    writefln("made rm66.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
