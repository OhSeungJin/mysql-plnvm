#!/bin/bash
MYSQL_HOME=/home/vldb/mysql-plnvm

#debug mode
IS_DEBUG=0
#IS_DEBUG=1

##The original InnoDB
BUILD_NAME="-DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_DBW -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_WAL -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_PMEMOBJ_BUF_PARTITION -DUNIV_PMEMOBJ_BUF_STAT -DUNIV_TRACE_FLUSH_TIME"

#LSB
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_LSB -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_WAL -DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_PMEMOBJ_BUF_PARTITION -DUNIV_PMEMOBJ_BUF_STAT -DUNIV_TRACE_FLUSH_TIME"

###################################
#for PL-NVM implementation
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_PL -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_PL -DUNIV_PMEMOBJ_PL_DEBUG -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_TRACE_FLUSH_TIME"
#skip add/remove log records to our data structure
#BUILD_NAME="-DUNIV_TEST_PL -DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_PL -DUNIV_PMEMOBJ_PL_DEBUG -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_TEST_PL -DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_PL -DUNIV_PMEMOBJ_PL_DEBUG -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_TEST_PL -DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_PL -DUNIV_PMEMOBJ_PL_DEBUG -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_PARTITION -DUNIV_TRACE_FLUSH_TIME"
####################################

#for LSB implementation
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_LSB -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_LSB -DUNIV_PMEMOBJ_LSB_DEBUG -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_TRACE_FLUSH_TIME"

#BUILD_NAME=-DUNIV_NVM_LOG
#BUILD_NAME=-DUNIV_PMEMOBJ_LOG
#BUILD_NAME="-DUNIV_NVM_LOG -DUNIV_PMEMOBJ_LOG"

## WAL is the new log optimization that integrate log buffer and log file into one place in NVM
#BUILD_NAME="-DUNIV_PMEMOBJ_DBW -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_WAL -DUNIV_TRACE_FLUSH_TIME"

##the stable version: use free pool, no flusher
#BUILD_NAME=-DUNIV_PMEMOBJ_BUF

##UNIV_PMEMOBJ_BUF_STAT collect statistics information, can be used as additional with other PMEMOBJ_BUF_*** 
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_STAT"

##The UNIV_PMEMOBJ_BUF_V2 reused the UNIV_PMEMOBJ_BUF, just overwrite the pm_buf_write and pm_buf_handle_finished that does not use the free_pool
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_V2"

##PMEMOBJ_BUF_FLUSHER use pmem_n_flush_threads to handle aio_batch sothat the cleaner thread can return immediately 
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_APPEND"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_PARTITION"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_PARTITION -DUNIV_PMEMOBJ_BUF_PARTITION_STAT"

## For EVEN
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY"
##Use this for statistic information, n_writes, n_overwrites, n_reads, n_reads_hit, n_reads_flushing, ...
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_PMEMOBJ_BUF_STAT -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_PMEMOBJ_BUF_STAT -DUNIV_TRACE_FLUSH_TIME -DUNIV_PMEMOBJ_BUF_RECOVERY_DEBUG"

## For SINGLE and LESS 
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_PMEMOBJ_BUF_PARTITION -DUNIV_PMEMOBJ_BUF_STAT -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_PMEMOBJ_BUF_PARTITION -DUNIV_TRACE_FLUSH_TIME"
#BUILD_NAME="-DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_PMEMOBJ_BUF_PARTITION -DUNIV_PMEMOBJ_BUF_STAT -DUNIV_TRACE_FLUSH_TIME -DUNIV_PMEMOBJ_BUF_RECOVERY_DEBUG"

##combine all
#BUILD_NAME="-DUNIV_NVM_LOG -DUNIV_PMEMOBJ_LOG -DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER"
#BUILD_NAME="-DUNIV_PMEMOBJ_WAL -DUNIV_PMEMOBJ_BUF -DUNIV_PMEMOBJ_BUF_FLUSHER -DUNIV_PMEMOBJ_BUF_RECOVERY -DUNIV_PMEMOBJ_BUF_PARTITION -DUNIV_PMEMOBJ_BUF_STAT -DUNIV_TRACE_FLUSH_TIME"




echo "BUILD MODE: $BUILD_NAME with debug=$IS_DEBUG"
cd $MYSQL_HOME/bld
cmake .. -DWITH_DEBUG=$IS_DEBUG  -DCMAKE_C_FLAGS="$BUILD_NAME -DUNIV_AIO_IMPROVE" -DCMAKE_CXX_FLAGS="$BUILD_NAME -DUNIV_AIO_IMPROVE" -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/root/boost
make install -j48
