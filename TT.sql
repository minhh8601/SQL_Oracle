/********* A. BASIC QUERY *********/
--CÂU 1 Li?t kê danh sách, s?p x?p theo th? t?--
--a M? sinh vien tăng d?n--
SELECT * FROM student
ORDER by id ASC;
--b Gi?i tính nam/n?
SELECT * FROM student
ORDER by gender;
--c ngày sinh tăng d?n h?c b?ng gi?m d?n
SELECT * FROM student
ORDER by birthday ASC, scholarship DESC;

--CÂU 2 MÔN H?C B?T Đ?U B?NG CH?'T'
SELECT * FROM subject
WHERE name LIKE N'T%';

--CÂU3 SINH VIÊN CÓ CH? CÁI CU?I CÙNG TRONG TÊN LÀ 'i'
SELECT * FROM student
WHERE name LIKE N'%i';

--CÂU4 Nh?ng khoa có k? t? th? hai c?a tên khoa có ch?a ch? 'n'
SELECT * FROM faculty
WHERE name LIKE N'_n%';

--CÂU 5 Sinh viên trong tên có t? 'Th?'
SELECT * FROM student
WHERE name LIKE N'%Th?%';

--CÂU 6 Sinh viên có k? t? đ?u tiên c?a tên n?m trong kho?ng t? 'a' đ?n 'm', s?p x?p theo h? tên sinh viên
SELECT * FROM student
WHERE name between 'A' and 'M'
ORDER by name asc

--CÂU 7 Sinh viên có h?c b?ng l?n hơn 100000, s?p x?p theo m? khoa gi?m d?n
SELECT * FROM student
WHERE  scholarship>100000
ORDER by faculty_id desc;

--CÂU 8 Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i

SELECT * FROM student
WHERE  scholarship>=150000 and hometown =N'Hà N?i';
 --CÂU 9 Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 đ?n ngày 05/06/1992
 
SELECT * FROM student
WHERE  birthday between '01/01/1991' and '06/05/1992';

--CÂU 10  Nh?ng sinh viên có h?c b?ng t? 80000 đ?n 150000
SELECT * FROM student
WHERE  scholarship between 80000 and 150000 ;

--CÂU 11 Nh?ng môn h?c có s? ti?t l?n hơn 30 và nh? hơn 45
SELECT * FROM subject
WHERE  lesson_quantity>30 and lesson_quantity<45 ;

/********* B. CALCULATION QUERY *********/
--CÂU 1Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: M? sinh viên, Gi?i tính, M? 
		-- khoa, M?c h?c b?ng. Trong đó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr? 
		-- c?a h?c b?ng l?n hơn 500,000 và ngư?c l?i hi?n th? là “M?c trung b?nh”.
        
SELECT id ,faculty_id, gender, (case when scholarship >500000 then N'H?c b?ng cao' else N'M?c trung b?nh' end) as "M?c h?c b?ng"
FROM student

--CÂU 2 Tính t?ng s? sinh viên c?a toàn trư?ng
SELECT  count(id) as "T?ng sinh viên"
FROM student

--CÂU 3  Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
SELECT  count(case gender when N'Nam'then 1 else 0 end) as"T?ng sinh viên nam" ,count(case gender when N'N?'then 1 else 0 end) as"T?ng sinh viên n?"
FROM student

--CÂU4 Tính t?ng s? sinh viên t?ng khoa
SELECT faculty_id as "M? khoa", count(id) as "T?ng sinh viên c?a khoa"
FROM student
group by faculty_id;

--CÂU 5 Tính t?ng s? sinh viên c?a t?ng môn h?c
SELECT name as "Tên môn h?c", count(distinct student_id) as "T?ng sinh viên"
FROM exam_management ex,subject sv
where ex.subject_id = sv.id
group by name

--CÂU6 Tính s? lư?ng môn h?c mà sinh viên đ? h?c
select count(distinct  subject_id)as "T?ng s? môn h?c"
from exam_management

--CÂU 7 T?ng s? h?c b?ng c?a m?i khoa	
select faculty_id as "M? khoa",sum(scholarship) as"T?ng h?c b?ng"
from student
group by faculty_id

--CÂU 8 Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
select faculty_id as "M? khoa",max(scholarship) as" h?c b?ng cao nh?t"
from student
group by faculty_id

--CÂU 9 Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa
SELECT faculty_id as "M? khoa",  count(case gender when N'Nam'then 1 else 0 end) as"T?ng sinh viên nam" ,count(case gender when N'N?'then 1 else 0 end) as"T?ng sinh viên n?"
FROM student
group by faculty_id

--CÂU10 Cho bi?t s? lư?ng sinh viên theo t?ng đ? tu?i
select EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday) as "Đ? tu?i",count(id) as "s? sinh viên"
from student
group by EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday)

--CÂU 11 Cho bi?t nh?ng nơi nào có ít nh?t 2 sinh viên đang theo h?c t?i trư?ng

select hometown as "Nơi sinh",count(id)as "S? sinh viên"
from student
group by hometown
having count(id)>=2

--CÂU 12  Cho bi?t nh?ng sinh viên thi l?i ít nh?t 2 l?n

select student_id,subject_id,count(number_of_exam_taking) as"S? l?n thi l?i"
from exam_management 
group by student_id,subject_id
having count(number_of_exam_taking)>=2

-- 13. Cho bi?t nh?ng sinh viên nam có đi?m trung b?nh l?n 1 trên 7.0 
select name as"h? tên sinh viên",gender,number_of_exam_taking,avg(mark)as"Đi?m trung b?nh"
from exam_management ex,student sv
where ex.student_id=sv.id and number_of_exam_taking=1 and gender=N'Nam'
group by number_of_exam_taking,gender, name
having avg(mark)>7.0

--14. Cho bi?t danh sách các sinh viên r?t ít nh?t 2 môn ? l?n thi 1 (r?t môn là đi?m thi c?a môn không quá 4 đi?m)

select student_id as"M? sinh viên",count(subject_id)as"s? lư?ng môn trư?t"
from exam_management
where number_of_exam_taking=1 and mark<4
group by student_id
having count(subject_id)>=2

-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u hơn 2 sinh viên nam
select faculty_id as"M? khoa", k.name,count(sv.id)as"s? sinh viên nam"
from student sv,faculty k
where sv.faculty_id=k.id and gender=N'Nam'
group by sv.faculty_id,gender,k.name
having count(sv.id)>=2

-- 16. Cho bi?t nh?ng khoa có 2 sinh viên đ?t h?c b?ng t? 200000 đ?n 300000
select faculty_id as"M? khoa", k.name,count(sv.id)as"s? sinh viên "
from student sv,faculty k
where sv.faculty_id=k.id and scholarship>100000 and scholarship<300000
group by sv.faculty_id,k.name
having count(sv.id)>=2


-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t
select *
from student
where scholarship =(select max(scholarship) from student)


/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có nơi sinh ? Hà N?i và sinh vào tháng 02

SELECT * 
FROM student
where hometown=N'Hà N?i' and EXTRACT(month FROM birthday)=2

-- 2. Sinh viên có tu?i l?n hơn 20

SELECT * 
FROM student
where EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday)>20

-- 3. Sinh viên sinh vào mùa xuân năm 1990
SELECT * 
FROM student
where  EXTRACT(YEAR from birthday)=1990 and EXTRACT(month from birthday) in(1,2,3) 


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH VĂN và khoa V?T L?

Select  sv.faculty_id,k.name,sv.id, sv.name
From faculty k inner join student sv on k.id=sv.faculty_id
where k.name like N'Anh - Văn' or k.name like N'Vật lí?'


-- 2. Nh?ng sinh viên nam c?a khoa ANH VĂN và khoa TIN H?C
Select  sv.faculty_id,k.name,sv.id, sv.name,sv.gender
From faculty k inner join student sv on k.id=sv.faculty_id
where (k.name like N'Anh - Văn' or k.name like N'Tin học') and sv.gender like N'Nam'

--3.Cho bi?t sinh viên nào có đi?m thi l?n 1 môn cơ s? d? li?u cao nh?t
Select  ex.student_id,sj.name as "Môn học",ex.mark
From   exam_management ex inner join subject sj on ex.subject_id=sj.id
where (mark =(select max(mark) from exam_management)) and sj.name like N'Cơ sở dữu liệu'


-- 4. Cho biết sinh viên khoa anh văn có tuổi lớn nhất.

SELECT sv.id, sv.name, sv.birthday, sv.scholarship, sv.gender, k.name
FROM student sv
JOIN faculty k ON sv.faculty_id = k.id
WHERE k.name = 'Anh - Văn'
      AND EXTRACT(YEAR FROM birthday) = EXTRACT(YEAR FROM(
    SELECT MIN(birthday)
    FROM student
));
-- 5. Cho biết khoa nào có đông sinh viên nhất// chưa join
select fa.name
from faculty fa,student sv
where sv.faculty_id=fa.id
group by fa.name
having count(fa.name)>=all(select count(sv.id)
from student
group by faculty_id)

--6 Cho biết khoa nào có đông nữ nhất chưa join

select k.name
from faculty k,student sv
where sv.faculty_id=k.id and gender=N'Nữ'
group by k.name
having count(k.name)>=all(select count(sv.id)
from student
group by faculty_id)

-- 7. Cho biết những sinh viên đạt điểm cao nhất trong từng môn chưa join
select student_id,exam_management.subject_id,mark
from exam_management, (select subject_id, max(mark) as maxdiem
from exam_management
group by subject_id)a
where exam_management.subject_id=a.subject_id and mark=a.maxdiem

-- 8. Cho biết những khoa không có sinh viên học chưa join
SELECT k.name, COUNT(*)
FROM faculty k JOIN student sv ON sv.faculty_id = k.id
GROUP BY k.name
HAVING COUNT(*) = 0;
-- 9. Cho biết sinh viên chưa thi môn cơ sở dữ liệu chưa join
select *
FROM student
where not exists
(select distinct*
from exam_management
where subject_id = '1' and student_id = student.id)

-- 10. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2 chưa join
select student_id
from exam_management ex
where number_of_exam_taking=2 and not exists
(select*
from exam_management
where number_of_exam_taking=1 and student_id=ex.student_id)

