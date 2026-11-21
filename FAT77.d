import std.stdio;
import std.file;
import std.string;
import std.array;
import std.conv;

void main(string[] args) {
    writeln("Initializing Advanced FAT77 Build Pipeline...");

    if (!exists("MAIN.LIB")) {
        writeln("Error: MAIN.LIB not found.");
        return;
    }

    string libContent = readText("MAIN.LIB");
    string domain = "trafo.com";
    string trafoFlow = "main -> trafo.com -> zudus.lib";

    foreach (line; lineSplitter(libContent)) {
        string trimmed = strip(line);
        if (trimmed.startsWith("DOMAIN =")) {
            domain = strip(trimmed[8..$]);
        } else if (trimmed.startsWith("TRAFO =")) {
            trafoFlow = strip(trimmed[7..$]);
        }
    }

    enum size_t SECTOR_SIZE = 512;
    enum size_t TOTAL_SECTORS = 64;
    enum size_t IMAGE_SIZE = SECTOR_SIZE * TOTAL_SECTORS;

    ubyte[] diskImage = new ubyte[IMAGE_SIZE];
    diskImage[] = 0x00;

    string headerPayload = "FAT77-ADVANCED-SIG|DOMAIN:" ~ domain ~ "|TRAFO:" ~ trafoFlow;
    ubyte[] headerBytes = cast(ubyte[]) headerPayload;
    if (headerBytes.length > SECTOR_SIZE) {
        headerBytes = headerBytes[0 .. SECTOR_SIZE];
    }
    diskImage[0 .. headerBytes.length] = headerBytes[];

    size_t fatOffset = SECTOR_SIZE * 1;
    diskImage[fatOffset] = 0xF8;
    diskImage[fatOffset + 1] = 0xFF;
    diskImage[fatOffset + 2] = 0xFF;

    size_t dataOffset = SECTOR_SIZE * 3;
    string dataMarker = "ROOT_DIR_START";
    ubyte[] dataBytes = cast(ubyte[]) dataMarker;
    diskImage[dataOffset .. dataOffset + dataBytes.length] = dataBytes[];

    string outputFilename = "fat77.img";
    std.file.write(outputFilename, diskImage);

    writeln("Successfully generated advanced ", outputFilename);
    writeln("  - Total Size: ", IMAGE_SIZE, " bytes (", TOTAL_SECTORS, " sectors)");
}
