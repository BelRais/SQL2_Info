create table Peers (
    nickname varchar primary key,
    birthday date
);

create table Tasks (
  Title varchar primary key,
  ParentTask varchar,
  MaxXP numeric
);

create table P2P (
    id numeric primary key,
    "check" numeric,
    checkingPeer varchar,
    state varchar,
    time time
);
create table Verter (
    id numeric primary key,
    "check" numeric,
    state varchar,
    time time
);
create table Checks (
    id numeric primary key,
    Peer varchar,
    Task varchar,
    "date" date
);
create table TransferredPoints (
    id numeric primary key,
    CheckingPeer varchar,
    CheckedPeer varchar,
    pointsAmount numeric
);
create table Friends (
    id numeric primary key,
    Peer1 varchar,
    Peer2 varchar
);
create table Recommendations (
    id numeric primary key,
    Peer varchar,
    RecommendedPeer varchar
);
create table XP (
    id numeric primary key,
    "check" numeric,
    XPAmount numeric
);
create table TimeTracking (
    id numeric primary key,
    Peer varchar,
    date date,
    time time,
    state int
);