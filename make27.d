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
            double d = ((x-55.0)*(x-55.0))/(28.0*28.0) + ((y-32.0)*(y-32.0))/(16.0*16.0);
            if (d < 1) v = 255;
            // tail: triangle on right
            if (x >= 80 && x <= 100 && y >= 32 - (x - 80) * 0.7 && y <= 32 + (x - 80) * 0.7) v = 255;
            // top fin: small triangle
            if (x >= 45 && x <= 65 && y >= 16 - (x - 45) * 0.3 && y <= 20) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-38)*(x-38) + (y-30)*(y-30))) < 2.5) v = 0;
            // gill: vertical line cut out
            if (x == 50 && y >= 20 && y <= 44) v = 0;
            // stripes: 2 vertical lines cut out
            if ((x == 60 || x == 70) && y >= 18 && y <= 46) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm27.ximg", header ~ comp);
    std.file.write("rm27.raw", raw);
    writefln("made rm27.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
