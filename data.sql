SET SEARCH_PATH TO concert;

INSERT INTO Owner(owner_id, name, phone_number) VALUES
	(1, 'The Corporation of Massey Hall and Roy Thomson Hall', '416-465-7189'),
	(2, 'Maple Leaf Sports & Entertainment', '416-486-0943');

INSERT INTO Venue(venue_id, owner_id, name, city, address) VALUES
	(1, 1, 'Massey Hall', 'Toronto', '178 Victoria Street'),
    (2, 1, 'Roy Thomson Hall', 'Toronto', '60 Simcoe St'),
    (3, 2, 'ScotiaBank Arena', 'Toronto', '40 Bay St');

INSERT INTO Section(section_id, venue_id, name) VALUES 
    (1, 1, 'floor'),
    (2, 1, 'balcony'),
    (3, 2, 'main hall'),
    (4, 3, '100'),
    (5, 3, '200'),
    (6, 3, '300');


INSERT INTO Seat(seat_id, section_id, identifier, is_accessible) VALUES 
    (1, 1, 'A1', true),
    (2, 1, 'A2', true),
    (3, 1, 'A3', true),
    (4, 1, 'A4'),
    (5, 1, 'A5'),
    (6, 1, 'A6'),
    (7, 1, 'A7'),
    (8, 1, 'A8', true),
    (9, 1, 'A9', true),
    (10, 1, 'A10', true),
    (11, 1, 'B1'),
    (12, 1, 'B2'),
    (13, 1, 'B3'),
    (14, 1, 'B4'),
    (15, 1, 'B5'),
    (16, 1, 'B6'),
    (17, 1, 'B7'),
    (18, 1, 'B8'),
    (19, 1, 'B9'),
    (20, 1, 'B10'),
    (21, 2, 'C1'),
    (22, 2, 'C2'),
    (23, 2, 'C3'),
    (24, 2, 'C4'),
    (25, 2, 'C5'),
    (26, 3, 'AA1'),
    (27, 3, 'AA2'),
    (28, 3, 'AA3'),
    (29, 3, 'BB1'),
    (31, 3, 'BB3'),
    (30, 3, 'BB2'),
    (32, 3, 'BB4'),
    (33, 3, 'BB5'),
    (34, 3, 'BB6'),
    (35, 3, 'BB7'),
    (36, 3, 'BB8'),
    (37, 3, 'CC1'),
    (38, 3, 'CC2'),
    (39, 3, 'CC3'),
    (40, 3, 'CC4'),
    (41, 3, 'CC5'),
    (42, 3, 'CC6'),
    (43, 3, 'CC7'),
    (44, 3, 'CC8'),
    (45, 3, 'CC9'),
    (46, 3, 'CC10'),
    (47, 4, 'row 1, seat 1', true),
    (48, 4, 'row 1, seat 2', true),
    (49, 4, 'row 1, seat 3', true),
    (50, 4, 'row 1, seat 4', true),
    (51, 4, 'row 1, seat 5', true),
    (52, 4, 'row 2, seat 1', true),
    (53, 4, 'row 2, seat 2', true),
    (54, 4, 'row 2, seat 3', true) ,
    (55, 4, 'row 2, seat 4', true),
    (56, 4, 'row 2, seat 5', true),
    (57, 5, 'row 1, seat 1'),
    (58, 5, 'row 1, seat 2'),
    (59, 5, 'row 1, seat 3'),
    (60, 5, 'row 1, seat 4'),
    (61, 5, 'row 1, seat 5'),
    (62, 5, 'row 2, seat 1'),
    (63, 5, 'row 2, seat 2'),
    (64, 5, 'row 2, seat 3'),
    (65, 5, 'row 2, seat 4'),
    (66, 5, 'row 2, seat 5'),
    (67, 6, 'row 1, seat 1'),
    (68, 6, 'row 1, seat 2'),
    (69, 6, 'row 1, seat 3'),
    (70, 6, 'row 1, seat 4'),
    (71, 6, 'row 1, seat 5'),
    (72, 6, 'row 2, seat 1'),
    (73, 6, 'row 2, seat 2'),
    (74, 6, 'row 2, seat 3'),
    (75, 6, 'row 2, seat 4'),
    (76, 6, 'row 2, seat 5');

INSERT INTO Concert(concert_id, venue_id, name, datetime) VALUES
	(1, 1, 'Ron Sexsmith', '2022-12-03 07:30:00'),
    (2, 1, "Women's Blues Review", '2022-11-25 08:00:00'),
    (3, 3, 'Mariah Carey - Merry Christmas', '2022-12-09 08:00:00'),
    (4, 3, 'Mariah Carey - Merry Christmas', '2022-12-11 08:00:00'),
    (5, 2, 'TSO - Elf in Concert', '2022-12-09 07:30:00'),
    (6, 2, 'TSO - Elf in Concert', '2022-12-10 02:30:00'),
    (7, 2, 'TSO - Elf in Concert', '2022-12-10 07:30:00'),

INSERT INTO SectionPrice(concert_id, section_id, price) VALUES
    (1, 1, 130),
    (1, 2, 99),
    (2, 1, 150),
    (2, 2, 125),
    (3, 4, 986),
    (3, 5, 244),
    (3, 6, 176),
    (4, 4, 936),
    (4, 5, 194),
    (4, 6, 126),
    (5, 3, 159),
    (6, 3, 159),
    (7, 3, 159);

INSERT INTO User(username) VALUES
    ('ahightower'),
    ('d_targaryen'),
    ('cristonc');

INSERT INTO Purchase(purchase_id, username, concert_id, seat_id, datetime) VALUES
    (1, 'ahightower', 2, 5, '2022-11-23 00:00:00'),
    (2, 'd_targaryen', 1, 13, '2022-12-01 00:00:00'),
    (3, 'd_targaryen', 7, 35, '2022-12-08 00:00:00'),
    (4, 'cristonc', 3, 49, '2022-12-07 00:00:00'),
    (5, 'cristonc', 2, 64, '2022-12-07 00:00:00');

