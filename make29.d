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
            // center: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 14) v = 255;
            // 8 rays: lines from center outward
            double dx = x - 60.0, dy = y - 32.0;
            double dist = sqrt(dx*dx + dy*dy);
            double ang = atan2(dy, dx);
            // snap angle to nearest of 8 directions
            double step = PI / 4.0;
            double snapped = round(ang / step) * step;
            double diff = abs(ang - snapped);
            if (dist >= 16 && dist <= 28 && diff < 0.12) v = 255;
            // center dot: black hole
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 4) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm29.ximg", header ~ comp);
    std.file.write("rm29.raw", raw);
    writefln("made rm29.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
