import advent;
import libc;
import std::io;
import std::array::list;

define LongList = List<long>; 

fn int main() {
    char *data = advent::readFile("day1/test_input.txt");
    char *data_start = data;
    
    if (data == null) {
        io::printf("Couldn't read the input file");
        return -1;
    }
    
    defer libc::free(data_start);
    
    LongList items;
    
    long value;
    
    while (try value = advent::nextInt(&data)) {
        items.append(value);
    }
    
    {|
        long previous = 9999999;
        long increased = 0;
        
        for (usize i = 0; i < items.size; i += 1) {
            long item = items.get(i);
            if (item > previous) {
                increased += 1;
            }
            previous = item;
        }
        
        io::printf("Part 1: %d\n", increased);
    |};
    
    {|
        long previous = 9999999;
        long increased = 0;
        
        for (usize i = 0; i < items.size-2; i += 1) {
            long item = items.get(i)+items.get(i+1)+items.get(i+2);
            if (item > previous) {
                increased += 1;
            }
            previous = item;
        }
        
        io::printf("Part 2: %d\n", increased);
    |};
    
    return 0;
}


