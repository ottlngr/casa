#!/bin/bash

SOURCE_DIR=$1
WORKING_DIR=$2
TARGET_DIR=$3

cat << EOF

###########################
###### exiftool magic ##### 
###########################

EOF

# Step 0
cat << EOF

---------------------------------------
STEP 0:
  1) Remove working directories if they already exist
  2) Create working directories
  3) Copy files from $SOURCE_DIR to $WORKING_DIR/0
---------------------------------------  
Output:

EOF
rm -rf $WORKING_DIR/0
rm -rf $WORKING_DIR/1
rm -rf $WORKING_DIR/2
mkdir $WORKING_DIR/0
mkdir $WORKING_DIR/1
mkdir $WORKING_DIR/2
cp $SOURCE_DIR/* $WORKING_DIR/0/

# Step 1
cat << EOF

---------------------------------------
STEP 1:
  1) Read files from $WORKING_DIR/0
  2) Change filename to EXIF creation date and and a prefix
  3) Copy files to $WORKING_DIR/1
---------------------------------------

Output:

EOF
exiftool '-filename<CreateDate' -d PRE_%Y%m%d_%H%M%S%%-c.%%le -r $WORKING_DIR/0 -o $WORKING_DIR/1

# Step 2
cat << EOF

---------------------------------------
STEP 2:
  1) Read files from $WORKING_DIR/1
  2) Create directory structure by EXIF creation date
  3) Copy files and directories to $WORKING_DIR/2
---------------------------------------
  
Output:

EOF
exiftool '-Directory<CreateDate' -d $WORKING_DIR/2/%Y/%m -r $WORKING_DIR/1 -o $WORKING_DIR/2

# Step 3
cat << EOF

---------------------------------------
STEP 3:
  1) rsync from $WORKING_DIR/2 to $TARGET_DIR, using checksum
---------------------------------------

Output:

EOF
rsync -v -r -c $WORKING_DIR/2/ $TARGET_DIR

# Step 4
cat << EOF

---------------------------------------
STEP 4:
  1) Find and delete duplicates in $TARGET_DIR using fdupes
---------------------------------------

Output:

EOF
fdupes -r $TARGET_DIR $TARGET_DIR --delete --noprompt

# Step 5
cat << EOF

---------------------------------------
STEP 5:
  1) Set filename to EXIF creation date recursively in $TARGET_DIR
---------------------------------------

Output:

EOF
exiftool '-filename<CreateDate' -d %Y%m%d_%H%M%S%%-c.%%le -r $TARGET_DIR

# Step 6
cat << EOF

---------------------------------------
STEP 6:
  1) Delete working directories
---------------------------------------

Output:

EOF
rm -rf $WORKING_DIR/*

