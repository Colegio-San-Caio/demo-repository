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
            // body: BIG wide bullfrog ellipse
            double b = ((x-60.0)*(x-60.0))/(30.0*30.0) + ((y-38.0)*(y-38.0))/(15.0*15.0);
            if (b < 1) v = 255;
            // head: wide circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 16) v = 255;
            // big bulging eyes: 2 circles on top
            if (sqrt(cast(double)((x-48)*(x-48) + (y-18)*(y-18))) < 5) v = 255;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-18)*(y-18))) < 2) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-18)*(y-18))) < 5) v = 255;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-18)*(y-18))) < 2) v = 0;
            // eardrums: 2 big circles on sides - bullfrog trademark
            if (sqrt(cast(double)((x-44)*(x-44) + (y-28)*(y-28))) < 4) v = 0;
            if (sqrt(cast(double)((x-76)*(x-76) + (y-28)*(y-28))) < 4) v = 0;
            // wide mouth: long bar
            if (x >= 46 && x <= 74 && y >= 32 && y <= 34) v = 0;
            // throat: big circle - for croaking
            if (sqrt(cast(double)((x-60)*(x-60) + (y-44)*(y-44))) < 8) v = 0;
            // front legs: 2 bars
            if (x >= 42 && x <= 46 && y >= 48 && y <= 54) v = 255;
            if (x >= 74 && x <= 78 && y >= 48 && y <= 54) v = 255;
            // back legs: 2 big folded bars
            if (x >= 28 && x <= 36 && y >= 44 && y <= 54) v = 255;
            if (x >= 84 && x <= 92 && y >= 44 && y <= 54) v = 255;
            // water: 2 bars under frog
            if (x >= 20 && x <= 100 && y >= 56 && y <= 58) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm67.ximg", header ~ comp);
    std.file.write("rm67.raw", raw);
    writefln("made rm67.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
