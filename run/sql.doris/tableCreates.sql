create table bmsql_config (
  cfg_name    varchar(30) ,
  cfg_value   varchar(50)
)
unique key(`cfg_name`)
DISTRIBUTED BY HASH(`cfg_name`) BUCKETS 1
;

create table bmsql_warehouse (
  w_id        integer   not null,
  w_ytd       decimal(12,2),
  w_tax       decimal(4,4),
  w_name      varchar(10),
  w_street_1  varchar(20),
  w_street_2  varchar(20),
  w_city      varchar(20),
  w_state     char(2),
  w_zip       char(9)
)unique key(`w_id`)
DISTRIBUTED BY HASH(`w_id`) BUCKETS 16;

create table bmsql_district (
  d_w_id       integer       not null,
  d_id         integer       not null,
  d_ytd        decimal(12,2),
  d_tax        decimal(4,4),
  d_next_o_id  integer,
  d_name       varchar(10),
  d_street_1   varchar(20),
  d_street_2   varchar(20),
  d_city       varchar(20),
  d_state      char(2),
  d_zip        char(9)
)unique key(d_w_id, d_id)
DISTRIBUTED BY HASH(d_w_id, d_id) BUCKETS 16;

create table bmsql_customer (
  c_w_id         integer        not null,
  c_d_id         integer        not null,
  c_id           integer        not null,
  c_discount     decimal(4,4),
  c_credit       char(2),
  c_last         varchar(16),
  c_first        varchar(16),
  c_credit_lim   decimal(12,2),
  c_balance      decimal(12,2),
  c_ytd_payment  decimal(12,2),
  c_payment_cnt  integer,
  c_delivery_cnt integer,
  c_street_1     varchar(20),
  c_street_2     varchar(20),
  c_city         varchar(20),
  c_state        char(2),
  c_zip          char(9),
  c_phone        char(16),
  c_since        DATETIME,
  c_middle       char(2),
  c_data         varchar(500)
)unique key(c_w_id, c_d_id, c_id)
DISTRIBUTED BY HASH(c_w_id, c_d_id, c_id) BUCKETS 4;

-- create sequence bmsql_hist_id_seq;

create table bmsql_history (
  hist_id  integer not null,
  h_c_id   integer,
  h_c_d_id integer,
  h_c_w_id integer,
  h_d_id   integer,
  h_w_id   integer,
  h_date   DATETIME,
  h_amount decimal(6,2),
  h_data   varchar(24)
)unique key(hist_id)
DISTRIBUTED BY HASH(hist_id) BUCKETS 4;

create table bmsql_new_order (
  no_w_id  integer   not null,
  no_d_id  integer   not null,
  no_o_id  integer   not null
)unique key(no_w_id, no_d_id, no_o_id)
DISTRIBUTED BY HASH(no_w_id, no_d_id, no_o_id) BUCKETS 4;

create table bmsql_oorder (
  o_w_id       integer      not null,
  o_d_id       integer      not null,
  o_id         integer      not null,
  o_c_id       integer,
  o_carrier_id integer,
  o_ol_cnt     integer,
  o_all_local  integer,
  o_entry_d    DATETIME
)unique key(o_w_id, o_d_id, o_id)
DISTRIBUTED BY HASH(o_w_id, o_d_id, o_id) BUCKETS 4;

create table bmsql_order_line (
  ol_w_id         integer   not null,
  ol_d_id         integer   not null,
  ol_o_id         integer   not null,
  ol_number       integer   not null,
  ol_i_id         integer   not null,
  ol_delivery_d   datetime,
  ol_amount       decimal(6,2),
  ol_supply_w_id  integer,
  ol_quantity     integer,
  ol_dist_info    char(24)
)unique key(ol_w_id, ol_d_id, ol_o_id, ol_number)
DISTRIBUTED BY HASH(ol_w_id, ol_d_id, ol_o_id, ol_number) BUCKETS 4;

create table bmsql_item (
  i_id     integer      not null,
  i_name   varchar(24),
  i_price  decimal(5,2),
  i_data   varchar(50),
  i_im_id  integer
)unique key(`i_id`)
DISTRIBUTED BY HASH(i_id) BUCKETS 4;

create table bmsql_stock (
  s_w_id       integer       not null,
  s_i_id       integer       not null,
  s_quantity   integer,
  s_ytd        integer,
  s_order_cnt  integer,
  s_remote_cnt integer,
  s_data       varchar(50),
  s_dist_01    char(24),
  s_dist_02    char(24),
  s_dist_03    char(24),
  s_dist_04    char(24),
  s_dist_05    char(24),
  s_dist_06    char(24),
  s_dist_07    char(24),
  s_dist_08    char(24),
  s_dist_09    char(24),
  s_dist_10    char(24)
)unique key(s_w_id, s_i_id)
DISTRIBUTED BY HASH(s_w_id, s_i_id) BUCKETS 4;
