create database if not exists nico_data default character set utf8mb4;

CREATE TABLE IF NOT EXISTS `videos`
(
  video_id    varchar(255) NOT NULL PRIMARY KEY,
  title       varchar(255),
  description text,
  watch_num   int(11),
  comment_num int(11),
  mylist_num  int(11),
  category    varchar(255),
  tags        text,
  upload_time datetime,
  file_type   varchar(255),
  length      int(11),
  size_high   int(11),
  size_low    int(11)
);

LOAD DATA LOCAL INFILE '/path/to/0000.csv'
INTO TABLE videos FIELDS TERMINATED BY ',' ENCLOSED BY '"';

SELECT tags FROM videos
INTO OUTFILE '/tmp/0000.tags.csv' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

