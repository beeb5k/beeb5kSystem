#define _GNU_SOURCE // Required to unlock RTLD_DEFAULT so we can search all loaded memory
#include <ctype.h>
#include <dlfcn.h>  // Gives us dlsym() to look up memory addresses by string names
#include <stddef.h> 

void hello_world(const char* action) {
    // __func__ is secretly injected by the compiler and holds the string "hello_world".
    // We use raw pointers here (src and dst) instead of array indices because 
    // stepping the memory address forward directly (*dst++) generates faster machine code.
    const char* src = __func__; 
    char result[64];
    char* dst = result; 
    int capitalize = 1;

    // We walk the 'src' pointer forward until we hit the null terminator.
    // The (dst - result) < 60 check guarantees we never write past the end of 
    // our 64-byte array, preventing stack smashing if the function name is unusually long.
    while (*src && (dst - result) < 60) {
        if (*src == '_') {
            *dst++ = ' ';
            capitalize = 1;
        } else {
            *dst++ = capitalize ? toupper(*src) : *src;
            capitalize = 0;
        }
        src++;
    }
    
    // Cap off the string with a bang and the required null terminator
    *dst++ = '!';
    *dst++ = '\n';
    *dst = '\0';

    // Declare a function pointer that takes a format string and variadic arguments
    int (*dynamic_eval)(const char*, ...);

    // This looks unhinged, but it is the official POSIX-compliant way to use dlsym.
    // ISO C strictly forbids casting a raw data pointer (void*) directly to a 
    // function pointer. To bypass the compiler warning, we take the address of our 
    // function pointer, cast THAT to a void**, and dereference it to write the address.
    *(void **)(&dynamic_eval) = dlsym(RTLD_DEFAULT, action);

    if (dynamic_eval) {
        dynamic_eval("%s", result);
    }
}

int main(void) {
    hello_world("printf"); 
    return 0;
}
