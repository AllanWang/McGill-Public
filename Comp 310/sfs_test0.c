#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "sfs_api.h"

/* The maximum file name length. We assume that filenames can contain
 * upper-case letters and periods ('.') characters. Feel free to
 * change this if your implementation differs.
 */
#define MAX_FNAME_LENGTH 20   /* Assume at most 20 characters (16.3) */

/* The maximum number of files to attempt to open or create.  NOTE: we
 * do not _require_ that you support this many files. This is just to
 * test the behavior of your code.
 */
#define MAX_FD 100

/* The maximum number of bytes we'll try to write to a file. If you
 * support much shorter or larger files for some reason, feel free to
 * reduce this value.
 */
#define MAX_BYTES 30000 /* Maximum file size I'll try to create */
#define MIN_BYTES 10000         /* Minimum file size */

#define DEBUG_T0 1 // set to 0 to disable
#define debug_print(...) \
            do { if (DEBUG_T0) { fprintf(stderr, __VA_ARGS__); fprintf(stderr, "\n"); } } while (0)

/* Just a random test string.
 */
static char test_str[] = "The quick brown fox jumps over the lazy dog.\n";

/* rand_name() - return a randomly-generated, but legal, file name.
 *
 * This function creates a filename of the form xxxxxxxx.xxx, where
 * each 'x' is a random upper-case letter (A-Z). Feel free to modify
 * this function if your implementation requires shorter filenames, or
 * supports longer or different file name conventions.
 * 
 * The return value is a pointer to the new string, which may be
 * released by a call to free() when you are done using the string.
 */

char *rand_name() {
    char fname[MAX_FNAME_LENGTH];
    int i;

    for (i = 0; i < MAX_FNAME_LENGTH; i++) {
        if (i != 16) {
            fname[i] = 'A' + (rand() % 26);
        } else {
            fname[i] = '.';
        }
    }
    fname[i] = '\0';
    return (strdup(fname));
}

/**
 * Outputs mismatch if existent
 * @return 0 if matched, 1 otherwise
 */
int cmp(char *exp, char *act, int length) {
    for (int i = 0; i < length; i++) {
        if (exp[i] != act[i]) {
            debug_print("string mismatch at %d, expected %c, actually %c", i, exp[i], act[i]);
            return 1;
        }
    }
    return 0;
}

char *rand_string(size_t size) {
    char *data = malloc(size);
    for (size_t i = 0; i < size; i++)
        data[i] = (char) ('A' + (rand() % 26));
    return data;
}


/*
 * Tests
 */

int readwrite();

/* The main testing program
 */
int
main(int argc, char **argv) {

    mksfs(1);                     /* Initialize the file system. */

    readwrite();

}

int readwrite() {
    int fd = sfs_fopen(rand_name());
    sfs_fseek(fd, 0);

    size_t length = 20;
    char *data = rand_string(length);

    sfs_fwrite(fd, data, length);

    char *read = malloc(length);

    sfs_fread(fd, read, length);

    int out = cmp(data, read, length);

    free(data);
    free(read);

    if (out == 0) {
        debug_print("Passed read write");
    }

    return out;
}