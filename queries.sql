SELECT * FROM NhanVien;
SELECT * FROM PhongBan;
SELECT * FROM BacLuong;

# Thêm cột Bậc Lương vào table NhanVien

SELECT A.Ho , A.Ten , A.NgaySinh , A.Tuoi , A.Phai , A.MSPB , A.Luong , B.Bac , A.MSNQL  
FROM NhanVien A
INNER JOIN BacLuong B
WHERE A.Luong >= B.ThapNhat AND A.Luong <= B.CaoNhat
ORDER BY A.MSNV;

#TRUNG BINH LUONG

SELECT MSNQL, AVG(Luong) AS TRUNGBINHLUONG
FROM NhanVien
GROUP BY MSNQL;

# Hiển thị mã số, họ tên (họ và tên ghép chung vào 1 cột), tuổi của tất cả các nhân viên

SELECT CONCAT(Ho," ",Ten ) AS Ho_Ten , TIMESTAMPDIFF(YEAR,NgaySinh,CURDATE()) AS Tuoi FROM NhanVien;

# Hiển thị các nhân viên tên ‘An’

SELECT CONCAT(Ho," ",Ten ) AS Ho_Ten FROM NhanVien
WHERE Ten = "An" ;

# Hiển thị các nhân viên mà tên bắt đầu bằng chữ ‘A’

SELECT CONCAT(Ho," ",Ten ) AS Ho_Ten FROM NhanVien
WHERE Ten REGEXP "^A" ;

# Hiển thị các nhân viên nữ (Phai = F) của phòng có MSPB=’P1’ 

SELECT MSNV , CONCAT(Ho," ",Ten ) AS Ho_Ten , Phai , MSPB FROM NhanVien
WHERE Phai ="F"  AND MSPB = "P1";

# Liệt kê các nhân viên có lương từ 500 đến 1000

SELECT MSNV , CONCAT(Ho," ",Ten ) AS Ho_Ten , Luong FROM NhanVien
WHERE Luong BETWEEN 500 AND 1000;

# Hiển thị MSNV, Họ, Tên, số năm làm việc của những người đã vào làm từ 10 năm trở lên

SELECT MSNV , CONCAT(Ho," ",Ten ) AS HoTen , TIMESTAMPDIFF(year , NgayVaoLam , CURDATE()) AS NamLamViec 
FROM NhanVien
WHERE TIMESTAMPDIFF(year , NgayVaoLam , CURDATE()) > 10 ;

# Liệt kê các nhân viên nam ở các phòng ‘P1’ và ‘P2’

SELECT MSNV , CONCAT(Ho," ",Ten ) AS HoTen , Phai , MSPB FROM NhanVien 
WHERE Phai = "M" AND ( MSPB = "P1" OR MSPB = "P2");

# Hiển thị nhân viên không có người quản lý (cột MSNQL để trống).

SELECT MSNV , CONCAT(Ho," ",Ten ) AS HoTen , MSNQL FROM NhanVien 
WHERE MSNQL IS NULL; 

# Hiển thị MSNV, Ho, Ten, MSPB, TenPB của các nhân viên thuộc phòng ‘Ke Toan’

SELECT A.MSNV , CONCAT(Ho," ",Ten ) AS HoTen , A.MSPB , B.TenPB
FROM NhanVien A 
INNER JOIN PhongBan B ON A.MSPB = B.MSPB 
WHERE B.TenPB = "Ke Toan"; 

# Thống kê xem mỗi phòng ban có bao nhiêu nhân viên. Thông tin hiển thị gồm 3 cột:
                                # MSPB, TenPB, số lượng nhân viên của phòng ban đó
                                
SELECT A.MSPB , B.TenPB , COUNT(MSNV) AS SoNhanVien 
FROM NhanVien A 
RIGHT JOIN PhongBan B ON A.MSPB = B.MSPB 
GROUP BY B.MSPB;

# Liệt kê các phòng có số lượng nhân viên từ 3 người trở lên. Thông tin hiển thị gồm:
                              # MSPB, Tên phòng ban, số lượng nhân viên của phòng đó.
                              
SELECT * FROM (SELECT B.TenPB , COUNT(A.MSNV) AS SoNhanVien
FROM NhanVien A 
LEFT JOIN PhongBan B ON B.MSPB = A.MSPB 
GROUP BY B.TenPB ) AS A WHERE SoNhanVien > 3 ;

# Thống kê xem mỗi phòng ban có bao nhiêu nhân viên nam, bao nhiêu nhân viên nữ.

SELECT B.MSPB , B.TenPB , A.Phai ,COUNT(*) AS SoNV
FROM NhanVien A
LEFT JOIN PhongBan B ON B.MSPB = A.MSPB
GROUP BY B.MSPB , A.Phai 
ORDER BY B.MSPB ,  A.Phai ;

# Cho biết phòng nào hiện không có nhân viên

SELECT A.MSPB , B.TenPB , A.MSNV FROM PhongBan B
LEFT JOIN NhanVien A ON B.MSPB = A.MSPB
WHERE A.MSNV IS NULL ;

# Liệt kê các nhân viên hưởng lương cao nhất trong công ty

SELECT * FROM (SELECT DISTINCT luong , CONCAT(Ho," ",Ten ) AS HoTen FROM NhanVien ORDER BY luong DESC Limit 3)  AS A ;

# Liệt kê các nhân viên hưởng lương cao nhất ở mỗi phòng ban

SELECT  MSPB ,max(luong) AS LuongCaoNhat , COUNT(MSNV)
FROM ( 
SELECT *  FROM NhanVien ORDER BY luong DESC 
)  AS A 
GROUP BY  MSPB , luong 
ORDER BY MSPB ASC ,max(luong) DESC ;

# Liệt kê các phòng mà tất cả các nhân viên đều là nữ (Phai=F)

SELECT B.TenPB , COUNT(A.Phai) AS SoNV FROM PhongBan B
JOIN NhanVien A ON B.MSPB = A.MSPB
GROUP BY B.TenPB
HAVING COUNT(CASE WHEN A.Phai = 'F' THEN 1 END) = COUNT(A.MSPB);
# GROUP số nvien vào các phòng ban 
# Đếm số nvien nữ , nếu = tổng số nvien của phòng ban thì lấy

#Hiển thị các nhân viên có cùng họ "Tran"

SELECT MSNV, CONCAT(Ho,' ',Ten) AS HoVaTen 
FROM NhanVien
WHERE Ho REGEXP '^Tran+';

# Liệt kê các nhân viên có tên trùng nhau

SELECT A.MSNV, CONCAT(A.Ho,' ',A.Ten) AS HoVaTen 
FROM NhanVien A , NhanVien B
WHERE A.Ten = B.Ten AND A.MSNV <> B.MSNV 
ORDER BY A.Ten;

# Hiển thị nhân viên có ngày sinh vào tháng 6

SELECT MSNV, CONCAT(Ho,' ',Ten) AS HoVaTen , NgaySinh
FROM NhanVien
WHERE MONTH(NgaySinh) = 6;

# Tìm 3 nhân viên trẻ tuổi nhất trong công ty

SELECT MSNV, CONCAT(Ho,' ',Ten) AS HoVaTen , TIMESTAMPDIFF(YEAR, NgaySinh , CURDATE()) AS Tuoi
FROM NhanVien
ORDER BY TIMESTAMPDIFF(YEAR, NgaySinh , CURDATE()) DESC 
LIMIT 3;

# Liệt kê các nhân viên có ngày vào làm sau năm 2000

SELECT MSNV, CONCAT(Ho,' ',Ten) AS HoVaTen , NgayVaoLam
FROM NhanVien 
Where YEAR(NgayVaoLam) > 2000;

# Hiển thị các nhân viên có người quản lý là '0001'

SELECT MSNV, CONCAT(Ho,' ',Ten) AS HoVaTen , MSNQL 
FROM NhanVien 
WHERE MSNQL = '0001' ;
