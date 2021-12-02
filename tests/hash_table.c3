import std::hash_table;
import std::io;
define IntHashTable = HashTable<int>;

fn int main() {
    IntHashTable ht;
    defer ht.free();

    ht.insert("a", 2);
    io::printf("%d\n", *ht.get("a"));
    ht.insert("a", 43);
    io::printf("%d\n", *ht.get("a"));
    for (char i = 0; i < 128; i += 1) {
        char[2] junk = { i, 0 };
        if (i == 'a') {
            continue;
        }
        ht.insert(&junk, (int)(i));
    }
    io::printf("%d\n", *ht.get("a"));
    return 0;
}
