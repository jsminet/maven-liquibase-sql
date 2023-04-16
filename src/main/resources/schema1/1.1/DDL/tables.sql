--liquibase formatted sql

--changeset username:1.1
--rollback DROP TABLE test_table;
CREATE TABLE test_table (test_id INT, test_column VARCHAR, PRIMARY KEY (test_id));