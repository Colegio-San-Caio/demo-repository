import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;

void main() {
    int w = 120, h = 64;
    // bolt outline, clockwise
    int[] px = [70, 50, 62, 45, 75, 62];
    int[] py = [8, 38, 38, 56, 28, 28];
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            // point-in-polygon ray casting
            bool inside = false;
            for (int i = 0, j = 5; i < 6; j = i++) {
                if ((py[i] > y) != (py[j] > y)) {
                    double xin = (cast(double)(px[j]-px[i]) * (y - py[i]) / (py[j]-py[i]) + px[i]);
                    if (x < xin) inside = !inside;
                }
            }
            raw ~= inside ? cast(ubyte)255 : cast(ubyte)0;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm17.ximg", header ~ comp);
    std.file.write("rm17.raw", raw);
    writefln("made rm17.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
