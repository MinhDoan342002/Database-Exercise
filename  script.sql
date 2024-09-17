SET SQL_SAFE_UPDATES = 0;
CREATE TABLE PhongBan (
	MSPB CHAR(2) PRIMARY KEY,
	TenPB VARCHAR(20)
);

INSERT INTO PhongBan VALUES ('P1', 'Hanh Chanh');
INSERT INTO PhongBan VALUES ('P2', 'Ke Toan');
INSERT INTO PhongBan VALUES ('P3', 'Kinh Doanh');
INSERT INTO PhongBan VALUES ('P4', 'Nghien Cuu');

CREATE TABLE NhanVien (
	MSNV CHAR(4) PRIMARY KEY,
	Ho VARCHAR(20),
	Ten VARCHAR(10),
	NgaySinh DATE,
	NgayVaoLam DATE,
	Phai CHAR(1),
	MSPB CHAR (2) REFERENCES PhongBan(MSPB),
	Luong INT,
	MSNQL CHAR(4) REFERENCES NhanVien(MSNV)
);

INSERT INTO NHanVien VALUES ('0001', 'Le Van', 'An', '1960-05-12', '1990-08-1', 'M', 'P1', 2000, Null);
INSERT INTO NhanVien VALUES ('0002', 'Nguyen', 'Minh', '1975-06-20', '1998-09-6', 'M', 'P1', 1800, '0001');
INSERT INTO NhanVien VALUES ('0003', 'Ly Thi', 'Nga', '1980-06-17', '2000-08-26', 'F', 'P2', 1200, '0001');
INSERT INTO NhanVien VALUES ('0004', 'Tran Van', 'Tuan', '1978-01-1', '1997-05-16', 'M', 'P1', 2200, '0001');
INSERT INTO NhanVien VALUES ('0005', 'Ly Thi', 'Chi', '1981-03-12', '2015-01-20', 'F', 'P1', 800, '0002');
INSERT INTO NhanVien VALUES ('0006', 'Ngo Thi Thu', 'An', '1966-07-11', '2008-05-15', 'F', 'P1', 1200, '0005');
INSERT INTO NhanVien VALUES ('0007', 'Mai Kim', 'Chi', '1970-06-24', '1999-08-15', 'F', 'P2', 2000, '0003');
INSERT INTO NhanVien VALUES ('0008', 'Tran Van Tuan', 'Anh', '1976-05-16', '2008-05-20', 'M', 'P3', 800, '0004');
INSERT INTO NhanVien VALUES ('0009', 'Le Ngoc', 'Mai', '1975-03-14', '1995-04-17', 'F', 'P3', 400, '0004');


CREATE TABLE BacLuong (
	Bac INT PRIMARY KEY,
	ThapNhat INT,
	CaoNhat INT
);

INSERT INTO BacLuong VALUES (1, 100, 500);
INSERT INTO BacLuong VALUES (2, 501, 1000);
INSERT INTO BacLuong VALUES (3, 1001, 2000);
INSERT INTO BacLuong VALUES (4, 2001, 3000);

ALTER TABLE NhanVien
ADD Tuoi INT(3);
UPDATE NhanVien
SET Tuoi = TIMESTAMPDIFF(YEAR,NgaySinh,CURDATE());