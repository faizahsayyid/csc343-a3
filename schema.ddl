-- Could not: The constraint that every venue has at least 10 seats could not
-- be enforced without assertions or triggers

-- Did not: We enforced all domain specifications that could have been enforced
-- without assertions or triggers.

-- Extra Constraints: only one person can sit at one seat in a particular section
-- of a venue for a particular concert
-- (i.e. two people cant sit in the same spot)

-- Assumptions:
-- Every seat in a venue is available for every concert
-- every venue will have at least one seat
-- seats in a venue are always organized into specifications
-- Every seat belongs to exactly one section

DROP SCHEMA IF EXISTS concert CASCADE;
CREATE SCHEMA concert;
SET search_path TO concert;

CREATE TABLE Owner (
  owner_id integer PRIMARY KEY,
  name varchar(255) NOT NULL,
  phone_number varchar(255) NOT NULL
);

CREATE TABLE Venue (
  venue_id integer PRIMARY KEY,
  owner_id integer NOT NULL REFERENCES Owner,
  name varchar(255) NOT NULL,
  city varchar(255) NOT NULL,
  address varchar(255) NOT NULL
);

CREATE TABLE Section (
  section_id integer PRIMARY KEY,
  venue_id integer NOT NULL REFERENCES Venue,
  name varchar(255) NOT NULL
);

CREATE TABLE Seat (
  seat_id integer PRIMARY KEY,
  identifier varchar(255) NOT NULL,
  section_id integer NOT NULL REFERENCES Section,
  is_accessible boolean NOT NULL DEFAULT false,
  CONSTRAINT unique_seat_identifier_per_section UNIQUE(section_id, identifier)
);

CREATE TABLE Concert (
  concert_id integer PRIMARY KEY,
  venue_id integer NOT NULL REFERENCES Venue,
  name varchar(255) NOT NULL,
  datetime timestamp NOT NULL,
  CONSTRAINT one_concert_per_venue_and_time UNIQUE (venue_id, datetime)
);

CREATE TABLE SectionPrice (
  section_id integer NOT NULL REFERENCES Section,
  concert_id integer NOT NULL REFERENCES Concert,
  price real NOT NULL,
  PRIMARY KEY (section_id, concert_id)
);

CREATE TABLE Customer (
  username varchar(255) PRIMARY KEY
);

CREATE TABLE Purchase (
  purchase_id integer PRIMARY KEY,
  concert_id integer NOT NULL REFERENCES Concert,
  seat_id  integer  NOT NULL REFERENCES Seat,
  username varchar(255) NOT NULL REFERENCES Customer,
  datetime timestamp NOT NULL,
  CONSTRAINT one_seat_per_person UNIQUE(concert_id, seat_id)
);
