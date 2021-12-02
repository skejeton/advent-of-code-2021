//              
// A little inefficent hash table implementation
// but should be good enough for advent of code :)
//
module std::hash_table <Type>;
import std::array::list;
import libc;
import std::mem;
import std::hash::crc32;
import std::io;

struct Pair {
    char* key;
    Type value;
}

define Bucket = List<Pair>;

struct HashTable {
    usize element_count;
    usize bucket_count;
    Bucket *buckets;
}

fn uint keyhash(char *key) {
    Crc32 hash;
    hash.init();
    
    while (*key) {
        hash.updatec(*key);
        key += 1;
    }
    
    return hash.result;
}

fn void HashTable.tryResize(HashTable *this) {
    if (this.element_count >= this.bucket_count * 3) {
        usize old_bucket_count = this.bucket_count;
        Bucket *old_buckets = this.buckets;
        if (this.bucket_count == 0) {
            this.bucket_count = 64;
        }
        else {
            this.bucket_count *= 2;
        }
        
        this.buckets = mem::calloc($sizeof(Bucket), this.bucket_count);
        
        // Return nothing since we just did first initialization of the hash table
        if (old_buckets == null) {
            return;
        }
        
        // Migrate old buckets to new buckets
        for (usize i = 0; i < old_bucket_count; i += 1) {
            Bucket old_bucket = old_buckets[i];
            for (usize el = 0; el < old_bucket.size; el += 1) {
                usize destination = keyhash(old_bucket.get(el).key) % this.bucket_count;
                this.buckets[destination].append(old_bucket.get(el));
            }
        }
    }
}

fn void HashTable.remove(HashTable *this, char* key) {
    this.element_count -= 1;

    usize destination = keyhash(key) % this.bucket_count;
    for (usize i = 0; i < this.buckets[destination].size; i += 1) {
        Pair *check = this.buckets[destination].getPtr(i);
        
        if (libc::strcmp(check.key, key) == 0) {
            libc::free(this.buckets[destination].getPtr(i).key);
            this.buckets[destination].removeAt(i);
            return;
        }
    }
}

fn void HashTable.insert(HashTable *this, char* key, Type element) {
    this.tryResize();
    io::printf("Putting ptr at %p\n", key);
            
    this.element_count += 1;
    
    usize destination = keyhash(key) % this.bucket_count;
    for (usize i = 0; i < this.buckets[destination].size; i += 1) {
        Pair *check = this.buckets[destination].getPtr(i);
        
        if (libc::strcmp(check.key, key) == 0) {
            check.value = element;
            return;
        }
    }
    
    Pair pair;
    pair.value = element;

    usize len = libc::strlen(key);
    char *new_key = libc::malloc(len+1);
    libc::memcpy(new_key, key, len);
    new_key[len] = 0;
    pair.key = new_key;
    
    this.buckets[destination].append(pair);
}

fn Type* HashTable.get(HashTable *this, char* key) {
    usize source = keyhash(key) % this.bucket_count;
    for (usize i = 0; i < this.buckets[source].size; i += 1) {
        Pair pair = this.buckets[source].get(i);
        
        if (libc::strcmp(pair.key, key) == 0) {
            return &pair.value;
        }
    }
    return null;
}

fn void HashTable.free(HashTable *this) {
    for (usize i = 0; i < this.bucket_count; i += 1) {
        for (usize j = 0; j < this.buckets[i].size; i += 1) {
            io::printf("Removing ptr at %p\n", this.buckets[i].getPtr(j).key);
            mem::free(this.buckets[i].getPtr(j).key);
        }
    
        this.buckets[i].free();
    }
}
