CREATE DATABASE iam_db;

USE iam_db;

CREATE USER 'iam_user'@'localhost' IDENTIFIED BY 'iam_password';
GRANT ALL ON iam_db.* TO 'iam_user'@'localhost';

DROP TABLE IF EXISTS AUTH;

CREATE TABLE AUTH
(
    ID         VARCHAR(128)  NOT NULL,
    CREDENTIAL VARCHAR(2000) NOT NULL,

    PRIMARY KEY (ID)
);





CREATE DATABASE user_db;

USE user_db;

CREATE USER 'user_user'@'localhost' IDENTIFIED BY 'user_password';

GRANT ALL ON user_db.* TO 'user_user'@'localhost';

DROP TABLE IF EXISTS USER;

CREATE TABLE USER
(
    ID            VARCHAR(128) NOT NULL,
    NAME          VARCHAR(128) NOT NULL,
    `TYPE`        VARCHAR(20)  NOT NULL,
    MOBILE_NUMBER VARCHAR(20)  NOT NULL,
    EMAIL_ID      VARCHAR(128) NOT NULL,

    PRIMARY KEY (ID),
    CONSTRAINT UNIQUE KEY `unique_mobile_number` (MOBILE_NUMBER)
);

DROP TABLE IF EXISTS ADDRESS;

CREATE TABLE ADDRESS
(
    ID         BIGINT        NOT NULL AUTO_INCREMENT,
    `TYPE`     VARCHAR(20)   NOT NULL,
    ADDRESS    VARCHAR(2000) NOT NULL,
    USER_ID    VARCHAR(128)  NOT NULL,
    IS_DEFAULT BIT(1)        NOT NULL,

    PRIMARY KEY (ID)
);




CREATE DATABASE inventory_db;

USE inventory_db;

CREATE USER 'inventory_user'@'localhost' IDENTIFIED BY 'inventory_password';

GRANT ALL ON inventory_db.* TO 'inventory_user'@'localhost';

DROP TABLE IF EXISTS file_details;
DROP TABLE IF EXISTS item;

CREATE TABLE file_details
(
    id           BIGINT AUTO_INCREMENT NOT NULL,
    item_id      BIGINT                NULL,
    file_name    VARCHAR(255)          NULL,
    content_type VARCHAR(255)          NULL,
    content      BLOB                  NULL,
    CONSTRAINT pk_filedetails PRIMARY KEY (id)
);

CREATE TABLE item
(
    id                    BIGINT AUTO_INCREMENT NOT NULL,
    seller_id             VARCHAR(255)          NOT NULL,
    name                  VARCHAR(255)          NOT NULL,
    `description`         VARCHAR(255)          NOT NULL,
    is_in_stock           BIT(1)                NOT NULL,
    remaining_stock_count INT                   NOT NULL,
    category              VARCHAR(255)          NOT NULL,
    properties            VARCHAR(255)          NULL,
    price                 DECIMAL               NOT NULL,
    CONSTRAINT pk_item PRIMARY KEY (id)
);

ALTER TABLE file_details
    ADD CONSTRAINT FK_FILEDETAILS_ON_ITEMID FOREIGN KEY (item_id) REFERENCES item (id);





DROP TABLE IF EXISTS `order`;

CREATE TABLE `order`
(
    id             BIGINT AUTO_INCREMENT NOT NULL,
    user_id        VARCHAR(255)          NOT NULL,
    item_id        VARCHAR(255)          NOT NULL,
    created_on     datetime              NOT NULL,
    order_status   VARCHAR(255)          NOT NULL,
    payment_type   VARCHAR(255)          NOT NULL,
    payment_status VARCHAR(255)          NOT NULL,
    quantity       INT                   NOT NULL,
    item           VARCHAR(255)          NOT NULL,
    CONSTRAINT pk_order PRIMARY KEY (id)
);

DROP table `order`;

CREATE TABLE `order`
(
    id             BIGINT AUTO_INCREMENT NOT NULL,
    user_id        VARCHAR(255)          NOT NULL,
    item_id        VARCHAR(255)          NOT NULL,
    created_on     datetime              NOT NULL,
    order_status   VARCHAR(255)          NOT NULL,
    payment_type   VARCHAR(255)          NOT NULL,
    payment_status VARCHAR(255)          NOT NULL,
    quantity       INT                   NOT NULL,
    item           VARCHAR(255)          NOT NULL,
    CONSTRAINT pk_order PRIMARY KEY (id)
);
