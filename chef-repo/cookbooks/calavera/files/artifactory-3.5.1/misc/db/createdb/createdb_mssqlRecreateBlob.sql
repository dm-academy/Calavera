/*** If the binary-blobs table already exist, 'drop' the Binary Blobs table from the main DB and create it again -  */
/* The recreation of this table will under the new location that has been setup for blobs:  see createdb_mssql.sql  */
/* for more details */

drop table binary_blobs;

create table binary_blobs(
 sha1 CHAR(40) NOT NULL,
 data VARBINARY(MAX),
 CONSTRAINT binary_blobs_pk PRIMARY KEY (sha1)
 )ON artblob_fg1;

/* if you have changed your table to use filegroups, stop Artifactory and configure your */
/* $ARTIFACTORY_HOME/etc/storage.properties to use fullDb binary.provider.type=fullDb  */
/* and restart Artifactory. Blobs will now be stored in the secondary Filegroup db. */
