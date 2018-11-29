-- begin DAEX_CUSTOMER
create table DAEX_CUSTOMER (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(500),
    FULL_NAME text,
    INN varchar(12) not null,
    KPP varchar(9),
    EMAIL varchar(100),
    DD_BOX varchar(300),
    --
    primary key (ID)
)^
-- end DAEX_CUSTOMER
-- begin DAEX_HEAD_RPD
create table DAEX_HEAD_RPD (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    PRESSMARK varchar(50) not null,
    NAME varchar(255),
    --
    primary key (ID)
)^
-- end DAEX_HEAD_RPD
-- begin DAEX_CERTIFICATE
create table DAEX_CERTIFICATE (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NUMBER_ varchar(50) not null,
    WORKING_DERCTION varchar(250) not null,
    DELIVERY date not null,
    ENDING date not null,
    EMPLOYEE_ID uuid,
    --
    primary key (ID)
)^
-- end DAEX_CERTIFICATE
-- begin DAEX_EMPLOYEE
create table DAEX_EMPLOYEE (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    FIRST_NAME varchar(50) not null,
    MIDLE_NAME varchar(50),
    LAST_NAME varchar(50),
    POSITION_ varchar(300),
    USER_SYS_ID uuid not null,
    --
    primary key (ID)
)^
-- end DAEX_EMPLOYEE
-- begin DAEX_REMARK_ANSWER
create table DAEX_REMARK_ANSWER (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    REMARK text not null,
    ANSWER text,
    IS_FIXED boolean not null,
    AUTHOR varchar(100),
    RPD_FILE_ID uuid not null,
    --
    primary key (ID)
)^
-- end DAEX_REMARK_ANSWER
-- begin DAEX_RPD_FILE
create table DAEX_RPD_FILE (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    INCOMEDATE timestamp,
    IS_FINAL boolean not null,
    BEGINNINGDATE timestamp,
    ENDINGDATE timestamp,
    RPD_ID uuid not null,
    --
    primary key (ID)
)^
-- end DAEX_RPD_FILE
-- begin DAEX_RPD
create table DAEX_RPD (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    HEAD_RPD_ID uuid not null,
    TOM integer not null,
    PRESSMARK varchar(100),
    EXPERTISE_RPD_ID uuid not null,
    --
    primary key (ID)
)^
-- end DAEX_RPD
-- begin DAEX_ACCESS_SETTINGS
create table DAEX_ACCESS_SETTINGS (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    USER_ID uuid,
    EMPLOYEE_ID uuid,
    IS_READ boolean,
    EXPERTISE_ACCESS_SETTINGS_ID uuid,
    --
    primary key (ID)
)^
-- end DAEX_ACCESS_SETTINGS
-- begin DAEX_EXPERTISE
create table DAEX_EXPERTISE (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    EX_NUMBER varchar(50) not null,
    EGRZ_NUMBER varchar(100),
    IS_ARCHIVE boolean not null,
    IS_COMPLETED boolean not null,
    PRESSMARK varchar(100) not null,
    LEADER_EMPLOYEE_ID uuid not null,
    CUSTOMER_MAIN_ID uuid not null,
    CUSTOMER_TECH_ID uuid,
    AGREEMENT_NUMBER varchar(50) not null,
    AGREEMENT_DATE date not null,
    COST double precision,
    SUBJECT_NAME varchar(200) not null,
    SUBJECT_ADDRESS varchar(200) not null,
    GPZU varchar(100) not null,
    --
    primary key (ID)
)^
-- end DAEX_EXPERTISE
-- begin DAEX_INCOMING_DOCUMENT
create table DAEX_INCOMING_DOCUMENT (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    DESCRIPTION text,
    --
    primary key (ID)
)^
-- end DAEX_INCOMING_DOCUMENT
-- begin DAEX_INCOMING_DOCUMENT_FILE_DESCRIPTOR_LINK
create table DAEX_INCOMING_DOCUMENT_FILE_DESCRIPTOR_LINK (
    INCOMING_DOCUMENT_ID uuid,
    FILE_DESCRIPTOR_ID uuid,
    primary key (INCOMING_DOCUMENT_ID, FILE_DESCRIPTOR_ID)
)^
-- end DAEX_INCOMING_DOCUMENT_FILE_DESCRIPTOR_LINK
-- begin DAEX_RPD_FILE_FILE_DESCRIPTOR_LINK
create table DAEX_RPD_FILE_FILE_DESCRIPTOR_LINK (
    R_P_D_FILE_ID uuid,
    FILE_DESCRIPTOR_ID uuid,
    primary key (R_P_D_FILE_ID, FILE_DESCRIPTOR_ID)
)^
-- end DAEX_RPD_FILE_FILE_DESCRIPTOR_LINK
-- begin DAEX_EXPERTISE_FILE_DESCRIPTOR_LINK
create table DAEX_EXPERTISE_FILE_DESCRIPTOR_LINK (
    EXPERTISE_ID uuid,
    FILE_DESCRIPTOR_ID uuid,
    primary key (EXPERTISE_ID, FILE_DESCRIPTOR_ID)
)^
-- end DAEX_EXPERTISE_FILE_DESCRIPTOR_LINK
-- begin DAEX_REMARK_ANSWER_FILE_DESCRIPTOR_LINK
create table DAEX_REMARK_ANSWER_FILE_DESCRIPTOR_LINK (
    REMARK_ANSWER_ID uuid,
    FILE_DESCRIPTOR_ID uuid,
    primary key (REMARK_ANSWER_ID, FILE_DESCRIPTOR_ID)
)^
-- end DAEX_REMARK_ANSWER_FILE_DESCRIPTOR_LINK
-- begin DAEX_INCOMING_DOCUMENT_FILE_DESCRIPTOR
create table DAEX_INCOMING_DOCUMENT_FILE_DESCRIPTOR (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    INCOMING_DOCUMENT_ID uuid,
    FILE_DESCRIPTOR_ID uuid,
    --
    primary key (ID)
)^
-- end DAEX_INCOMING_DOCUMENT_FILE_DESCRIPTOR
