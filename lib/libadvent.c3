module advent;
import std::io;
import libc;

fn char* readFile(char *path) {
    CFile *f = libc::fopen(path, "rb");
    if (f == null) {
        return null;
    }
    libc::fseek(f, 0, SEEK_END);
    usize fsz = (usize)(libc::ftell(f));
    libc::fseek(f, 0, SEEK_SET);
    char *input = (char*)(libc::malloc((fsz+1)*$sizeof(char)));
    input[fsz] = 0;
    libc::fread(input, $sizeof(char), fsz, f);
    libc::fclose(f);
    return input;
}

errtype NumberError {
    INVALID_NUMBER
}

fn long! nextInt(char **src) {
    while (**src == ' ' || **src == '\t' || **src == '\n') {
        *src += 1;
    }

    char *start = *src;
    long num = 0;

    while (**src >= '0' && **src <= '9') {
        num += (num * 10) + (long)(**src - '0');
        *src += 1;
    }
    
    
    if (*src == start) {
        return NumberError.INVALID_NUMBER!;
    }
    
    return num;
}
