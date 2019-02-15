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

#### 4.1 보안 그룹에 의한 패킷 필터링
1. 인바운드와 아웃바운드 수정 (인바운드 : EC2 인스턴스로 향하는 통신 정책 , 아웃바운드 : 외부 네트워크로 향하는 통신 정책)
2. 통신 동작 확인

#### 4.2 VPC (Virtual Private Cloud)에 의한 가상 네트워크 구축
* Network Structure
![image](/samples/image.jpg)

1. VPC 생성
2. 서브넷 마스크 생성
3. RDB 서브넷 그룹 생성 (RDS-Master, RDS-Slave)
4. 게이트웨이 생성
5. 보안 그룹 생성 (Client : TCP-8080 , Maintenance : SSH-22)
6. EC2, RDS 인스턴스 생성
7. Load Balancer 생성
8. Maintenance 네트워크 구성 및 동작 확인
~~~
8.1 Maintenance용 EC2 인스턴스 로그인
8.2 RDS 인스턴스에 접속
$ mysql -h [End Point URL] -P 3306 -u [사용자 이름] -p

8.3 Private Key 업로드 (다른 EC2 인스턴스에 SSH로 접속)
$ chmod 400 [.pem 파일]

8.4 접속
$ ssh -i [.pem 파일] [Web-node Private DNS]

8.5 동작확인
~~~

## 5. AWS Security

#### 5.1 IAM을 이용한 사용자 계정 관리
IAM : AWS가 제공하는 사용자 계정 관리 서비스

##### 5.1.1 IAM으로 Android 조작
1. Google Authenticator 설치
2. IAM에서 가상 MFA 연동
3. AWS 접속 시 인증 시스템 입력

##### 5.1.2 IAM으로 AWS 개인 조작
1. IAM 계정 생성
2. 관리 정책 추가
3. [IAM 사용자 로그인 링크] URL 접속
4. 로그인 시 추가한 정책을 제외하고 접속 불가 

##### 5.1.3 IAM으로 AWS 그룹 조작
1. IAM 그룹 생성
2. 관리 정책 추가
3. IAM 계정을 그룹에 추가

#### 5.2 데이터 암호화
1. EC2 인스턴스에 SSH 접속 (private key)
2. S3 데이터 암호화 (AWS S3 Service 마스터 키 사용)
3. RDS 데이터 암호화 (AWS Key Management Service 마스터 키 사용)


## 6. Docker 컨테이너
가상화 환경에서 애플리케이션을 관리/실행하기 위한 오픈 소스 기반의 플랫폼

#### 6.1 Docker 설치
Docker를 설치하는 방법은 크게 Docker for Mac, Docker Toolbox 2가지가 있다.<br>
* Docker for Mac 사용 시 Applications 폴더 내에 app으로 관리, 가상화는 HyperKit 을 통해 이루어진다.
* Docker Toolbox 사용 시 /usr/local/bin 폴더에 docker, docker-compose, docker-machine이 설치, 가상화는 VirtualBox 을 통해 이루어진다.

1. Docker Toolbox 설치
~~~
Docker run
$ docker run [Docker 이미지명] [실행 명령어]

'Hello world 출력 시'
$ docker run ubuntu:latest /bin/echo 'Hello world'
~~~

#### 6.2 Docker 이미지 생성
Dockerfile : 인프라 구성을 기술한 파일
1. JavaEE의 애플리케이션을 실행을 위한 WAS인 GlassFish 설치
2. Dockerfile 생성
~~~
$ mkdir sample && cd $_
$ touch Dockerfile
~~~
3. 베이스 이미지 지정
~~~
glassfish를 베이스 이미지로 지정
$ FROM glassfish:4.1-jdk8
~~~
4. 생성자 정보
~~~
$ MAINTAINER [e-mail]
~~~
5. 환경 변수 설정
~~~
$ ENV GLASSFISH_HOME /usr/local/glassfish4
$ ENV PASSWORD glasspass
$ ENV TMPFILE /tmp/passfile
~~~
6. 명령어 실행
~~~
관리자 비밀 번호와 보안 설정
$ RUN echo "AS_ADMIN_PASSWORD=">$TMPFILE && \
      echo "AS_ADMIN_NEWPASSWORD=${PASSWORD}">>TMPFILE && \
      asadmin --user=addmin --passwordfile=$TMPFILE change-admin-password --domain_name domain1 && \
      asadmin start-domain && \
      echo "AS_ADMIN_NEWPASSWORD=${PASSWORD}">TMPFILE && \
      asadmin --user=addmin --passwordfile=$TMPFILE enable-secure-admin && \
      asadmin --user=admin stop-domain && \
      rm $TMPFILE
~~~
7. Web Application Deploy
~~~
war 콘텐츠 배치
$ ADD DockerSample.war $ GLASSFISH_HOME/glassfish/domains/domain1/autodeploy
~~~
8. 포트 개방
~~~
glassfish가 사용하는 4848, 8080 포트 개방
$ EXPORT 4848 8080
~~~
9. GlassFish 기동
~~~
$ CMD ["asadmin", "start-domain", "-v"]
~~~
10. Dockerfile 의 Docker 이미지 생성
~~~
$ docker build -t [생성하는 이미지 이름]:[태그명] [Dockerfile 위치]
$ docker build -t [사용자 이름]/docker-glassfish:1.0
$ docker images
~~~

#### 6.3 Docker 이미지 공개
1. Docker Hub 계정 등록
2. Docker Hub에 공개
~~~
$ docker login
$ docker push [사용자이름]/docker-glassfish:1.0
~~~

#### 6.4 AWS에서 Docker 실행
1. EC2를 사용하는 방법 
2. ECS를 사용하는 방법
3. Elastic Beanstalk를 사용하는 방법

#### 6.5 EC2에서 사용하는 방법
1. EC2에 대한 Docker 설치
~~~
$ sudo service docker start
~~~
2. Docker 컨테이너 실행
~~~
$ sudo docker pull [사용자 이름]/docker-glassfish:1.0
$ sudo docker images
$ sudo docker run [옵션] --name [컨테이너 이름] [이미지 이름:태그 이름]

ex) "glassfish-container"이라는 이름의 컨테이너를 "[사용자 이름]/docker-glassfish:1.0"이라는 이름의 docker 이미지를 기반으로 실행하고, 8080, 4848번 포트를 매핑하겠다.
$ sudo docker run -d --name glassfish-container -p 8080:8080 -p 4848:4848 [사용자 이름]/docker-glassfish:1.0
~~~

#### 6.6 ECS에서 사용하는 방법
1. ECS 시작
2. 컨테이너 값 설정
3. 서비스 구성
4. 부하 분산 정의 (ELB)
5. Security 정의 (IAM)
6. 클러스터 정의
7. Docker 클러스터 실행
~~~
> http://[ELB의 DNS 이름]:8080/DockerSample/
~~~
## 7. 시스템 운용

#### 7.1 CloudWatch에 의한 감시

#### 7.2 WordPress 환경의 자동 구성
1. CloudFormation 기동
2. 스택 형성
3. 동작 확인

#### 7.3 데이터 백업과 복구
1. 스냅샷에 의한 데이터 백업 & 복구
2. RDS 또한 DB 스냅샷에 의한 데이터 백업 & 복구