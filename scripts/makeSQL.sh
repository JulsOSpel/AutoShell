#!/bin/bash
# Julian did everything but the hashcat part
# Luka did the hashcat part
# Make folder.
mkdir -p data
# Make database and tables.
sqlite3 data/database.db <<EOF
CREATE TABLE nmap (
	ip TEXT,
	port TEXT,
	servicename TEXT,
	state TEXT,
	scantype TEXT
);
CREATE TABLE nmapVersion (
	ip TEXT,
	port TEXT,
	servicename TEXT,
	state TEXT,
	servicetype TEXT
);
CREATE TABLE hydra (
	ip TEXT,
	servicename TEXT,
	password TEXT,
	username TEXT
);
CREATE TABLE hashcat (
	password TEXT,
	hashtype TEXT,
	hash TEXT
);
EOF
