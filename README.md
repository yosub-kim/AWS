# Amazon Web Services 
AWS를 활용하자.
## 1. 클라우드 서비스, AWS 기본
기본적인 클라우드 서비스 및 AWS 서비스
## 2. Web 서버 구축

#### 2.1 EC2를 사용한 Web 서버 구축
OS : Amazon Linux AMI 2018.03.0(HVM)
~~~
접속
$ chmod 400 [.pem 파일]
$ ssh -i [.pem 파일] ec2-user@[접속할 인스턴스 Public IP]

REMOTE HOST IDENTIFICATION HAS CHANGED 문제 발생 시
$ ssh-kengen -R [접속할 인스턴스 Public IP]

Web 서버 설치 및 자동실행
$ sudo yum -y update
$ sudo yum install -y httpd
$ sudo service httpd start
$ sudo chkconfig httpd on

파일 전송
$ scp -i [.pem 파일] [upload file] ec2-user@[접속할 인스턴스 Public IP]:~/
~~~

#### 2.2 ELB를 사용한 부하 분산
1. 커스텀 AMI의 생성
2. 작성한 AMI에서 2개의 새로운 인스턴스 생성
3. 로드밸런서 생성
4. ELB 동작 확인

#### 2.3 Elastic IP를 사용한 도메인 운용
1. Elastic IP 할당
2. Router 53에 의한 DNS 서버 설정
3. 레코드 설정 후 레지스트라 등록 (빠르면 몇분, 오래걸릴 땐 12시간 이상 걸리는 경우도 있음)
4. 동작 확인

#### 2.4 CloudFront를 사용한 데이터 전달
1. CloudFront 작동
2. Web (Web 콘텐츠 전달) 혹은 RTMP (스트리밍 전송 프로토콜)

## 3. Web application 서버 구축
EC2를 사용한 Web application 서버 - RDS를 사용한 데이터베이스 서버

#### 3.1 Application 개발 환경 구축
1. AWS Toolkit for Eclipse 설치
2. IAM을 사용하여 Access User 생성
3. AWS Toolkit에 인증

#### 3.2 MySQL에 의한 데이터베이스 서버 구축
1. 보안그룹생성 (TCP port : 3306)
2. RDS Parameter Group 생성 (Mysql 사용 파라미터)
3. RDS 인스턴스 생성
4. AWS Toolkit에서 데이터 등록
~~~
Mysql 접속
$ cd /usr/local/mysql/bin
$ ./mysql -h [End Point URL] -P 3306 -u [사용자 이름] -p
~~~
#### 3.3 Tomcat - Web Application 서버 구축
1. 보안그룹생성 (TCP Port : 8080)
2. EC2 인스턴스 생성 
3. Apache Tomcat 설치
~~~
Java 버전 8로 변경 (초기는 Java 7)
$ sudo yum -y install java-1.8.0-openjdk-devel
$ sudo alternatives --config java

Tomcat8 설치
$ sudo yum -y install tomcat8

JDBC 드라이버 설치
$ sudo yum install -y mysql-connector-java
~~~
#### 3.4 Web Application Deploy (.War file EC2 인스턴스로 업로드)
~~~
$ sudo cp [.war 파일 경로] /usr/share/tomcat8/webapps
~~~
#### 3.5 Tomcat8 작동
~~~
Tomcat 8 작동 및 자동실행
$ sudo service tomcat8 start
$ sudo chkconfig tomcat8 on

Tomcat8의 GUI deploy
$ sudo yum -y install tomcat8-admin-webapps
> http://[EC2 Public DNS]:8080/manager

Tomcat8 manager 403 access denied 문제 발생 시
$ sudo vi /usr/share/tomcat8/conf/tomcat-users.xml
> 맨 아래 manager관련 role의 주석을 없앤다.

$ sudo vi /usr/share/tomcat8/webapps/manager/META-INF/context.xml
<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
     allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
> 주석 처리 해준다.

$ sudo service tomcat8 restart
~~~
#### 3.6 Tomcat8 동작 확인
~~~
> http://[EC2 Public DNS]:8080/[War name]/[File name]
~~~
#### 3.7 WAS용 AMI 생성
1. 커스텀 AMI를 사용하여 새로운 EC2 인스턴스 생성
2. Elastic IP 할당

## 4. 네크워크 구축
~~~
~~~