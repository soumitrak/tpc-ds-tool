# tpc-ds-tool

Download the official TPC-DS Tools from https://www.tpc.org/tpc_documents_current_versions/current_specifications5.asp

This repo is based on version 3.2.0rc1 (v3.2.0rc1) and has few fixes to compile and run on gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)

* Multiple definition of global variables (commit 2412855eb0a4c413d0de138bbc6d845e2e82a304)
Sample errors:
/usr/bin/ld: s_purchase.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_purchase.c:55: multiple definition of `nItemIndex'; s_catalog_order.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_catalog_order.c:56: first defined here
/usr/bin/ld: s_web_order.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_web_order.c:56: multiple definition of `nItemIndex'; s_catalog_order.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_catalog_order.c:56: first defined here
/usr/bin/ld: s_web_order_lineitem.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_web_order_lineitem.c:54: multiple definition of `g_s_web_order_lineitem'; s_web_order.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_web_order.c:54: first defined here
/usr/bin/ld: w_catalog_page.o:/home/soumitra/opensource/tpc-ds-tool/tools/w_catalog_page.c:52: multiple definition of `g_w_catalog_page'; s_catalog_page.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_catalog_page.c:51: first defined here
/usr/bin/ld: w_warehouse.o:/home/soumitra/opensource/tpc-ds-tool/tools/w_warehouse.c:53: multiple definition of `g_w_warehouse'; s_warehouse.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_warehouse.c:51: first defined here
/usr/bin/ld: w_web_site.o:/home/soumitra/opensource/tpc-ds-tool/tools/w_web_site.c:59: multiple definition of `g_w_web_site'; s_web_site.o:/home/soumitra/opensource/tpc-ds-tool/tools/s_web_site.c:51: first defined here

* Multiple definition of yydebug (commit 4d300e940592d029c63ae9e40c09848c992ceee6)
/usr/bin/ld: y.tab.o:/home/soumitra/opensource/tpc-ds-tool/tools/y.tab.c:1227: multiple definition of `yydebug'; QgenMain.o:/home/soumitra/opensource/tpc-ds-tool/tools/QgenMain.c:70: first defined here

## Setup

### Ubuntu - install prereqs

```
sudo apt-get install gcc make flex bison byacc git
```

Clone the repo and build the tools:

```
git clone https://github.com/soumitrak/tpc-ds-tool.git
cd tpc-ds-tool/tools
make
```

