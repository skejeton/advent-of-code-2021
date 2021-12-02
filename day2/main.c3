import advent;
import libc;
import std::io;
import std::array::list;

struct Command {
    char[] name;
    long value;
}

define CommandList = List<Command>; 

fn int main() {
    char *data = advent::readFile("day2/test_input.txt");
    char *data_start = data;
    
    if (data == null) {
        io::printf("Couldn't read the input file");
        return -1;
    }
    
    defer libc::free(data_start);

    CommandList items;
    

    while (1) {
        usize namelen = 0;
        while (*data == ' ' || *data == '\n' || *data == '\r') {
            data += 1;
        }
        char *namestart = data;
        while (*data >= 'a' && *data <= 'z') {
            namelen += 1;
            data += 1;
        }
        if (namelen == 0) break;
        char[] name = namestart[0..(namelen-1)];

        long value;
        if (try value = advent::nextInt(&data)) {
            items.append({name, value});
        }
    }


    {|
        long hor = 0;
        long dep = 0;
        for (usize i = 0; i < items.size; i += 1) {
            Command cmd = items.get(i);
            if (libc::strncmp((char*)(cmd.name), "forward", cmd.name.len) == 0) {
                hor += cmd.value;
            }
            else if (libc::strncmp((char*)(cmd.name), "down", cmd.name.len) == 0) {
                dep += cmd.value;
            }
            else if (libc::strncmp((char*)(cmd.name), "up", cmd.name.len) == 0) {
                dep -= cmd.value;
            }
        }
        io::printf("Part 1: %ld\n", hor * dep);
    |};

    {|
        long aim = 0;
        long hor = 0;
        long dep = 0;
        for (usize i = 0; i < items.size; i += 1) {
            Command cmd = items.get(i);
            if (libc::strncmp((char*)(cmd.name), "forward", cmd.name.len) == 0) {
                hor += cmd.value;
                dep += aim * cmd.value;
            }
            else if (libc::strncmp((char*)(cmd.name), "down", cmd.name.len) == 0) {
                aim += cmd.value;
            }
            else if (libc::strncmp((char*)(cmd.name), "up", cmd.name.len) == 0) {
                aim -= cmd.value;
            }
        }
        io::printf("Part 2: %ld\n", hor * dep);
    |};

    return 0;
}


