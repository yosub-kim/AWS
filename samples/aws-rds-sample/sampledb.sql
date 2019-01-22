-- 기존View와 테이블 제거
DROP VIEW IF EXISTS bookview;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS author;


-- author（저자）테이블 생성
CREATE TABLE author
(
	-- 저자ID
	authorid varchar(10) NOT NULL UNIQUE COMMENT '저자ID',
	-- 저자이름
	authorname varchar(30),
	PRIMARY KEY (authorid)
)DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- book（서적）테이블 생성
CREATE TABLE book
(
	-- 서적ID
	id varchar(10) NOT NULL UNIQUE COMMENT '서적ID',
	-- 서적명
	name varchar(30) COMMENT '서적명',
	-- 서적 가격
	price int COMMENT 서적가격',
	-- 저자ID
	authorid varchar(10) NOT NULL COMMENT '저자ID',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;



-- 외래키 설정
ALTER TABLE book
	ADD FOREIGN KEY (authorid)
	REFERENCES author (authorid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


-- View 생성
CREATE VIEW bookview AS select book.id, book.name, book.price, author.authorname from book,author where book.authorid = author.authorid;

-- 저자 테이블에 데이터 등록
INSERT INTO author (authorid, authorname) VALUES ('a001', '이현세');
INSERT INTO author (authorid, authorname) VALUES ('a002', '공포의 외인구단');

-- 서적 테이블에 데이터 등록
INSERT INTO book (id, name, price, authorid) VALUES ('b001', 'Java첫걸음', '1900', 'a001');
INSERT INTO book (id, name, price, authorid) VALUES ('b002', '즐겁게 배우는 C#', '2500', 'a002');
INSERT INTO book (id, name, price, authorid) VALUES ('b003', '클라우드 전집', '3000', 'a001');


