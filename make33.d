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
            // body: tall ellipse
            double b = ((x-60.0)*(x-60.0))/(18.0*18.0) + ((y-34.0)*(y-34.0))/(24.0*24.0);
            if (b < 1) v = 255;
            // belly: white ellipse cut out - in our 1-bit world, black = white belly
            double belly = ((x-60.0)*(x-60.0))/(11.0*11.0) + ((y-38.0)*(y-38.0))/(16.0*16.0);
            if (belly < 1) v = 0;
            // face: white patch cut out
            double face = ((x-60.0)*(x-60.0))/(9.0*9.0) + ((y-22.0)*(y-22.0))/(8.0*8.0);
            if (face < 1) v = 0;
            // eyes: 2 black dots back on face
            if (sqrt(cast(double)((x-56)*(x-56) + (y-20)*(y-20))) < 1.8) v = 255;
            if (sqrt(cast(double)((x-64)*(x-64) + (y-20)*(y-20))) < 1.8) v = 255;
            // beak: small triangle
            if (x >= 58 && x <= 62 && y >= 24 && y <= 24 + (2 - abs(x - 60)) * 2) v = 255;
            // flippers: 2 side ellipses
            double f1 = ((x-39.0)*(x-39.0))/(4.0*4.0) + ((y-36.0)*(y-36.0))/(12.0*12.0);
            if (f1 < 1) v = 255;
            double f2 = ((x-81.0)*(x-81.0))/(4.0*4.0) + ((y-36.0)*(y-36.0))/(12.0*12.0);
            if (f2 < 1) v = 255;
            // feet: 2 bars
            if (x >= 50 && x <= 58 && y >= 57 && y <= 60) v = 255;
            if (x >= 62 && x <= 70 && y >= 57 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm33.ximg", header ~ comp);
    std.file.write("rm33.raw", raw);
    writefln("made rm33.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
