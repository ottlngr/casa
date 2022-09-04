# Photo management

## `sync.sh`

### Idea

Sync photos from a source directory to a target directory (using `rsync`) and

- unify filenames (using `exiftool`)
- create a nested directory structure using EXIF creation date (using `exiftool`)
- find duplicated by checksum and delete them in the target directory (using `fdupes`)

### Dependencies

- `exiftool`
- `rsync`
- `fdupes`

### Usage

```
sh sync.sh <SOURCE_DIR> <WORKING_DIR> <TARGET_DIR>
```

### Sample output

```
###########################
###### exiftool magic ##### 
###########################


---------------------------------------
STEP 0:
  1) Remove working directories if they already exist
  2) Create working directories
  3) Copy files from /home/philipp/Schreibtisch/exif/source to /home/philipp/Schreibtisch/exif/source2/0
---------------------------------------  
Output:


---------------------------------------
STEP 1:
  1) Read files from /home/philipp/Schreibtisch/exif/source2/0
  2) Change filename to EXIF creation date and and a prefix
  3) Copy files to /home/philipp/Schreibtisch/exif/source2/1
---------------------------------------

Output:

    1 directories scanned
   44 image files copied

---------------------------------------
STEP 2:
  1) Read files from /home/philipp/Schreibtisch/exif/source2/1
  2) Create directory structure by EXIF creation date
  3) Copy files and directories to /home/philipp/Schreibtisch/exif/source2/2
---------------------------------------
  
Output:

    1 directories scanned
    3 directories created
   44 image files copied

---------------------------------------
STEP 3:
  1) rsync from /home/philipp/Schreibtisch/exif/source2/2 to /home/philipp/Schreibtisch/exif/target, using checksum
---------------------------------------

Output:

sending incremental file list
2020/03/PRE_20200321_112245.jpg
2020/03/PRE_20200321_112249.jpg
2020/03/PRE_20200321_141133.jpg
...

sent 150,389,666 bytes  received 864 bytes  60,156,212.00 bytes/sec
total size is 150,349,359  speedup is 1.00

---------------------------------------
STEP 4:
  1) Find and delete duplicates in /home/philipp/Schreibtisch/exif/target using fdupes
---------------------------------------

Output:

                                        
   [+] /home/philipp/Schreibtisch/exif/target/2020/07/20200701_141439.jpg
   [-] /home/philipp/Schreibtisch/exif/target/2020/07/PRE_20200701_141439.jpg


   [+] /home/philipp/Schreibtisch/exif/target/2020/07/20200701_141443.jpg
   [-] /home/philipp/Schreibtisch/exif/target/2020/07/PRE_20200701_141443.jpg


...


---------------------------------------
STEP 5:
  1) Set filename to EXIF creation date recursively in /home/philipp/Schreibtisch/exif/target
---------------------------------------

Output:

    5 directories scanned
    0 image files updated
   44 image files unchanged

---------------------------------------
STEP 6:
  1) Delete working directories
---------------------------------------

Output:
```