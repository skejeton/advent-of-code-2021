import advent;
import libc;
import std::io;
import std::array::list;

define UintList = List<uint>; 


fn uint part1(UintList nums, uint bitcount) {
    uint gamma = 0;
    for (uint bit = 0; bit < bitcount; bit += 1) {
        uint setcount = 0;
        for (uint i = 0; i < nums.size; i += 1) {
            setcount += (uint)(!(!(nums.get(i) & (1 << bit))));
        }
        uint unsetcount = (uint)(nums.size)-setcount;
        gamma |= (uint)(setcount > unsetcount) << bit;
    }
    return gamma * (~gamma & ((1 << bitcount) - 1));
}

fn uint part2(UintList nums, uint bitcount, bool less) {
    for (uint bit_ = 0; bit_ < bitcount; bit_ += 1) {
        uint bit = bitcount-bit_-1;
        uint setcount = 0;
        for (uint i = 0; i < nums.size; i += 1) {
            setcount += (uint)(!(!(nums.get(i) & (1 << bit))));
        }
        uint unsetcount = (uint)(nums.size)-setcount;
        
        if (nums.size == 1) {
            break;
        }

        UintList newnums;

        for (uint i = 0; i < nums.size; i += 1) {
            if ((uint)(!(!(nums.get(i) & (1 << bit)))) ^ ((uint)(setcount >= unsetcount) ^ (uint)(less))) {
                newnums.append(nums.get(i));
            }
        }
        
        nums = newnums;
    }
    return nums.get(0);
}


fn int main() {
    char *data = advent::readFile("day3/test_input.txt");
    char *data_start = data;
    
    if (data == null) {
        io::printf("Couldn't read the input file");
        return -1;
    }
    
    defer libc::free(data_start);
    
    UintList nums;
    
    uint bitcount = 0;
    while (*data == '0' || *data == '1') {
        bitcount += 1;
        data += 1;
    }
    data = data_start;
    
    while (try value = advent::nextBinary(&data)) {
        nums.append(value);
    }

    io::printf("Part 1: %lu\n", part1(nums, bitcount));
    io::printf("Part 2: %lu\n", part2(nums, bitcount, false) * part2(nums, bitcount, true));
    return 0;
}


