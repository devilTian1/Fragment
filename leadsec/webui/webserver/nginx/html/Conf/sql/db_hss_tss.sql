BEGIN TRANSACTION;
create table grp_comment (name TEXT PRIMARY KEY, comment VARCHAR(100));
create table time_grp (name TEXT, subname TEXT, PRIMARY KEY(name, subname));
create table time_span (name TEXT PRIMARY KEY, spantype NUMERIC(1, 0), starttime VARCHAR(14), endtime VARCHAR(14), comment VARCHAR(100));
COMMIT;
