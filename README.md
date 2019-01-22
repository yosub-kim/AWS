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
1. CloudFront 기동
2. Web (Web 콘텐츠 전달) 혹은 RTMP (스트리밍 전송 프로토콜)

## 3. Web application 서버 구축
~~~

~~~
