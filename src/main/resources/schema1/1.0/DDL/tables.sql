--liquibase formatted sql

--changeset username:1.0
--rollback DROP TABLE test_prod_table;
CREATE TABLE test_prod_table (test_id INT, test_column VARCHAR, PRIMARY KEY (test_id));