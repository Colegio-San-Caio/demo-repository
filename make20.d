import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;
import std.math;

void main() {
    int w = 120, h = 64;
    // crown outline, clockwise
    int[] px = [30, 90, 90, 80, 70, 60, 50, 40, 30];
    int[] py = [50, 50, 35, 15, 30, 10, 30, 15, 35];
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            // point-in-polygon ray casting
            bool inside = false;
            for (int i = 0, j = 8; i < 9; j = i++) {
                if ((py[i] > y) != (py[j] > y)) {
                    double xin = (cast(double)(px[j]-px[i]) * (y - py[i]) / (py[j]-py[i]) + px[i]);
                    if (x < xin) inside = !inside;
                }
            }
            ubyte v = inside ? cast(ubyte)255 : cast(ubyte)0;
            // jewels: 3 black dots on the band
            foreach (jx; [42, 60, 78]) {
                double dx = x - jx, dy = y - 43;
                if (sqrt(dx*dx + dy*dy) < 3) v = 0;
            }
            // base band line
            if (y == 50) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm20.ximg", header ~ comp);
    std.file.write("rm20.raw", raw);
    writefln("made rm20.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
