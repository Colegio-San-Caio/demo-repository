import std.stdio;
import std.file;
import std.string;
import std.array;
import std.conv;

void main() {
    if (!exists("MAIN.LIB")) {
        writeln("MAIN.LIB not found.");
        return;
    }

    string content = readText("MAIN.LIB");
    writeln("Loaded MAIN.LIB successfully. Parsing matrix mappings...");

    foreach (line; lineSplitter(content)) {
        string trimmed = strip(line);
        if (trimmed.startsWith("DOMAIN =")) {
            writeln("Domain target: ", strip(trimmed[8..$]));
        } else if (trimmed.startsWith("TRAFO =")) {
            writeln("Transformation flow: ", strip(trimmed[7..$]));
        }
    }
}
