# tpc-ds-tool

Download the official TPC-DS Tools from https://www.tpc.org/tpc_documents_current_versions/current_specifications5.asp

This repo is based on version 3.2.0rc1 (v3.2.0rc1) and has few fixes to compile and run on gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)

* Multiple definition of global variables during make (commit 2412855eb0a4c413d0de138bbc6d845e2e82a304)

Sample errors:
/usr/bin/ld: s_purchase.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_purchase.c:55: multiple definition of `nItemIndex'; s_catalog_order.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_catalog_order.c:56: first defined here
/usr/bin/ld: s_web_order.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_web_order.c:56: multiple definition of `nItemIndex'; s_catalog_order.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_catalog_order.c:56: first defined here
/usr/bin/ld: s_web_order_lineitem.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_web_order_lineitem.c:54: multiple definition of `g_s_web_order_lineitem'; s_web_order.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_web_order.c:54: first defined here
/usr/bin/ld: w_catalog_page.o:/home/soumitra/opensource/tpc-ds-tool/tools/w_catalog_page.c:52: multiple definition of `g_w_catalog_page'; s_catalog_page.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_catalog_page.c:51: first defined here
/usr/bin/ld: w_warehouse.o:/home/soumitra/opensource/tpc-ds-tool/tools/w_warehouse.c:53: multiple definition of `g_w_warehouse'; s_warehouse.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_warehouse.c:51: first defined here
/usr/bin/ld: w_web_site.o:/home/soumitra/opensource/tpc-ds-tool/tools/w_web_site.c:59: multiple definition of `g_w_web_site'; s_web_site.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_web_site.c:51: first defined here

* Multiple definition of yydebug during make (commit 4d300e940592d029c63ae9e40c09848c992ceee6)

/usr/bin/ld: y.tab.o:/home/soumitra/opensource/tpc-ds-tool/tools/y.tab.c:1227: multiple definition of `yydebug'; QgenMain.o:/home/soumitra/opensource/tpc-ds-tool/tools/QgenMain.c:70: first defined here

* Error during query generation (commit ae026074bce78ae83f89e487f9c644302b09ac64)

```
~/opensource/tpc-ds-tool/tools$ ./dsqgen -template query1.tpl -directory ../query_templates -dialect netezza -scale 1
qgen2 Query Generator (Version 3.2.0)
Copyright Transaction Processing Performance Council (TPC) 2001 - 2021
Warning: This scale factor is valid for QUALIFICATION ONLY
ERROR: Substitution'_END' is used before being initialized at line 63 in ../query_templates/query1.tpl
```

* Invalid date arithmetic in few queries (commit 82125cde442d68af740bf1a0fe53e606a9093480)

```
Error while running query5.sql
Syntax error at or near ')'(line 28, pos 60)

== SQL ==
...
                  and (cast('1998-08-04' as date) +  14 days)
------------------------------------------------------------^^^

```

* Invalid token in few queries (commit 82125cde442d68af740bf1a0fe53e606a9093480)


```
Error while running query16.sql
Syntax error at or near '"order count"'(line 2, pos 38)

== SQL ==
select  
   count(distinct cs_order_number) as "order count"
--------------------------------------^^^

```

## Setup

### Ubuntu

Install prereqs

```
sudo apt-get install gcc make flex bison byacc git
```

Clone the repo and build the tools:

```
git clone https://github.com/soumitrak/tpc-ds-tool.git
cd tpc-ds-tool/tools
make
```

## Data gen

```
cd <tpc-ds-tool>/tools
./dsdgen -verbose y -terminate n -scale <scale factor X> -dir <output data directory>
# X = 1 => 1G dataset, 10 => 10G dataset
```

Sample run:
```
~/opensource/tpc-ds-tool/tools$ ./dsdgen -verbose y -terminate n -scale 1 -dir /tmp/1
dsdgen Population Generator (Version 3.2.0)
Copyright Transaction Processing Performance Council (TPC) 2001 - 2021
Warning: This scale factor is valid for QUALIFICATION ONLY
~/opensource/tpc-ds-tool/tools$ ls /tmp/1
call_center.dat       customer.dat                income_band.dat  ship_mode.dat      warehouse.dat
catalog_page.dat      customer_demographics.dat   inventory.dat    store.dat          web_page.dat
catalog_returns.dat   date_dim.dat                item.dat         store_returns.dat  web_returns.dat
catalog_sales.dat     dbgen_version.dat           promotion.dat    store_sales.dat    web_sales.dat
customer_address.dat  household_demographics.dat  reason.dat       time_dim.dat       web_site.dat
~/opensource/tpc-ds-tool/tools$ du -sh /tmp/1
1.2G	/tmp/1
```

## Query gen

```
cd <tpc-ds-tool>/tools
./gen_queries.bash <scale factor> <output script directory>
```

