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
            // 6 petals: circles around center (60,26)
            int[6] px = [60, 75, 75, 60, 45, 45];
            int[6] py = [8, 17, 35, 44, 35, 17];
            foreach (i; 0..6) {
                if (sqrt(cast(double)((x-px[i])*(x-px[i]) + (y-py[i])*(y-py[i]))) < 10) v = 255;
            }
            // center: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-26)*(y-26))) < 7) v = 255;
            // center dot: black hole
            if (sqrt(cast(double)((x-60)*(x-60) + (y-26)*(y-26))) < 2.5) v = 0;
            // stem: vertical bar
            if (x >= 58 && x <= 62 && y >= 44 && y <= 60) v = 255;
            // leaf: small ellipse on stem
            double d = ((x-48.0)*(x-48.0))/(10.0*10.0) + ((y-52.0)*(y-52.0))/(4.0*4.0);
            if (d < 1) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm28.ximg", header ~ comp);
    std.file.write("rm28.raw", raw);
    writefln("made rm28.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
