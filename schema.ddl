/*  
COULD NOT: The constraint that every venue has at least 10 seats could not
be enforced without assertions or triggers within our design. It would require
accessing multiple tables. We could have made a column that tracks the number
of seats in a venue, but this could create anomolies. 

DID NOT: We enforced all domain specifications that could have been enforced
without assertions or triggers.

EXTRA CONSTRAINTS: Only one person can sit at one seat in a particular section
of a venue for a particular concert
(i.e. two people cant sit in the same spot)

ASSUMPTION:
- Every seat in a venue is purchasable for every concert
- Seats in a venue are always organized into sections
- Every seat belongs to exactly one section
- Every concert will have at least one ticket for sale
- If a seat is not specified as being accesible then we assume its not
- There's no additional information we need to store for the different types of owners
    (i.e for person vs company vs organization) 
- We don't have to check that the dates are valid (e.g. set in the future). 
    This could be handled in the user interface.
- Every user who purchases a ticket must be already registered 
   (i.e, exists in the customers table)
*/

DROP SCHEMA IF EXISTS concert CASCADE;
CREATE SCHEMA concert;
SET search_path TO concert;

-- A person who owns a venue which host concerts
CREATE TABLE Owner (
  owner_id integer PRIMARY KEY,
  name varchar(255) NOT NULL,
  phone_number varchar(255) NOT NULL
);

-- A venue that hosts concerts. <owner_id> owns this venue. 
CREATE TABLE Venue (
  venue_id integer PRIMARY KEY,
  owner_id integer NOT NULL REFERENCES Owner,
  name varchar(255) NOT NULL,
  city varchar(255) NOT NULL,
  address varchar(255) NOT NULL
);

-- A section within the venue <venue_id>.
CREATE TABLE Section (
  section_id integer PRIMARY KEY,
  venue_id integer NOT NULL REFERENCES Venue,
  name varchar(255) NOT NULL
);

-- A seat within the section <section_id> in a venue. 
-- The identifier is unique to each section
CREATE TABLE Seat (
  seat_id integer PRIMARY KEY,
  identifier varchar(255) NOT NULL,
  section_id integer NOT NULL REFERENCES Section,
  is_accessible boolean NOT NULL DEFAULT false,
  CONSTRAINT unique_seat_identifier_per_section UNIQUE(section_id, identifier)
);

-- A concert that is hosted in the venue <venue_id> on <datetime>. 
-- Only one concert can be hosted within a venue at a time. 
CREATE TABLE Concert (
  concert_id integer PRIMARY KEY,
  venue_id integer NOT NULL REFERENCES Venue,
  name varchar(255) NOT NULL,
  datetime timestamp NOT NULL,
  CONSTRAINT one_concert_per_venue_and_time UNIQUE (venue_id, datetime)
);

-- The price of tickets within the section <section_id> for concert 
--  <concert_id>. 
CREATE TABLE SectionPrice (
  section_id integer NOT NULL REFERENCES Section,
  concert_id integer NOT NULL REFERENCES Concert,
  price real NOT NULL,
  PRIMARY KEY (section_id, concert_id)
);

-- A customer (user) who can purchase a ticket. 
CREATE TABLE Customer (
  username varchar(255) PRIMARY KEY
);

-- The customer <username> purchased a ticket to <concert_id> for
--  <seat_id> on <datetime>
CREATE TABLE Purchase (
  purchase_id integer PRIMARY KEY,
  concert_id integer NOT NULL REFERENCES Concert,
  seat_id  integer  NOT NULL REFERENCES Seat,
  username varchar(255) NOT NULL REFERENCES Customer,
  datetime timestamp NOT NULL,
  CONSTRAINT one_seat_per_person UNIQUE(concert_id, seat_id)
);
