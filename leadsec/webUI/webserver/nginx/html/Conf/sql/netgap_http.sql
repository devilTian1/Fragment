BEGIN TRANSACTION;

create table basic_configure 
(
	service_ip	CHAR(50),
	service_port	INT
);

insert into basic_configure (service_ip, service_port) values ("0.0.0.0", 80);

create table http_method
(
	method	CHAR(15),
	allow	BOOL
);

insert into http_method (method, allow) values ('GET', 1);
insert into http_method (method, allow) values ('POST', 1);
insert into http_method (method, allow) values ('CONNECT', 1);
insert into http_method (method, allow) values ('HEAD', 1);

--create table http_port
--(
--	port	INT,
--	https	BOOL
--);
--insert into http_port (port, https) values (80, 0);
--insert into http_port (port, https) values (21, 0);
--insert into http_port (port, https) values (443, 0);
--insert into http_port (port, https) values (563, 0);
--insert into http_port (port, https) values (70, 0);
--insert into http_port (port, https) values (210, 0);
--insert into http_port (port, https) values (280, 0);
--insert into http_port (port, https) values (488, 0);
--insert into http_port (port, https) values (591, 0);
--insert into http_port (port, https) values (777, 0);
--insert into http_port (port, https) values (443, 1);
--insert into http_port (port, https) values (563, 1);

create table http_port
(
	port	CHAR(15),
	https	BOOL
);
insert into http_port (port, https) values ('80', 0);
insert into http_port (port, https) values ('21', 0);
insert into http_port (port, https) values ('443', 0);
insert into http_port (port, https) values ('563', 0);
insert into http_port (port, https) values ('70', 0);
insert into http_port (port, https) values ('210', 0);
insert into http_port (port, https) values ('280', 0);
insert into http_port (port, https) values ('488', 0);
insert into http_port (port, https) values ('591', 0);
insert into http_port (port, https) values ('777', 0);
--insert into http_port (port, https) values ('1-65535', 0);    
insert into http_port (port, https) values ('443', 1);
insert into http_port (port, https) values ('563', 1);
--insert into http_port (port, https) values ('1-65535', 1);   

create table acl 
(
	id	INT,
	sip	CHAR(15),
	dip	CHAR(15),
	port	INT,
	usergrp		CHAR(50),	--认证用户组
	time	CHAR(15),
	transparent	BOOL,
	https		BOOL,
	comment	VARCHAR(255)
);

create table auth_info
(
	mode		CHAR(1),  --N:noauth S:local R:Radius L:Ldap
	radius_ip	CHAR(15),
	radius_port	INT,
	radius_passwd	CHAR(15),
	ldap_ip		CHAR(15),
	ldap_dn		CHAR(30),
	ldap_attr	CHAR(30),
	ldap_opt	BOOL,
	comment		VARCHAR(255)
);

insert into auth_info (mode, radius_ip, radius_port, radius_passwd, ldap_ip, ldap_dn, ldap_attr, ldap_opt, comment) values ("N", "", "", 0, "", "", "", 0, "");

create table user
(
	name	CHAR(15),
	passwd	CHAR(255),
	comment	VARCHAR(255)
);

create table cf_info
(
	activex		BOOL,
	cookie		BOOL,
	javascript	BOOL,
	javaapplet	BOOL,
	application	CHAR(1),  --N:no forbid. F:full forbid. P:partial forbid
	video		CHAR(1),
	audio		CHAR(1),
	image		CHAR(1),
	text		CHAR(1)
);

insert into cf_info (activex, cookie, javascript, javaapplet, application, video, audio, image, text) values (0, 0, 0, 0, "N", "N", "N", "N", "N");

create table mime
(
	name	CHAR(50),
	type	CHAR(1),		--A:Application V:Video
					--U:aUdio  I:Image  T:Text
	checkflag	BOOL
);


insert into mime (type, name, checkflag ) values ("A", "activemessage", 0);
insert into mime (type, name, checkflag ) values ("A", "andrew-inset", 0);
insert into mime (type, name, checkflag ) values ("A", "applefile", 0);
insert into mime (type, name, checkflag ) values ("A", "atomicmail", 0);
insert into mime (type, name, checkflag ) values ("A", "batch-SMTP", 0);
insert into mime (type, name, checkflag ) values ("A", "beep+xml", 0);
insert into mime (type, name, checkflag ) values ("A", "cals-1840", 0);
insert into mime (type, name, checkflag ) values ("A", "commonground", 0);
insert into mime (type, name, checkflag ) values ("A", "cybercash", 0);
insert into mime (type, name, checkflag ) values ("A", "dca-rft", 0);
insert into mime (type, name, checkflag ) values ("A", "dec-dx", 0);
insert into mime (type, name, checkflag ) values ("A", "dvcs", 0);
insert into mime (type, name, checkflag ) values ("A", "EDI-Consent", 0);
insert into mime (type, name, checkflag ) values ("A", "EDIFACT", 0);
insert into mime (type, name, checkflag ) values ("A", "EDI-X12", 0);
insert into mime (type, name, checkflag ) values ("A", "eshop", 0);
insert into mime (type, name, checkflag ) values ("A", "font-tdpfr", 0);
insert into mime (type, name, checkflag ) values ("A", "http", 0);
insert into mime (type, name, checkflag ) values ("A", "hyperstudio", 0);
insert into mime (type, name, checkflag ) values ("A", "iges", 0);
insert into mime (type, name, checkflag ) values ("A", "index", 0);
insert into mime (type, name, checkflag ) values ("A", "index.cmd", 0);
insert into mime (type, name, checkflag ) values ("A", "index.obj", 0);
insert into mime (type, name, checkflag ) values ("A", "index.response", 0);
insert into mime (type, name, checkflag ) values ("A", "index.vnd", 0);
insert into mime (type, name, checkflag ) values ("A", "iotp", 0);
insert into mime (type, name, checkflag ) values ("A", "ipp", 0);
insert into mime (type, name, checkflag ) values ("A", "isup", 0);
insert into mime (type, name, checkflag ) values ("A", "mac-binhex40", 0);
insert into mime (type, name, checkflag ) values ("A", "mac-compactpro", 0);
insert into mime (type, name, checkflag ) values ("A", "macwriteii", 0);
insert into mime (type, name, checkflag ) values ("A", "marc", 0);
insert into mime (type, name, checkflag ) values ("A", "mathematica", 0);
insert into mime (type, name, checkflag ) values ("A", "mathematica-old", 0);
insert into mime (type, name, checkflag ) values ("A", "msexcel", 0);
insert into mime (type, name, checkflag ) values ("A", "msword", 0);
insert into mime (type, name, checkflag ) values ("A", "news-message-id", 0);
insert into mime (type, name, checkflag ) values ("A", "news-transmission", 0);
insert into mime (type, name, checkflag ) values ("A", "ocsp-request", 0);
insert into mime (type, name, checkflag ) values ("A", "ocsp-response", 0);
insert into mime (type, name, checkflag ) values ("A", "octet-stream", 0);
insert into mime (type, name, checkflag ) values ("A", "oda", 0);
insert into mime (type, name, checkflag ) values ("A", "parityfec", 0);
insert into mime (type, name, checkflag ) values ("A", "pdf", 0);
insert into mime (type, name, checkflag ) values ("A", "pgp-encrypted", 0);
insert into mime (type, name, checkflag ) values ("A", "pgp-keys", 0);
insert into mime (type, name, checkflag ) values ("A", "pgp-signature", 0);
insert into mime (type, name, checkflag ) values ("A", "pkcs10", 0);
insert into mime (type, name, checkflag ) values ("A", "pkcs7-mime", 0);
insert into mime (type, name, checkflag ) values ("A", "pkcs7-signature", 0);
insert into mime (type, name, checkflag ) values ("A", "pkix-cert", 0);
insert into mime (type, name, checkflag ) values ("A", "pkixcmp", 0);
insert into mime (type, name, checkflag ) values ("A", "pkix-crl", 0);
insert into mime (type, name, checkflag ) values ("A", "postscript", 0);
insert into mime (type, name, checkflag ) values ("A", "prs.alvestrand.titrax-sheet", 0);
insert into mime (type, name, checkflag ) values ("A", "prs.cww", 0);
insert into mime (type, name, checkflag ) values ("A", "prs.nprend", 0);
insert into mime (type, name, checkflag ) values ("A", "qsig", 0);
insert into mime (type, name, checkflag ) values ("A", "remote-printing", 0);
insert into mime (type, name, checkflag ) values ("A", "riscos", 0);
insert into mime (type, name, checkflag ) values ("A", "rtf", 0);
insert into mime (type, name, checkflag ) values ("A", "sdp", 0);
insert into mime (type, name, checkflag ) values ("A", "set-payment", 0);
insert into mime (type, name, checkflag ) values ("A", "set-payment-initiation", 0);
insert into mime (type, name, checkflag ) values ("A", "set-registration", 0);
insert into mime (type, name, checkflag ) values ("A", "set-registration-initiation", 0);
insert into mime (type, name, checkflag ) values ("A", "sgml", 0);
insert into mime (type, name, checkflag ) values ("A", "sgml-open-catalog", 0);
insert into mime (type, name, checkflag ) values ("A", "sieve", 0);
insert into mime (type, name, checkflag ) values ("A", "slate", 0);
insert into mime (type, name, checkflag ) values ("A", "smil", 0);
insert into mime (type, name, checkflag ) values ("A", "timestamp-query", 0);
insert into mime (type, name, checkflag ) values ("A", "timestamp-reply", 0);
insert into mime (type, name, checkflag ) values ("A", "vemmi", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.3M.Post-it-Notes", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.accpac.simply.aso", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.accpac.simply.imp", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.acucobol", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.aether.imp", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.anser-web-certificate-issue-initiation", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.anser-web-funds-transfer-initiation", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.audiograph", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.bmi", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.businessobjects", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.canon-cpdl", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.canon-lips", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.claymore", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.commerce-battelle", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.commonspace", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.comsocaller", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.contact.cmsg", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.cosmocaller", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ctc-posml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.cups-postscript", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.cups-raster", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.cups-raw", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.cybank", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.dna", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.dpgraph", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.dxr", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ecdis-update", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ecowin.chart", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ecowin.filerequest", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ecowin.fileupdate", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ecowin.series", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ecowin.seriesrequest", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ecowin.seriesupdate", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.enliven", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.epson.esf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.epson.msf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.epson.quickanime", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.epson.salt", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.epson.ssf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ericsson.quickcall", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.eudora.data", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fdf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ffsns", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.FloGraphIt", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.framemaker", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fsc.weblaunch", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fujitsu.oasys", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fujitsu.oasys2", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fujitsu.oasys3", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fujitsu.oasysgp", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fujitsu.oasysprs", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fujixerox.ddd", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fujixerox.docuworks", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fujixerox.docuworks.binder", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.fut-misnet", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.grafeq", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.groove-account", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.groove-identity-message", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.groove-injector", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.groove-tool-message", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.groove-tool-template", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.groove-vcard", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.hhe.lesson-player", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.hp-HPGL", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.hp-hpid", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.hp-hps", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.hp-PCL", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.hp-PCLXL", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.httphone", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.hzn-3d-crossword", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ibm.afplinedata", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ibm.MiniPay", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ibm.modcap", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.informix-visionary", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.intercon.formnet", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.intertrust.digibox", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.intertrust.nncp", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.intu.qbo", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.intu.qfx", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.irepository.package+xml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.is-xpr", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.japannet-directory-service", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.japannet-jpnstore-wakeup", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.japannet-payment-wakeup", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.japannet-registration", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.japannet-registration-wakeup", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.japannet-setstore-wakeup", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.japannet-verification", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.japannet-verification-wakeup", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.koan", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.lotus-1-2-3", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.lotus-approach", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.lotus-freelance", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.lotus-notes", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.lotus-organizer", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.lotus-screencam", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.lotus-wordpro", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mcd", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mediastation.cdkey", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.meridian-slingshot", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mif", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.minisoft-hp3000-save", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mitsubishi.misty-guard.trustweb", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mobius.daf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mobius.dis", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mobius.msl", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mobius.plc", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mobius.txf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.motorola.flexsuite", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.motorola.flexsuite.adsi", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.motorola.flexsuite.fis", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.motorola.flexsuite.gotap", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.motorola.flexsuite.kmr", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.motorola.flexsuite.ttc", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.motorola.flexsuite.wem", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mozilla.xul+xml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ms-artgalry", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ms-asf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.mseq", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ms-excel", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.msign", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ms-lrm", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ms-powerpoint", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ms-project", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ms-tnef", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ms-works", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.musician", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.music-niff", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.netfpx", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.noblenet-directory", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.noblenet-sealer", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.noblenet-web", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.novadigm.EDM", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.novadigm.EDX", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.novadigm.EXT", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.osa.netdeploy", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.palm", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.pg.format", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.pg.osasli", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.powerbuilder6", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.powerbuilder6-s", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.powerbuilder7", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.powerbuilder75", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.powerbuilder75-s", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.powerbuilder7-s", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.previewsystems.box", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.publishare-delta-tree", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.pvi.ptid1", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.pwg-xhtml-print+xml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.rapid", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.s3sms", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.seemail", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.shana.informed.formdata", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.shana.informed.formtemplate", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.shana.informed.interchange", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.shana.informed.package", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.sss-cod", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.sss-dtf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.sss-ntf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.street-stream", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.svd", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.swiftview-ics", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.triscape.mxs", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.trueapp", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.truedoc", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.tve-trigger", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.ufdl", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.alert", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.alert-wbxml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.bearer-choice", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.bearer-choice-wbxml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.cacheop", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.cacheop-wbxml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.channel", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.channel-wbxml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.list", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.listcmd", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.listcmd-wbxml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.list-wbxml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.uplanet.signal", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.vcx", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.vectorworks", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.vidsoft.vidconference", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.visio", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.vividence.scriptfile", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.wap.sic", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.wap.slc", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.wap.wbxml", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.wap.wmlc", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.wap.wmlscriptc", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.webturbo", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.wrq-hp3000-labelled", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.wt.stf", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.xara", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.xfdl", 0);
insert into mime (type, name, checkflag ) values ("A", "vnd.yellowriver-custom-menu", 0);
insert into mime (type, name, checkflag ) values ("A", "whoispp-query", 0);
insert into mime (type, name, checkflag ) values ("A", "whoispp-response", 0);
insert into mime (type, name, checkflag ) values ("A", "wita", 0);
insert into mime (type, name, checkflag ) values ("A", "wordperfect5.1", 0);
insert into mime (type, name, checkflag ) values ("A", "x400-bp", 0);
insert into mime (type, name, checkflag ) values ("A", "x-bcpio", 0);
insert into mime (type, name, checkflag ) values ("A", "x-bzip2", 0);
insert into mime (type, name, checkflag ) values ("A", "x-cdlink", 0);
insert into mime (type, name, checkflag ) values ("A", "x-chess-pgn", 0);
insert into mime (type, name, checkflag ) values ("A", "x-compress", 0);
insert into mime (type, name, checkflag ) values ("A", "x-cpio", 0);
insert into mime (type, name, checkflag ) values ("A", "x-csh", 0);
insert into mime (type, name, checkflag ) values ("A", "x-director", 0);
insert into mime (type, name, checkflag ) values ("A", "x-dvi", 0);
insert into mime (type, name, checkflag ) values ("A", "x-futuresplash", 0);
insert into mime (type, name, checkflag ) values ("A", "x-gtar", 0);
insert into mime (type, name, checkflag ) values ("A", "x-gzip", 0);
insert into mime (type, name, checkflag ) values ("A", "x-hdf", 0);
insert into mime (type, name, checkflag ) values ("A", "xhtml+xml", 0);
insert into mime (type, name, checkflag ) values ("A", "x-javascript", 0);
insert into mime (type, name, checkflag ) values ("A", "x-kchart", 0);
insert into mime (type, name, checkflag ) values ("A", "x-killustrator", 0);
insert into mime (type, name, checkflag ) values ("A", "x-koan", 0);
insert into mime (type, name, checkflag ) values ("A", "x-kpresenter", 0);
insert into mime (type, name, checkflag ) values ("A", "x-kspread", 0);
insert into mime (type, name, checkflag ) values ("A", "x-kword", 0);
insert into mime (type, name, checkflag ) values ("A", "x-latex", 0);
insert into mime (type, name, checkflag ) values ("A", "x-mif", 0);
insert into mime (type, name, checkflag ) values ("A", "xml", 0);
insert into mime (type, name, checkflag ) values ("A", "xml-dtd", 0);
insert into mime (type, name, checkflag ) values ("A", "xml-external-parsed-entity", 0);
insert into mime (type, name, checkflag ) values ("A", "x-netcdf", 0);
insert into mime (type, name, checkflag ) values ("A", "x-ogg", 0);
insert into mime (type, name, checkflag ) values ("A", "x-rpm", 0);
insert into mime (type, name, checkflag ) values ("A", "x-rtf", 0);
insert into mime (type, name, checkflag ) values ("A", "x-sh", 0);
insert into mime (type, name, checkflag ) values ("A", "x-shar", 0);
insert into mime (type, name, checkflag ) values ("A", "x-shockwave-flash", 0);
insert into mime (type, name, checkflag ) values ("A", "x-stuffit", 0);
insert into mime (type, name, checkflag ) values ("A", "x-sv4cpio", 0);
insert into mime (type, name, checkflag ) values ("A", "x-sv4crc", 0);
insert into mime (type, name, checkflag ) values ("A", "x-tar", 0);
insert into mime (type, name, checkflag ) values ("A", "x-tcl", 0);
insert into mime (type, name, checkflag ) values ("A", "x-tex", 0);
insert into mime (type, name, checkflag ) values ("A", "x-texinfo", 0);
insert into mime (type, name, checkflag ) values ("A", "x-troff", 0);
insert into mime (type, name, checkflag ) values ("A", "x-troff-man", 0);
insert into mime (type, name, checkflag ) values ("A", "x-troff-me", 0);
insert into mime (type, name, checkflag ) values ("A", "x-troff-ms", 0);
insert into mime (type, name, checkflag ) values ("A", "x-ustar", 0);
insert into mime (type, name, checkflag ) values ("A", "x-wais-source", 0);
insert into mime (type, name, checkflag ) values ("A", "x-zip-compressed", 0);
insert into mime (type, name, checkflag ) values ("A", "zip", 0);

insert into mime (type, name, checkflag ) values ("U", "32kadpcm", 0);
insert into mime (type, name, checkflag ) values ("U", "basic", 0);
insert into mime (type, name, checkflag ) values ("U", "g.722.1", 0);
insert into mime (type, name, checkflag ) values ("U", "l16", 0);
insert into mime (type, name, checkflag ) values ("U", "midi", 0);
insert into mime (type, name, checkflag ) values ("U", "mp4a-latm", 0);
insert into mime (type, name, checkflag ) values ("U", "mpa-robust", 0);
insert into mime (type, name, checkflag ) values ("U", "mpeg", 0);
insert into mime (type, name, checkflag ) values ("U", "parityfec", 0);
insert into mime (type, name, checkflag ) values ("U", "prs.sid", 0);
insert into mime (type, name, checkflag ) values ("U", "telephone-event", 0);
insert into mime (type, name, checkflag ) values ("U", "tone", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.cisco.nse", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.cns.anp1", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.cns.inf1", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.digital-winds", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.everad.plj", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.lucent.voice", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.nortel.vbk", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.nuera.ecelp4800", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.nuera.ecelp7470", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.nuera.ecelp9600", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.octel.sbc", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.qcelp", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.rhetorex.32kadpcm", 0);
insert into mime (type, name, checkflag ) values ("U", "vnd.vmx.cvsd", 0);
insert into mime (type, name, checkflag ) values ("U", "x-aiff", 0);
insert into mime (type, name, checkflag ) values ("U", "x-mpegurl", 0);
insert into mime (type, name, checkflag ) values ("U", "x-pn-realaudio", 0);
insert into mime (type, name, checkflag ) values ("U", "x-pn-realaudio-plugin", 0);
insert into mime (type, name, checkflag ) values ("U", "x-realaudio", 0);
insert into mime (type, name, checkflag ) values ("U", "x-wav", 0);

insert into mime (type, name, checkflag ) values ("I", "bmp", 0);
insert into mime (type, name, checkflag ) values ("I", "cgm", 0);
insert into mime (type, name, checkflag ) values ("I", "cmu-raster", 0);
insert into mime (type, name, checkflag ) values ("I", "g3fax", 0);
insert into mime (type, name, checkflag ) values ("I", "gif", 0);
insert into mime (type, name, checkflag ) values ("I", "ief", 0);
insert into mime (type, name, checkflag ) values ("I", "jpeg", 0);
insert into mime (type, name, checkflag ) values ("I", "naplps", 0);
insert into mime (type, name, checkflag ) values ("I", "png", 0);
insert into mime (type, name, checkflag ) values ("I", "prs.btif", 0);
insert into mime (type, name, checkflag ) values ("I", "prs.pti", 0);
insert into mime (type, name, checkflag ) values ("I", "tiff", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.cns.inf2", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.djvu", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.dwg", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.dxf", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.fastbidsheet", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.fpx", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.fst", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.fujixerox.edmics-mmr", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.fujixerox.edmics-rlc", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.mix", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.net-fpx", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.svf", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.wap.wbmp", 0);
insert into mime (type, name, checkflag ) values ("I", "vnd.xiff", 0);
insert into mime (type, name, checkflag ) values ("I", "x-cmu-raster", 0);
insert into mime (type, name, checkflag ) values ("I", "x-portable-anymap", 0);
insert into mime (type, name, checkflag ) values ("I", "x-portable-bitmap", 0);
insert into mime (type, name, checkflag ) values ("I", "x-portable-graymap", 0);
insert into mime (type, name, checkflag ) values ("I", "x-portable-pixmap", 0);
insert into mime (type, name, checkflag ) values ("I", "x-rgb", 0);
insert into mime (type, name, checkflag ) values ("I", "x-xbitmap", 0);
insert into mime (type, name, checkflag ) values ("I", "x-xpixmap", 0);
insert into mime (type, name, checkflag ) values ("I", "x-xwindowdump", 0);


insert into mime (type, name, checkflag ) values ("T", "calendar", 0);
insert into mime (type, name, checkflag ) values ("T", "css", 0);
insert into mime (type, name, checkflag ) values ("T", "directory", 0);
insert into mime (type, name, checkflag ) values ("T", "enriched", 0);
insert into mime (type, name, checkflag ) values ("T", "html", 0);
insert into mime (type, name, checkflag ) values ("T", "parityfec", 0);
insert into mime (type, name, checkflag ) values ("T", "plain", 0);
insert into mime (type, name, checkflag ) values ("T", "prs.lines.tag", 0);
insert into mime (type, name, checkflag ) values ("T", "rfc822-headers", 0);
insert into mime (type, name, checkflag ) values ("T", "richtext", 0);
insert into mime (type, name, checkflag ) values ("T", "rtf", 0);
insert into mime (type, name, checkflag ) values ("T", "sgml", 0);
insert into mime (type, name, checkflag ) values ("T", "t140", 0);
insert into mime (type, name, checkflag ) values ("T", "tab-separated-values", 0);
insert into mime (type, name, checkflag ) values ("T", "uri-list", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.abc", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.curl", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.DMClientScript", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.flatland.3dml", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.fly", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.fmi.flexstor", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.in3d.3dml", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.in3d.spot", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.IPTC.NewsML", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.IPTC.NITF", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.latex-z", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.motorola.reflex", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.ms-mediapackage", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.wap.si", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.wap.sl", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.wap.wml", 0);
insert into mime (type, name, checkflag ) values ("T", "vnd.wap.wmlscript", 0);
insert into mime (type, name, checkflag ) values ("T", "xml", 0);
insert into mime (type, name, checkflag ) values ("T", "xml-external-parsed-entity", 0);
insert into mime (type, name, checkflag ) values ("T", "x-setext", 0);


insert into mime (type, name, checkflag ) values ("V", "mp4v-es", 0);
insert into mime (type, name, checkflag ) values ("V", "mpeg", 0);
insert into mime (type, name, checkflag ) values ("V", "parityfec", 0);
insert into mime (type, name, checkflag ) values ("V", "pointer", 0);
insert into mime (type, name, checkflag ) values ("V", "quicktime", 0);
insert into mime (type, name, checkflag ) values ("V", "vnd.fvt", 0);
insert into mime (type, name, checkflag ) values ("V", "vnd.motorola.video", 0);
insert into mime (type, name, checkflag ) values ("V", "vnd.motorola.videop", 0);
insert into mime (type, name, checkflag ) values ("V", "vnd.mpegurl", 0);
insert into mime (type, name, checkflag ) values ("V", "vnd.mts", 0);
insert into mime (type, name, checkflag ) values ("V", "vnd.nokia.interleaved-multimedia", 0);
insert into mime (type, name, checkflag ) values ("V", "vnd.vivo", 0);
insert into mime (type, name, checkflag ) values ("V", "x-msvideo", 0);
insert into mime (type, name, checkflag ) values ("V", "x-sgi-movie", 0);

create table context
(
    id  INT,
	name   char(20),
	context text,
	allow   BOOL,
	comment varchar(255)
);

create table url
(
	list	VARCHAR(1024),
	type	CHAR(1),		--U:URL  P:Postfix
	comment	VARCHAR(255)

);

--for test.
--insert into url (list, type) values (".sina.com","U");
--insert into url (list, type) values ("exe","P");
COMMIT;
