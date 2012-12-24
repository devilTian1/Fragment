BEGIN TRANSACTION;
CREATE TABLE basic_configure
(
    role                    CHAR(1),  --'M':master 'S':slave 'N':node
    mode                    CHAR(1),  --'P':preempt mode 'N':nonpreempt mode
    ifcfg                   CHAR(1),  --'D':disable physical net work device 'E':not disable
    peer_ha_ip              CHAR(15), --peer gap ha ip address
    peer_ha_port    INT               --peer gap ha port number
);
INSERT INTO "basic_configure" VALUES('M','P','E','0.0.0.0',8000);
CREATE TABLE haif 
(
    ifname                  CHAR(15),   --network interface alias name
    pro                     CHAR(15)    --network proctol (ipv4 or ipv6)
    --dev                   CHAR(20),
    --ip                    CHAR(128),
    --mask                  CHAR(20)
);
CREATE TABLE service 
(
    id              INT,
    virtual_ip      CHAR(15),
    virtual_port    INT,
    real_ip         CHAR(15),
    real_port       INT
);
CREATE TABLE sync_cfg_server
(
    host        CHAR(15),
    service     INT
);
INSERT INTO "sync_cfg_server" VALUES('0.0.0.0',8000);
CREATE TABLE sync_cfg_client
(
    host        CHAR(15),
    service     INT
);
INSERT INTO "sync_cfg_client" VALUES('0.0.0.0',8000);
COMMIT;
