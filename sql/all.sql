SET DEFINE OFF;

CREATE TABLE Certificate_Wage (
	certificate CHAR(100) PRIMARY KEY,
	minimumWage INT
);

CREATE TABLE PostalCode_Location (
	postalCode CHAR(100) PRIMARY KEY,
	state CHAR(100),
	city CHAR(100),
	address CHAR(100)
);

CREATE TABLE Stadium_Location(
	stadiumName CHAR(100) PRIMARY KEY,
	postalCode CHAR(100),
	address CHAR(100),
	FOREIGN KEY (postalCode) REFERENCES PostalCode_Location(postalCode) 
);

CREATE TABLE Team_Sponsors_Stadium (
	teamID INT PRIMARY KEY,
	stadiumName CHAR(100) NOT NULL,
	foundedYear INT,
	teamName CHAR(100),
	sponserName CHAR(100) NOT NULL,
	fundingPerYear INT,
	FOREIGN KEY (stadiumName) REFERENCES Stadium_Location(stadiumName)
);

CREATE TABLE Player (
	playerID INT PRIMARY KEY,
	teamID INT NOT NULL,
	playerName CHAR(100),
	birthdate DATE, 
	jerseyNum INT NOT NULL,
	salary INT,
	appearance INT,
	threePointer INT,
	midRange INT,
	paint INT,
	UNIQUE (teamID, jerseyNum),
	FOREIGN KEY (teamID) REFERENCES Team_Sponsors_Stadium (teamID) ON DELETE CASCADE
);

CREATE TABLE AwardsAndHonors (
	playerID INT,
	awardName CHAR(100),
	season CHAR(100),
	PRIMARY KEY (playerID, awardName, season),
	FOREIGN KEY (playerID) REFERENCES Player(playerID) ON DELETE CASCADE
);

CREATE TABLE Fan (
	fanID INT PRIMARY KEY,
	teamID INT NOT NULL,
	fanName CHAR(100),
	email CHAR(100) UNIQUE,
	FOREIGN KEY (teamID) REFERENCES Team_Sponsors_Stadium (teamID) ON DELETE CASCADE
);

CREATE TABLE Boss (
	bossID INT PRIMARY KEY,
	teamID INT NOT NULL,
	bossName CHAR(100),
	wealth INT,
	FOREIGN KEY (teamID) REFERENCES Team_Sponsors_Stadium (teamID) ON DELETE CASCADE
);

CREATE TABLE Staff (
	staffID INT PRIMARY KEY,
	teamID INT NOT NULL,
	staffName CHAR(100),
	FOREIGN KEY (teamID) REFERENCES Team_Sponsors_Stadium(teamID) ON DELETE CASCADE
);

CREATE TABLE Coach (
	staffID INT PRIMARY KEY,
	coachingYear INT,
	FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE
);

CREATE TABLE Analyst (
	staffID INT PRIMARY KEY,
	certificate CHAR(100),
	FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE,
	FOREIGN KEY (certificate) REFERENCES Certificate_Wage(certificate)
);

CREATE TABLE TeamDoctor (
	staffID INT PRIMARY KEY,
	specialist CHAR(100),
	FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE
);

CREATE TABLE Match_Home_Guest (
	matchID INT PRIMARY KEY,
	homeTeamID INT NOT NULL,
	guestTeamID INT NOT NULL,
	winner CHAR(100),
	time TIMESTAMP,
	homeScore INT,
	guestScore INT,
	FOREIGN KEY (homeTeamID) REFERENCES Team_Sponsors_Stadium (teamID),
	FOREIGN KEY (guestTeamID) REFERENCES Team_Sponsors_Stadium (teamID),
	UNIQUE (time, homeTeamID, guestTeamID),
	UNIQUE (time, winner)
);

INSERT INTO Certificate_Wage VALUES('Entry', 100000);
INSERT INTO Certificate_Wage VALUES('Intermediate', 200000);
INSERT INTO Certificate_Wage VALUES('Advanced', 400000);
INSERT INTO Certificate_Wage VALUES('Proficient', 800000);
INSERT INTO Certificate_Wage VALUES('Expert', 1600000);

INSERT INTO PostalCode_Location VALUES('02114', 'Massachusetts', 'Boston', '100 Legends Way');
INSERT INTO PostalCode_Location VALUES('11207', 'New York', 'Brooklyn', '620 Atlantic Avenue');
INSERT INTO PostalCode_Location VALUES('10001', 'New York', 'Manhattan', '4 Pennsylvania Plaza');
INSERT INTO PostalCode_Location VALUES('19148', 'Pennsylvania', 'Philadelphia', '3601 South Broad Street');
INSERT INTO PostalCode_Location VALUES('M5J 2X2', 'Ontario', 'Toronto', '40 Bay Street');
INSERT INTO PostalCode_Location VALUES('60612', 'Illinois', 'Chicago', '1901 West Madison Street');
INSERT INTO PostalCode_Location VALUES('44115', 'Ohio', 'Cleveland', '1 Center Court');
INSERT INTO PostalCode_Location VALUES('48201', 'Michigan', 'Detroit', '2645 Woodland Avenue');
INSERT INTO PostalCode_Location VALUES('46204', 'Indiana', 'Indianapolis', '125 South Pennsylvania Street');
INSERT INTO PostalCode_Location VALUES('53203', 'Wisconsin', 'Milwaukee', '1111 Vel R. Phillips Avenue');
INSERT INTO PostalCode_Location VALUES('30303', 'Georgia', 'Atlanta', '1 State Farm Drive');
INSERT INTO PostalCode_Location VALUES('28202', 'North Carolina', 'Charlotte', '333 East Trade Street');
INSERT INTO PostalCode_Location VALUES('33132', 'Florida', 'Miami', '601 Biscayne Boulevard');
INSERT INTO PostalCode_Location VALUES('32805', 'Florida', 'Orlando', '400 West Church Street');
INSERT INTO PostalCode_Location VALUES('20004', 'District of Columbia', 'Washington', '601 F. Street Northwest');
INSERT INTO PostalCode_Location VALUES('80204', 'Colorado', 'Denver', '1000 Chopper Circle');
INSERT INTO PostalCode_Location VALUES('55403', 'Minnesota', 'Minneapolis', '600 First Avenue North');
INSERT INTO PostalCode_Location VALUES('73102', 'Oklahoma', 'Oklahoma City', '100 West Reno Avenue');
INSERT INTO PostalCode_Location VALUES('97227', 'Oregon', 'Portland', '1 Center Court');
INSERT INTO PostalCode_Location VALUES('84101', 'Utah', 'Salt Lake City', '301 South Temple');
INSERT INTO PostalCode_Location VALUES('94158', 'California', 'San Francisco', '1 Warriors Way');
INSERT INTO PostalCode_Location VALUES('90015', 'California', 'Los Angeles', '1111 South Figueroa Street');
INSERT INTO PostalCode_Location VALUES('85004', 'Arizona', 'Phoenix', '201 East Jefferson Street');
INSERT INTO PostalCode_Location VALUES('95814', 'California', 'Sacramento', '500 David J. Stern Walk');
INSERT INTO PostalCode_Location VALUES('75219', 'Texas', 'Dallas', '2500 Victory Avenue');
INSERT INTO PostalCode_Location VALUES('77002', 'Texas', 'Houston', '1510 Polk Street');
INSERT INTO PostalCode_Location VALUES('38103', 'Tennessee', 'Memphis', '191 Beale Street');
INSERT INTO PostalCode_Location VALUES('70113', 'Louisiana', 'New Orleans', '1501 Dave Dixon Drive');
INSERT INTO PostalCode_Location VALUES('78219', 'Texas', 'San Antonio', '1 AT&T Center Parkway');

INSERT INTO Stadium_Location VALUES('TD Garden', '02114', '100 Legends Way');
INSERT INTO Stadium_Location VALUES('Barclays Center', '11207', '620 Atlantic Avenue');
INSERT INTO Stadium_Location VALUES('Madison Square Garden', '10001', '4 Pennsylvania Plaza');
INSERT INTO Stadium_Location VALUES('Wells Fargo Center', '19148', '3601 South Broad Street');
INSERT INTO Stadium_Location VALUES('Scotiabank Arena', 'M5J 2X2', '40 Bay Street');
INSERT INTO Stadium_Location VALUES('United Center', '60612', '1901 West Madison Street');
INSERT INTO Stadium_Location VALUES('Rocket Mortgage FieldHouse', '44115', '1 Center Court');
INSERT INTO Stadium_Location VALUES('Little Caesars Arena', '48201', '2645 Woodland Avenue');
INSERT INTO Stadium_Location VALUES('Gainbridge Fieldhouse', '46204', '125 South Pennsylvania Street');
INSERT INTO Stadium_Location VALUES('Fiserv Forum', '53203', '1111 Vel R. Phillips Avenue');
INSERT INTO Stadium_Location VALUES('State Farm Arena', '30303', '1 State Farm Drive');
INSERT INTO Stadium_Location VALUES('Spectrum Center', '28202', '333 East Trade Street');
INSERT INTO Stadium_Location VALUES('FTX Arena', '33132', '601 Biscayne Boulevard');
INSERT INTO Stadium_Location VALUES('Amway Center', '32805', '400 West Church Street');
INSERT INTO Stadium_Location VALUES('Capital One Arena', '20004', '601 F. Street Northwest');
INSERT INTO Stadium_Location VALUES('Ball Arena', '80204', '1000 Chopper Circle');
INSERT INTO Stadium_Location VALUES('Target Center', '55403', '600 First Avenue North');
INSERT INTO Stadium_Location VALUES('Paycom Center', '73102', '100 West Reno Avenue');
INSERT INTO Stadium_Location VALUES('Moda Center', '97227', '1 Center Court');
INSERT INTO Stadium_Location VALUES('Vivint Arena', '84101', '301 South Temple');
INSERT INTO Stadium_Location VALUES('Chase Center', '94158', '1 Warriors Way');
INSERT INTO Stadium_Location VALUES('Crypto.com Arena', '90015', '1111 South Figueroa Street');
INSERT INTO Stadium_Location VALUES('Footprint Center', '85004', '201 East Jefferson Street');
INSERT INTO Stadium_Location VALUES('Golden 1 Center', '95814', '500 David J. Stern Walk');
INSERT INTO Stadium_Location VALUES('American Airlines Center', '75219', '2500 Victory Avenue');
INSERT INTO Stadium_Location VALUES('Toyota Center', '77002', '1510 Polk Street');
INSERT INTO Stadium_Location VALUES('FedEx Forum', '38103', '191 Beale Street');
INSERT INTO Stadium_Location VALUES('Smoothie King Center', '70113', '1501 Dave Dixon Drive');
INSERT INTO Stadium_Location VALUES('AT&T Center', '78219', '1 AT&T Center Parkway');

INSERT INTO Team_Sponsors_Stadium VALUES(1, 'TD Garden', 1946, 'Boston Celtics', 'Vistaprint', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(2, 'Barclays Center', 1967, 'Brooklyn Nets', 'Webull', 900);
INSERT INTO Team_Sponsors_Stadium VALUES(3, 'Madison Square Garden', 1946, 'New York Knicks', 'Squarespace', 800);
INSERT INTO Team_Sponsors_Stadium VALUES(4, 'Wells Fargo Center', 1946, 'Philadelphia 76ers', 'Crypto.com', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(5, 'Scotiabank Arena', 1995, 'Toronto Raptors', 'Sun Life Financial', 1100);
INSERT INTO Team_Sponsors_Stadium VALUES(6, 'United Center', 1966, 'Chicago Bulls', 'Zenni Optical', 1200);
INSERT INTO Team_Sponsors_Stadium VALUES(7, 'Rocket Mortgage FieldHouse', 1970, 'Cleveland Cavaliers', 'Goodyear Tire and Rubber Company', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(8, 'Little Caesars Arena', 1941, 'Detroit Pistons', 'United Wholesale Mortgage', 1300);
INSERT INTO Team_Sponsors_Stadium VALUES(9, 'Gainbridge Fieldhouse', 1967, 'Indiana Pacers', 'Motorola', 800);
INSERT INTO Team_Sponsors_Stadium VALUES(10, 'Fiserv Forum', 1968, 'Milwaukee Bucks', 'Motorola', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(11, 'State Farm Arena', 1946, 'Atlanta Hawks', 'Sharecare', 900);
INSERT INTO Team_Sponsors_Stadium VALUES(12, 'Spectrum Center', 1988, 'Charlotte Hornets', 'LendingTree', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(13, 'FTX Arena', 1988, 'Miami Heat', 'Ultimate Kronos Group', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(14, 'Amway Center', 1989, 'Orlando Magic', 'Walt Disney World', 900);
INSERT INTO Team_Sponsors_Stadium VALUES(15, 'Capital One Arena', 1961, 'Washington Wizards', 'Calvin Klein', 900);
INSERT INTO Team_Sponsors_Stadium VALUES(16, 'Ball Arena', 1967, 'Denver Nuggets', 'Western Union', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(17, 'Target Center', 1989, 'Minnesota Timberwolves', 'Aura', 900);
INSERT INTO Team_Sponsors_Stadium VALUES(18, 'Paycom Center', 1967, 'Oklahoma City Thunder', 'Love''s Travel Stops & Country Stores', 1200);
INSERT INTO Team_Sponsors_Stadium VALUES(19, 'Moda Center', 1970, 'Portland Trail Blazers', 'StormX', 1100);
INSERT INTO Team_Sponsors_Stadium VALUES(20, 'Vivint Arena', 1974, 'Utah Jazz', 'Qualtrics', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(21, 'Chase Center', 1946, 'Golden State Warriors', 'Rakuten', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(22, 'Crypto.com Arena', 1970, 'Los Angeles Clippers', 'Honey', 1300);
INSERT INTO Team_Sponsors_Stadium VALUES(23, 'Crypto.com Arena', 1947, 'Los Angeles Lakers', 'Bibigo', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(24, 'Footprint Center', 1968, 'Phoenix Suns', 'PayPal', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(25, 'Golden 1 Center', 1923, 'Sacramento Kings', 'Dialpad', 800);
INSERT INTO Team_Sponsors_Stadium VALUES(26, 'American Airlines Center', 1980, 'Dallas Mavericks', 'Chime', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(27, 'Toyota Center', 1967, 'Houston Rockets', 'Credit Karma', 700);
INSERT INTO Team_Sponsors_Stadium VALUES(28, 'FedEx Forum', 1995, 'Memphis Grizzlies', 'Bose', 700);
INSERT INTO Team_Sponsors_Stadium VALUES(29, 'Smoothie King Center', 2002, 'New Orleans Pelicans', 'Ibotta', 1000);
INSERT INTO Team_Sponsors_Stadium VALUES(30, 'AT&T Center', 1967, 'San Antonio Spurs', 'Frost Bank', 1000);

INSERT INTO Player VALUES(1, 1, 'Brown, Jaylen', DATE '1996-10-24', 7, 300, 354, 312, 584, 416);
INSERT INTO Player VALUES(2, 2, 'Curry, Seth', DATE '1990-08-23', 30, 400, 324, 310, 684, 326);
INSERT INTO Player VALUES(3, 3, 'Arcidiacono, Ryan', DATE '1994-03-26', 51, 250, 302, 410, 664, 356);
INSERT INTO Player VALUES(4, 4, 'Bassey, Charles', DATE '2000-10-28', 23, 300, 224, 240, 689, 346);
INSERT INTO Player VALUES(5, 5, 'Achiuwa, Precious', DATE '1999-09-19', 5, 200, 214, 350, 604, 325);
INSERT INTO Player VALUES(6, 6, 'Ball, Lonzo', DATE '1997-10-27', 2, 300, 424, 410, 984, 826);
INSERT INTO Player VALUES(7, 7, 'Allen, Jarrett', DATE '1998-04-21', 31, 300, 344, 262, 562, 572);
INSERT INTO Player VALUES(8, 8, 'Bey, Saddiq', DATE '1999-04-09', 41, 300, 265, 245, 352, 623);
INSERT INTO Player VALUES(9, 9, 'Bitadze, Goga', DATE '1999-07-20', 88, 200, 345, 245, 532, 435);
INSERT INTO Player VALUES(10, 10, 'Allen, Grayson', DATE '1995-10-08', 7, 250, 865, 856, 747, 1423);
INSERT INTO Player VALUES(11, 11, 'Bogdanovic, Bogdan', DATE '1992-08-18', 13, 300, 332, 234, 345, 456);
INSERT INTO Player VALUES(12, 12, 'Ball, LaMelo', DATE '2001-08-22', 2, 200, 143, 241, 124, 142);
INSERT INTO Player VALUES(13, 13, 'Adebayo, Bam', DATE '1997-07-18', 13, 300, 345, 345, 635, 365);
INSERT INTO Player VALUES(14, 14, 'Anthony, Cole', DATE '2000-05-15', 50, 200, 135, 234, 134, 242);
INSERT INTO Player VALUES(15, 15, 'Avdija, Deni', DATE '2001-01-03', 9, 250, 124, 213, 231, 323);
INSERT INTO Player VALUES(16, 16, 'Barton, Will', DATE '1991-01-06', 5, 400, 532, 635, 763, 735);
INSERT INTO Player VALUES(17, 17, 'Beasley, Malik', DATE '1996-11-26', 5, 500, 578, 735, 746, 855);
INSERT INTO Player VALUES(18, 18, 'Bazley, Darius', DATE '2000-06-12', 7, 300, 351, 521, 345, 452);
INSERT INTO Player VALUES(19, 19, 'Bledsoe, Eric', DATE '1989-12-09', 5, 400, 525, 645, 473, 746);
INSERT INTO Player VALUES(20, 20, 'Alexander-Walker, Nickeil', DATE '1998-09-02', 6, 500, 633, 745, 684, 875);
INSERT INTO Player VALUES(21, 21, 'Bjelica, Nemanja', DATE '1988-05-09', 8, 600, 653, 780, 805, 709);
INSERT INTO Player VALUES(22, 22, 'Batum, Nicolas', DATE '1988-12-14', 33, 550, 468, 478, 568, 528);
INSERT INTO Player VALUES(23, 23, 'Davis, Anthony', DATE '1993-03-11', 3,350, 452, 670, 684, 852);
INSERT INTO Player VALUES(24, 24, 'Ayton, Deandre', DATE '1998-07-23', 22, 200, 342, 562, 489, 379);
INSERT INTO Player VALUES(25, 25, 'Barnes, Harrison', DATE '1992-05-30', 40, 350, 479, 587, 546, 462);
INSERT INTO Player VALUES(26, 26, 'Bertans, Davis', DATE '1992-11-12', 44, 350, 583, 782, 780, 682);
INSERT INTO Player VALUES(27, 27, 'Christopher, Josh', DATE '2001-12-08', 9, 200, 397, 429, 420, 520);
INSERT INTO Player VALUES(28, 28, 'Adams, Steven', DATE '1993-07-20', 4, 450, 502, 689, 518, 593);
INSERT INTO Player VALUES(29, 29, 'Alvarado, Jose', DATE '1998-04-12', 15, 500, 425, 637, 579, 597);
INSERT INTO Player VALUES(30, 30, 'Bates-Diop, Keita', DATE '1996-01-23', 31, 300, 426, 489, 509, 542);
INSERT INTO Player VALUES(31, 1, 'Fitts, Malik', DATE '1997-07-04', 8, 200, 300, 582, 341, 481);
INSERT INTO Player VALUES(32, 2, 'Durant, Kevin', DATE '1988-09-29', 7, 1000, 581, 810, 941, 894);
INSERT INTO Player VALUES(33, 3, 'Barrett, RJ', DATE '2000-06-14', 9, 200, 209, 240, 310, 201);
INSERT INTO Player VALUES(34, 4, 'Embiid, Joel', DATE '1994-03-16', 21, 300, 491, 502, 492, 578);
INSERT INTO Player VALUES(35, 5, 'Anunoby, OG', DATE '1997-07-17', 3, 250, 149, 247, 259, 261);
INSERT INTO Player VALUES(36, 6, 'Bradley, Tony', DATE '1998-08-01', 13, 200, 310, 368, 489, 471);
INSERT INTO Player VALUES(37, 7, 'Garland, Darius', DATE '2000-01-26', 10, 200, 204, 287, 276, 280);
INSERT INTO Player VALUES(38, 8, 'Cunningham, Cade', DATE '2001-09-25', 2, 200, 183, 278, 265, 247);
INSERT INTO Player VALUES(39, 9, 'Brissett, Oshae', DATE '1998-06-20', 12, 250, 268, 280, 289, 324);
INSERT INTO Player VALUES(40, 10, 'Antetokounmpo, Giannis', DATE '1994-12-06', 34, 300, 471, 509, 591, 602);
INSERT INTO Player VALUES(41, 11, 'Capela, Clint', DATE '1994-05-18', 15, 350, 462, 489, 598, 562);
INSERT INTO Player VALUES(42, 12, 'Bouknight, James', DATE '2000-09-18', 5, 200, 376, 397, 404, 407);
INSERT INTO Player VALUES(43, 13, 'Dedmon, Dewayne', DATE '1989-08-12', 21, 350, 587, 698, 764, 762);
INSERT INTO Player VALUES(44, 14, 'Bamba, Mo', DATE '1998-05-12', 5, 250, 185, 284, 283, 254);
INSERT INTO Player VALUES(45, 15, 'Beal, Bradley', DATE '1993-06-28', 3, 300, 378, 474, 498, 467);
INSERT INTO Player VALUES(46, 16, 'Jokic, Nikola', DATE '1995-02-19', 15, 1200, 648, 893, 902, 941);
INSERT INTO Player VALUES(47, 17, 'Beverley, Patrick', DATE '1988-07-12', 22, 350, 395, 497, 502, 505);
INSERT INTO Player VALUES(48, 18, 'Dort, Luguentz', DATE '1999-04-19', 5, 250, 287, 299, 304, 314);
INSERT INTO Player VALUES(49, 19, 'Brown, Greg', DATE '2001-09-01', 4, 200, 135, 178, 191, 167);
INSERT INTO Player VALUES(50, 20, 'Azubuike, Udoka', DATE '1999-09-17', 20, 200, 120, 145, 178, 176);
INSERT INTO Player VALUES(51, 21, 'Curry, Stephen', DATE '1988-03-14', 30, 1200, 586, 798, 829, 941);
INSERT INTO Player VALUES(52, 22, 'Coffey, Amir', DATE '1997-06-17', 7, 250, 198, 289, 312, 300);
INSERT INTO Player VALUES(53, 23, 'Gabriel, Wenyen', DATE '1997-03-26', 35, 250, 295, 386, 378, 391);
INSERT INTO Player VALUES(54, 24, 'Biyombo, Bismack', DATE '1992-08-28', 18, 350, 359, 462, 398, 472);
INSERT INTO Player VALUES(55, 25, 'Davis, Terence', DATE '1997-05-16', 3, 250, 273, 298, 303, 324);
INSERT INTO Player VALUES(56, 26, 'Brunson, Jalen', DATE '1996-08-31', 13, 300, 358, 423, 453, 476);
INSERT INTO Player VALUES(57, 27, 'Garuba, Usman', DATE '2002-03-09', 16, 200, 125, 157, 187, 168);
INSERT INTO Player VALUES(58, 28, 'Anderson, Kyle', DATE '1993-09-20', 1, 350, 428, 498, 537, 552);
INSERT INTO Player VALUES(59, 29, 'Graham, Devonte''', DATE '1995-02-22', 4, 300, 419, 498, 503, 531);
INSERT INTO Player VALUES(60, 30, 'Johnson, Keldon', DATE '1999-10-11', 3, 300, 273, 304, 324, 342);
INSERT INTO Player VALUES(61, 1, 'Hauser, Sam', DATE '1997-12-08', 30, 250, 278, 341, 351, 343);
INSERT INTO Player VALUES(62, 2, 'Harris, Joe', DATE '1991-09-07', 12, 700, 572, 724, 703, 698);
INSERT INTO Player VALUES(63, 3, 'Burks, Alec', DATE '1991-07-20', 18, 450, 523, 682, 691, 672);
INSERT INTO Player VALUES(64, 4, 'Green, Danny', DATE '1987-06-22', 14, 900, 693, 987, 894, 962);
INSERT INTO Player VALUES(65, 5, 'Banton, Dalano', DATE '1999-11-07', 45, 250, 231, 341, 302, 298);
INSERT INTO Player VALUES(66, 6, 'Caruso, Alex', DATE '1994-02-28', 6, 800, 472, 598, 682, 703);
INSERT INTO Player VALUES(67, 7, 'LeVert, Caris', DATE '1994-08-25', 3, 350, 381, 498, 487, 501);
INSERT INTO Player VALUES(68, 8, 'Diallo, Hamidou', DATE '1998-07-31', 6, 250, 289, 357, 387, 400);
INSERT INTO Player VALUES(69, 9, 'Brogdon, Malcolm', DATE '1992-12-11', 7, 500, 472, 598, 604, 614);
INSERT INTO Player VALUES(70, 10, 'Antetokounmpo, Thanasis', DATE '1992-07-18', 43, 600, 572, 698, 732, 743);
INSERT INTO Player VALUES(71, 11, 'Collins, John', DATE '1997-09-23', 20, 300, 381, 493, 487, 502);
INSERT INTO Player VALUES(72, 12, 'Hayward, Gordon', DATE '1990-03-23', 20, 550, 413, 498, 572, 563);
INSERT INTO Player VALUES(73, 13, 'Butler, Jimmy', DATE '1989-09-14', 22, 450, 451, 587, 567, 587);
INSERT INTO Player VALUES(74, 14, 'Bol, Bol', DATE '1999-11-16', 10, 200, 250, 213, 289, 342);
INSERT INTO Player VALUES(75, 15, 'Bryant, Thomas', DATE '1997-07-31', 13, 300, 243, 298, 305, 323);
INSERT INTO Player VALUES(76, 16, 'Gordon, Aaron', DATE '1995-09-16', 50, 350, 387, 498, 513, 543);
INSERT INTO Player VALUES(77, 17, 'Bolmaro, Leandro', DATE '2000-09-11', 9, 200, 179, 287, 298, 301);
INSERT INTO Player VALUES(78, 18, 'Favors, Derrick', DATE '1991-07-15', 15, 900, 643, 870, 872, 891);
INSERT INTO Player VALUES(79, 19, 'Dunn, Kris', DATE '1994-03-18', 18, 400, 245, 376, 367, 391);
INSERT INTO Player VALUES(80, 20, 'Bogdanovic, Bojan', DATE '1989-04-18', 44, 500, 671, 872, 893, 845);
INSERT INTO Player VALUES(81, 21, 'Green, Draymond', DATE '1990-03-04', 23, 950, 503, 798, 803, 746);
INSERT INTO Player VALUES(82, 22, 'Boston, Brandon', DATE '2001-11-28', 4, 200, 143, 183, 198, 204);
INSERT INTO Player VALUES(83, 23, 'Horton-Tucker, Talen', DATE '2000-11-25', 5, 250, 174, 304, 298, 333);
INSERT INTO Player VALUES(84, 24, 'Booker, Devin', DATE '1996-10-30', 1, 400, 312, 478, 487, 463);
INSERT INTO Player VALUES(85, 25, 'DiVincenzo, Donte', DATE '1997-01-31', 0, 300, 259, 304, 351, 326);
INSERT INTO Player VALUES(86, 26, 'Brown, Sterling', DATE '1995-02-10', 0, 300, 288, 375, 380, 401);
INSERT INTO Player VALUES(87, 27, 'Gordon, Eric ', DATE '1988-12-25', 10, 750, 694, 798, 873, 903);
INSERT INTO Player VALUES(88, 28, 'Aldama, Santi', DATE '2001-01-10', 7, 200, 113, 156, 176, 147);
INSERT INTO Player VALUES(89, 29, 'Hayes, Jaxson', DATE '2000-05-23', 10, 250, 181, 245, 275, 253);
INSERT INTO Player VALUES(90, 30, 'Collins, Zach', DATE '1997-11-19', 23, 350, 321, 389, 394, 425);

INSERT INTO AwardsAndHonors VALUES(46, 'MVP', '2020-2021');
INSERT INTO AwardsAndHonors VALUES(1, 'Rookie of the Year', '2020-2021');
INSERT INTO AwardsAndHonors VALUES(2, 'Most Improved', '2020-2021');
INSERT INTO AwardsAndHonors VALUES(3, 'Sixth Man', '2020-2021');
INSERT INTO AwardsAndHonors VALUES(4, 'Defensive Player of Year', '2020-2021');
INSERT INTO AwardsAndHonors VALUES(46, 'MVP', '2019-2020');
INSERT INTO AwardsAndHonors VALUES(5, 'Rookie of the Year', '2019-2020');
INSERT INTO AwardsAndHonors VALUES(6, 'Most Improved', '2019-2020');
INSERT INTO AwardsAndHonors VALUES(7, 'Sixth Man', '2019-2020');
INSERT INTO AwardsAndHonors VALUES(8, 'Defensive Player of Year', '2019-2020');
INSERT INTO AwardsAndHonors VALUES(51, 'MVP', '2018-2019');
INSERT INTO AwardsAndHonors VALUES(46, 'Rookie of the Year', '2018-2019');
INSERT INTO AwardsAndHonors VALUES(46, 'Most Improved', '2018-2019');
INSERT INTO AwardsAndHonors VALUES(46, 'Sixth Man', '2018-2019');
INSERT INTO AwardsAndHonors VALUES(46, 'Defensive Player of Year', '2018-2019');

INSERT INTO Fan VALUES(1, 1, 'Jia Lu', 'jialu@gmail.com');
INSERT INTO Fan VALUES(2, 2, 'Yingquan Wang', 'yingquanwang@gmail.com');
INSERT INTO Fan VALUES(3, 3, 'Qiyu Zhou', 'qiyuzhou@gmail.com');
INSERT INTO Fan VALUES(4, 4, 'Lewys Sanders', 'lewyssanders@gmail.com');
INSERT INTO Fan VALUES(5, 5, 'Betty Colon', 'bettycolon@gmail.com');

INSERT INTO Boss VALUES(1, 1, 'Boston Basketball Partners', 74000000);
INSERT INTO Boss VALUES(2, 2, 'Joseph Tsai', 37000000);
INSERT INTO Boss VALUES(3, 3, 'Madison Square Garden Sports', 83000000);
INSERT INTO Boss VALUES(4, 4, 'Harris Blitzer Sports & Entertainment', 216000000);
INSERT INTO Boss VALUES(5, 5, 'Maple Leaf Sports & Entertainment', 37000000);
INSERT INTO Boss VALUES(6, 6, 'Jerry Reinsdorf', 83000000);
INSERT INTO Boss VALUES(7, 7, 'Dan Gilbert', 27000000);
INSERT INTO Boss VALUES(8, 8, 'Tom Gores', 94000000);
INSERT INTO Boss VALUES(9, 9, 'Herb Simon', 83000000);
INSERT INTO Boss VALUES(10, 10, 'Wes Edens', 94000000);
INSERT INTO Boss VALUES(11, 11, 'Tony Ressler', 28000000);
INSERT INTO Boss VALUES(12, 12, 'Michael Jordan', 73000000);
INSERT INTO Boss VALUES(13, 13, 'Micky Arison', 73000000);
INSERT INTO Boss VALUES(14, 14, 'RDV Sports, Inc.', 261000000);
INSERT INTO Boss VALUES(15, 15, 'Monumental Sports & Entertainment', 32000000);
INSERT INTO Boss VALUES(16, 16, 'Kroenke Sports & Entertainment', 84000000);
INSERT INTO Boss VALUES(17, 17, 'Marc Lore', 83000000);
INSERT INTO Boss VALUES(18, 18, 'Professional Basketball Club LLC', 94000000);
INSERT INTO Boss VALUES(19, 19, 'Paul G. Allen Trust', 267000000);
INSERT INTO Boss VALUES(20, 20, 'Jazz Basketball Investors, Inc.', 37000000);
INSERT INTO Boss VALUES(21, 21, 'Joe Lacob', 84000000);
INSERT INTO Boss VALUES(22, 22, 'Steve Ballmer', 83000000);
INSERT INTO Boss VALUES(23, 23, 'Buss Family Trusts', 65000000);
INSERT INTO Boss VALUES(24, 24, 'Robert Sarver', 48000000);
INSERT INTO Boss VALUES(25, 25, 'Vivek Ranadive', 38000000);
INSERT INTO Boss VALUES(26, 26, 'Mark Cuban', 253000000);
INSERT INTO Boss VALUES(27, 27, 'Tilman Fertitta', 172000000);
INSERT INTO Boss VALUES(28, 28, 'Memphis Basketball, LLC', 201000000);
INSERT INTO Boss VALUES(29, 29, 'Gayle Benson', 457000000);
INSERT INTO Boss VALUES(30, 30, 'Spurs Sports & Entertainment', 281000000);

INSERT INTO Staff VALUES(1, 1, 'Joe Mazzulla');
INSERT INTO Staff VALUES(2, 2, 'Jacque Vaughn');
INSERT INTO Staff VALUES(3, 3, 'Tom Thibodeau');
INSERT INTO Staff VALUES(4, 4, 'Doc Rivers');
INSERT INTO Staff VALUES(5, 5, 'Nick Nurse');
INSERT INTO Staff VALUES(6, 6, 'Billy Donovan');
INSERT INTO Staff VALUES(7, 7, 'J. B. Bickerstaff');
INSERT INTO Staff VALUES(8, 8, 'Dwane Casey');
INSERT INTO Staff VALUES(9, 9, 'Rick Carlisle');
INSERT INTO Staff VALUES(10, 10, 'Mike Budenholzer');
INSERT INTO Staff VALUES(11, 11, 'Nate McMillan');
INSERT INTO Staff VALUES(12, 12, 'Steve Clifford');
INSERT INTO Staff VALUES(13, 13, 'Erik Spoelstra');
INSERT INTO Staff VALUES(14, 14, 'Jamahl Mosley');
INSERT INTO Staff VALUES(15, 15, 'Wes Unseld Jr.');
INSERT INTO Staff VALUES(16, 16, 'Michael Malone');
INSERT INTO Staff VALUES(17, 17, 'Chris Finch');
INSERT INTO Staff VALUES(18, 18, 'Mark Daigneault');
INSERT INTO Staff VALUES(19, 19, 'Chauncey Billups');
INSERT INTO Staff VALUES(20, 20, 'Will Hardy');
INSERT INTO Staff VALUES(21, 21, 'Steve Kerr');
INSERT INTO Staff VALUES(22, 22, 'Tyronn Lue');
INSERT INTO Staff VALUES(23, 23, 'Darvin Ham');
INSERT INTO Staff VALUES(24, 24, 'Monty Williams');
INSERT INTO Staff VALUES(25, 25, 'Mike Brown');
INSERT INTO Staff VALUES(26, 26, 'Jason Kidd');
INSERT INTO Staff VALUES(27, 27, 'Stephen Silas');
INSERT INTO Staff VALUES(28, 28, 'Taylor Jenkins');
INSERT INTO Staff VALUES(29, 29, 'Willie Green');
INSERT INTO Staff VALUES(30, 30, 'Gregg Popovich');
INSERT INTO Staff VALUES(31, 1, 'Torin Hodson');
INSERT INTO Staff VALUES(32, 2, 'Geoffrey Lloyd');
INSERT INTO Staff VALUES(33, 3, 'Beau Conner');
INSERT INTO Staff VALUES(34, 4, 'Aditya Kim');
INSERT INTO Staff VALUES(35, 5, 'Rohan Whelan');
INSERT INTO Staff VALUES(36, 6, 'Vincent Quintero');
INSERT INTO Staff VALUES(37, 7, 'Kevin Andrade');
INSERT INTO Staff VALUES(38, 8, 'Vlad Boyd');
INSERT INTO Staff VALUES(39, 9, 'Jordanne Green');
INSERT INTO Staff VALUES(40, 10, 'Taran Roth');
INSERT INTO Staff VALUES(41, 11, 'Haleemah Callaghan');
INSERT INTO Staff VALUES(42, 12, 'Daisy Brown');
INSERT INTO Staff VALUES(43, 13, 'Nelly Bate');
INSERT INTO Staff VALUES(44, 14, 'Alexandre Gross');
INSERT INTO Staff VALUES(45, 15, 'Daniyal Rose');
INSERT INTO Staff VALUES(46, 16, 'Rizwan Lee');
INSERT INTO Staff VALUES(47, 17, 'Jay-Jay Fox');
INSERT INTO Staff VALUES(48, 18, 'Iga Knapp');
INSERT INTO Staff VALUES(49, 19, 'Felicity Roth');
INSERT INTO Staff VALUES(50, 20, 'Clarissa Henson');
INSERT INTO Staff VALUES(51, 21, 'Christian Barrow');
INSERT INTO Staff VALUES(52, 22, 'Tasmin Cousins');
INSERT INTO Staff VALUES(53, 23, 'Rachael Cannon');
INSERT INTO Staff VALUES(54, 24, 'Madihah Salter');
INSERT INTO Staff VALUES(55, 25, 'Imogen Mackenzie');
INSERT INTO Staff VALUES(56, 26, 'Koby Curtis');
INSERT INTO Staff VALUES(57, 27, 'Gaia Arnold');
INSERT INTO Staff VALUES(58, 28, 'Petra Lara');
INSERT INTO Staff VALUES(59, 29, 'Darryl Middleton');
INSERT INTO Staff VALUES(60, 30, 'Gene Bridges');
INSERT INTO Staff VALUES(61, 1, 'Nuha Lloyd');
INSERT INTO Staff VALUES(62, 2, 'Presley Barnard');
INSERT INTO Staff VALUES(63, 3, 'Aryan Cain');
INSERT INTO Staff VALUES(64, 4, 'Rhianne Clarkson');
INSERT INTO Staff VALUES(65, 5, 'Hamish Rojas');
INSERT INTO Staff VALUES(66, 6, 'Maverick Rice');
INSERT INTO Staff VALUES(67, 7, 'Dion Cortez');
INSERT INTO Staff VALUES(68, 8, 'Kya Martins');
INSERT INTO Staff VALUES(69, 9, 'Taylan Hood');
INSERT INTO Staff VALUES(70, 10, 'Ava-Mai Tyler');
INSERT INTO Staff VALUES(71, 11, 'Yasmin Gill');
INSERT INTO Staff VALUES(72, 12, 'Felicia Ferrell');
INSERT INTO Staff VALUES(73, 13, 'Lola-Rose Underwood');
INSERT INTO Staff VALUES(74, 14, 'Leja Owens');
INSERT INTO Staff VALUES(75, 15, 'Agata Pacheco');
INSERT INTO Staff VALUES(76, 16, 'Jac Sosa');
INSERT INTO Staff VALUES(77, 17, 'Lyndsey Lopez');
INSERT INTO Staff VALUES(78, 18, 'Isis Phan');
INSERT INTO Staff VALUES(79, 19, 'Agatha Goulding');
INSERT INTO Staff VALUES(80, 20, 'Kole Gardner');
INSERT INTO Staff VALUES(81, 21, 'Jocelyn Allan');
INSERT INTO Staff VALUES(82, 22, 'Nikki Gilbert');
INSERT INTO Staff VALUES(83, 23, 'Kathy O''Gallagher');
INSERT INTO Staff VALUES(84, 24, 'Gia Wallis');
INSERT INTO Staff VALUES(85, 25, 'Camille Redman');
INSERT INTO Staff VALUES(86, 26, 'Charlene Craig');
INSERT INTO Staff VALUES(87, 27, 'Momina Bevan');
INSERT INTO Staff VALUES(88, 28, 'Zakaria Calderon');
INSERT INTO Staff VALUES(89, 29, 'Tehya Spencer');
INSERT INTO Staff VALUES(90, 30, 'Shannan Bray');

INSERT INTO Coach VALUES(1, 2);
INSERT INTO Coach VALUES(2, 5);
INSERT INTO Coach VALUES(3, 9);
INSERT INTO Coach VALUES(4, 16);
INSERT INTO Coach VALUES(5, 26);
INSERT INTO Coach VALUES(6, 23);
INSERT INTO Coach VALUES(7, 36);
INSERT INTO Coach VALUES(8, 14);
INSERT INTO Coach VALUES(9, 6);
INSERT INTO Coach VALUES(10, 9);
INSERT INTO Coach VALUES(11, 26);
INSERT INTO Coach VALUES(12, 29);
INSERT INTO Coach VALUES(13, 21);
INSERT INTO Coach VALUES(14, 4);
INSERT INTO Coach VALUES(15, 6);
INSERT INTO Coach VALUES(16, 30);
INSERT INTO Coach VALUES(17, 16);
INSERT INTO Coach VALUES(18, 3);
INSERT INTO Coach VALUES(19, 13);
INSERT INTO Coach VALUES(20, 27);
INSERT INTO Coach VALUES(21, 12);
INSERT INTO Coach VALUES(22, 4);
INSERT INTO Coach VALUES(23, 8);
INSERT INTO Coach VALUES(24, 10);
INSERT INTO Coach VALUES(25, 11);
INSERT INTO Coach VALUES(26, 16);
INSERT INTO Coach VALUES(27, 24);
INSERT INTO Coach VALUES(28, 21);
INSERT INTO Coach VALUES(29, 6);
INSERT INTO Coach VALUES(30, 9);

INSERT INTO Analyst VALUES(31, 'Entry');
INSERT INTO Analyst VALUES(32, 'Intermediate');
INSERT INTO Analyst VALUES(33, 'Advanced');
INSERT INTO Analyst VALUES(34, 'Proficient');
INSERT INTO Analyst VALUES(35, 'Expert');
INSERT INTO Analyst VALUES(36, 'Entry');
INSERT INTO Analyst VALUES(37, 'Intermediate');
INSERT INTO Analyst VALUES(38, 'Advanced');
INSERT INTO Analyst VALUES(39, 'Proficient');
INSERT INTO Analyst VALUES(40, 'Expert');
INSERT INTO Analyst VALUES(41, 'Entry');
INSERT INTO Analyst VALUES(42, 'Intermediate');
INSERT INTO Analyst VALUES(43, 'Advanced');
INSERT INTO Analyst VALUES(44, 'Proficient');
INSERT INTO Analyst VALUES(45, 'Expert');
INSERT INTO Analyst VALUES(46, 'Entry');
INSERT INTO Analyst VALUES(47, 'Intermediate');
INSERT INTO Analyst VALUES(48, 'Advanced');
INSERT INTO Analyst VALUES(49, 'Proficient');
INSERT INTO Analyst VALUES(50, 'Expert');
INSERT INTO Analyst VALUES(51, 'Entry');
INSERT INTO Analyst VALUES(52, 'Intermediate');
INSERT INTO Analyst VALUES(53, 'Advanced');
INSERT INTO Analyst VALUES(54, 'Proficient');
INSERT INTO Analyst VALUES(55, 'Expert');
INSERT INTO Analyst VALUES(56, 'Entry');
INSERT INTO Analyst VALUES(57, 'Intermediate');
INSERT INTO Analyst VALUES(58, 'Advanced');
INSERT INTO Analyst VALUES(59, 'Proficient');
INSERT INTO Analyst VALUES(60, 'Expert');

INSERT INTO TeamDoctor VALUES(61, 'Cardiology');
INSERT INTO TeamDoctor VALUES(62, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(63, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(64, 'Cardiology');
INSERT INTO TeamDoctor VALUES(65, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(66, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(67, 'Cardiology');
INSERT INTO TeamDoctor VALUES(68, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(69, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(70, 'Cardiology');
INSERT INTO TeamDoctor VALUES(71, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(72, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(73, 'Cardiology');
INSERT INTO TeamDoctor VALUES(74, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(75, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(76, 'Cardiology');
INSERT INTO TeamDoctor VALUES(77, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(78, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(79, 'Cardiology');
INSERT INTO TeamDoctor VALUES(80, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(81, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(82, 'Cardiology');
INSERT INTO TeamDoctor VALUES(83, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(84, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(85, 'Cardiology');
INSERT INTO TeamDoctor VALUES(86, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(87, 'Psychiatry');
INSERT INTO TeamDoctor VALUES(88, 'Cardiology');
INSERT INTO TeamDoctor VALUES(89, 'Orthopedic Surgery');
INSERT INTO TeamDoctor VALUES(90, 'Psychiatry');

INSERT INTO Match_Home_Guest VALUES(1, 1, 2, 'Boston Celtics', TO_TIMESTAMP('2022-10-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 90, 83);
INSERT INTO Match_Home_Guest VALUES(2, 2, 3, 'Brooklyn Nets', TO_TIMESTAMP('2022-10-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 106, 86);
INSERT INTO Match_Home_Guest VALUES(3, 3, 4, 'New York Knicks', TO_TIMESTAMP('2022-10-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 82, 70);
INSERT INTO Match_Home_Guest VALUES(4, 4, 5, 'Philadelphia 76ers', TO_TIMESTAMP('2022-10-04 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 84, 82);
INSERT INTO Match_Home_Guest VALUES(5, 5, 6, 'Toronto Raptors', TO_TIMESTAMP('2022-10-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 112, 89);
INSERT INTO Match_Home_Guest VALUES(6, 6, 7, 'Chicago Bulls', TO_TIMESTAMP('2022-10-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 102, 97);
INSERT INTO Match_Home_Guest VALUES(7, 7, 8, 'Cleveland Cavaliers', TO_TIMESTAMP('2022-10-07 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 104, 83);
INSERT INTO Match_Home_Guest VALUES(8, 8, 9, 'Detroit Pistons', TO_TIMESTAMP('2022-10-08 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 83, 81);
INSERT INTO Match_Home_Guest VALUES(9, 9, 10, 'Indiana Pacers', TO_TIMESTAMP('2022-10-09 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 90, 87);
INSERT INTO Match_Home_Guest VALUES(10, 10, 11, 'Milwaukee Bucks', TO_TIMESTAMP('2022-10-10 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 121, 90);
INSERT INTO Match_Home_Guest VALUES(11, 11, 12, 'Atlanta Hawks', TO_TIMESTAMP('2022-10-11 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 98, 87);
INSERT INTO Match_Home_Guest VALUES(12, 12, 13, 'Charlotte Hornets', TO_TIMESTAMP('2022-10-12 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 97, 79);
INSERT INTO Match_Home_Guest VALUES(13, 13, 14, 'Miami Heat', TO_TIMESTAMP('2022-10-13 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 81, 80);
INSERT INTO Match_Home_Guest VALUES(14, 14, 15, 'Orlando Magic', TO_TIMESTAMP('2022-10-14 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 83, 76);
INSERT INTO Match_Home_Guest VALUES(15, 15, 16, 'Washington Wizards', TO_TIMESTAMP('2022-10-15 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 98, 92);
INSERT INTO Match_Home_Guest VALUES(16, 16, 17, 'Denver Nuggets', TO_TIMESTAMP('2022-10-16 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 90, 79);
INSERT INTO Match_Home_Guest VALUES(17, 17, 18, 'Minnesota Timberwolves', TO_TIMESTAMP('2022-10-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 91, 73);
INSERT INTO Match_Home_Guest VALUES(18, 18, 19, 'Oklahoma City Thunder', TO_TIMESTAMP('2022-10-18 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 83, 80);
INSERT INTO Match_Home_Guest VALUES(19, 19, 20, 'Portland Trail Blazers', TO_TIMESTAMP('2022-10-19 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 102, 83);
INSERT INTO Match_Home_Guest VALUES(20, 20, 21, 'Utah Jazz', TO_TIMESTAMP('2022-10-20 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 110, 97);
INSERT INTO Match_Home_Guest VALUES(21, 21, 22, 'Golden State Warriors', TO_TIMESTAMP('2022-10-21 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 98, 81);
INSERT INTO Match_Home_Guest VALUES(22, 22, 23, 'Los Angeles Clippers', TO_TIMESTAMP('2022-10-22 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 93, 86);
INSERT INTO Match_Home_Guest VALUES(23, 23, 24, 'Los Angeles Lakers', TO_TIMESTAMP('2022-10-23 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 109, 80);
INSERT INTO Match_Home_Guest VALUES(24, 24, 25, 'Phoenix Suns', TO_TIMESTAMP('2022-10-24 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 98, 94);
INSERT INTO Match_Home_Guest VALUES(25, 25, 26, 'Sacramento Kings', TO_TIMESTAMP('2022-10-25 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 81, 72);
INSERT INTO Match_Home_Guest VALUES(26, 26, 27, 'Dallas Mavericks', TO_TIMESTAMP('2022-10-26 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 91, 89);
INSERT INTO Match_Home_Guest VALUES(27, 27, 28, 'Houston Rockets', TO_TIMESTAMP('2022-10-27 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 82, 80);
INSERT INTO Match_Home_Guest VALUES(28, 28, 29, 'Memphis Grizzlies', TO_TIMESTAMP('2022-10-28 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 92, 79);
INSERT INTO Match_Home_Guest VALUES(29, 29, 30, 'New Orleans Pelicans', TO_TIMESTAMP('2022-10-29 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 121, 92);
INSERT INTO Match_Home_Guest VALUES(30, 30, 1, 'San Antonio Spurs', TO_TIMESTAMP('2022-10-30 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 94, 89);