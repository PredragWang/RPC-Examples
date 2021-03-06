/*
 * Limits of file name length and chunk size.
 */
const MAX_CHUNK_SIZE = 4096;
const MAX_FNAME_LEN = 1024;

typedef int boolean;

/*
 * Definition of filename type.
 */
typedef opaque filename[MAX_FNAME_LEN];

/*
 * Definition of Transfer request data structure
 */
struct request{
    filename f_name;
    u_long offset;
};

typedef struct request request;

/*
 * Definition of 'chunk' type for storing bytes of the file chunks
 */
typedef opaque chunk[MAX_CHUNK_SIZE];

/*
 * Definition of data structure for sending file chunks
 */
struct filechunk {
    chunk data;
    u_long offset;
    u_long bytes;
    boolean end;
};

typedef struct filechunk filechunk;

/*
 * Definition of data structure for return of procedure
 */
union get_file_ret switch (int errno) {
    case 0:
        filechunk f_chunk;
    default:
        void;
};

/*
 * Definition of the procedure
 */
program FT{
    version FTVERS {
        get_file_ret get_file(request *) = 1;
    } = 1;
} = 0x20000011;
