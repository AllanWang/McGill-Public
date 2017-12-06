#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "sfs_api.h"
#include "disk_emu.h"

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

/*
 * Prints use stderr so that it isn't buffered
 */

#define DEBUG_T0 1 // set to 0 to disable
#define debug_print(...) \
            do { if (DEBUG_T0) { fprintf(stderr, __VA_ARGS__); fprintf(stderr, "\n"); } } while (0)
#define error_print(...) fprintf(stderr, "ERROR: "); fprintf(stderr, __VA_ARGS__); fprintf(stderr, "\n");
/* Just a random test string.
 */
static char test_str[] = "The quick brown fox jumps over the lazy dog.\n";

#define BLOCK_SIZE 1024

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

int read_write();

int big_read_write();

int big_segment_read_write();

/* The main testing program
 */
int
main(int argc, char **argv) {

    mksfs(1);                     /* Initialize the file system. */

    read_write();
    big_read_write();
    big_segment_read_write();

    return close_disk();
}

int read_write() {

    char *name = rand_name();
    int fd = sfs_fopen(name);
    sfs_fseek(fd, 0);

    int length = 20;
    char *data = rand_string(length);

    sfs_fwrite(fd, data, length);

    sfs_fseek(fd, 0);

    char *read = malloc(length);

    sfs_fread(fd, read, length);

    debug_print("Verifying read write");
    if (cmp(data, read, length) != 0) {
        debug_print("Failed read write");
        free(data);
        free(read);
        free(name);
        return -1;
    }


    debug_print("Write data 2");
    char *data2 = rand_string(length);

    sfs_fwrite(fd, data2, length);

    sfs_fseek(fd, 0);

    char *read2 = malloc(length * 2);

    sfs_fread(fd, read2, length * 2);

    debug_print("Verifying read write 2");
    if (cmp(data, read2, length) != 0) {
        error_print("Failed second rw");
        free(data);
        free(data2);
        free(read);
        free(read2);
        free(name);
        return -1;
    }

    debug_print("Verifying read write 2.2");
    if (cmp(data2, read2 + length, length) != 0) {
        error_print("Failed second rw pt 2");
        free(data);
        free(data2);
        free(read);
        free(read2);
        free(name);
        return -1;
    }


    debug_print("Passed read write tests");

    free(data);
    free(data2);
    free(read);
    free(read2);
    free(name);
    return 0;
}

int big_read_write() {
    int len = BLOCK_SIZE * 15 + 20;
    char *data = rand_string(len);
    char *name = rand_name();
    int fd = sfs_fopen(name);
    sfs_fseek(fd, 0);
    sfs_fwrite(fd, data, len);
    char *read = malloc(len);
    sfs_fseek(fd, 0);
    sfs_fread(fd, read, len);
    if (cmp(data, read, len) != 0) {
        error_print("Failed big read write");
        free(data);
        free(read);
        free(name);
        return -1;
    }

    debug_print("Passed big read write");
    free(data);
    free(read);
    free(name);
    return 0;
}

int big_segment_read_write() {

    int len1 = BLOCK_SIZE * 11 + 20;
    int len2 = BLOCK_SIZE + 30;
    int len3 = BLOCK_SIZE * 3 - 20;

    char *data1 = rand_string(len1);
    char *data2 = rand_string(len2);
    char *data3 = rand_string(len3);

    char *name = rand_name();

    int fd = sfs_fopen(name);
    sfs_fseek(fd, 0);
    sfs_fwrite(fd, data1, len1);
    sfs_fwrite(fd, data2, len2);
    sfs_fwrite(fd, data3, len3);

    char *read = malloc(len1 + len2 + len3);
    sfs_fseek(fd, 0);

    sfs_fread(fd, read, len1 + len2 + len3);
    if (cmp(data1, read, len1) != 0) {
        error_print("Failed big seg read write 1");
        free(data1);
        free(read);
        free(name);
        return -1;
    }

    free(data1);

    if (cmp(data2, read + len1, len2) != 0) {
        error_print("Failed big seg read write 2");
        free(data2);
        free(read);
        free(name);
        return -1;
    }

    free(data2);

    if (cmp(data3, read + len1 + len2, len3) != 0) {
        error_print("Failed big seg read write 3");
        free(data3);
        free(name);
        free(read);
        return -1;
    }

    debug_print("Passed big segment read write pt 1");
    free(data3);

    sfs_fseek(fd, 0);

    int size = sfs_getfilesize(name);

    if (size != len1 + len2 + len3) {
        error_print("Failed filesize; expected %d, actually %d", len1 + len2 + len3, size);
        free(read);
        free(name);
        return -1;
    }

    debug_print("Size is %d", size);

    int i = 0;
    int chunk_size = 29;
    char *chunk = malloc(chunk_size);

    while (i < size) {
        sfs_fread(fd, chunk, chunk_size);
        if (cmp(read + i, chunk, size - i > chunk_size ? chunk_size : size - i)) {
            error_print("Failed chunk read %d", i);
            free(read);
            free(chunk);
            free(name);
            return -1;
        }
        i += chunk_size;
    }

    debug_print("Passed segment read");

    free(read);
    free(chunk);
    free(name);
    return 0;

}

//REPPGWSTJSXPUPPLUNXLUIZUZZRDO

//REPPGWSTJSXPUPPLUNXLUIZUZZRDOJDHPUWWSOPBIMSCCHPYXMJTXKPWKHCASHHHBFDVVTYEHQGLZYJWKSSJDHGNOKPGRYQUDTPYONCWFLHEJRDVLVFOENDVXUBQSTKVNBUBOYZVJHZUAESNBZEGMJBLEEBYANUNOQQEOQ