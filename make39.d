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
            // mane: big circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 24) v = 255;
            // mane spikes: 8 small triangles around - simplified as dots
            if (sqrt(cast(double)((x-60)*(x-60) + (y-8)*(y-8))) < 4) v = 255;
            if (sqrt(cast(double)((x-77)*(x-77) + (y-15)*(y-15))) < 4) v = 255;
            if (sqrt(cast(double)((x-84)*(x-84) + (y-32)*(y-32))) < 4) v = 255;
            if (sqrt(cast(double)((x-77)*(x-77) + (y-49)*(y-49))) < 4) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-56)*(y-56))) < 4) v = 255;
            if (sqrt(cast(double)((x-43)*(x-43) + (y-49)*(y-49))) < 4) v = 255;
            if (sqrt(cast(double)((x-36)*(x-36) + (y-32)*(y-32))) < 4) v = 255;
            if (sqrt(cast(double)((x-43)*(x-43) + (y-15)*(y-15))) < 4) v = 255;
            // face: circle cut out
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 14) v = 0;
            // ears: 2 small circles back on mane
            if (sqrt(cast(double)((x-48)*(x-48) + (y-20)*(y-20))) < 3) v = 255;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-20)*(y-20))) < 3) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-55)*(x-55) + (y-30)*(y-30))) < 2) v = 255;
            if (sqrt(cast(double)((x-65)*(x-65) + (y-30)*(y-30))) < 2) v = 255;
            // nose: triangle
            if (x >= 58 && x <= 62 && y >= 35 && y <= 35 + (2 - abs(x - 60)) * 1.5) v = 255;
            // mouth: 2 arcs
            double m1 = sqrt(cast(double)((x-57)*(x-57) + (y-38)*(y-38)));
            if (m1 > 2 && m1 < 4 && y > 38) v = 255;
            double m2 = sqrt(cast(double)((x-63)*(x-63) + (y-38)*(y-38)));
            if (m2 > 2 && m2 < 4 && y > 38) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm39.ximg", header ~ comp);
    std.file.write("rm39.raw", raw);
    writefln("made rm39.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
