CREATE TABLE bank
(
    bank_code VARCHAR2(20), 
    bank_name VARCHAR2(30)
);

CREATE TABLE customer
(
    NO NUMBER,
    NAME VARCHAR2(30) NOT NULL,
    phone VARCHAR2(30),
    age NUMBER,
    bank_code VARCHAR2(20) 
);

alter table bank add constraint bank_pk primary key (bank_code);
alter table customer add constraint customer_pk primary key (no);
alter table customer add constraint customer_phone_uk unique (phone);
alter table customer add constraint customer_age_ck check (age between 0 and 100);
alter table customer add constraint customer_bank_fk foreign key (bank_code) references bank(bank_code); 