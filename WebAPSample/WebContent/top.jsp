<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ja">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>동작확</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">

    <!-- Bootstrap theme -->
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
  </head>

 </head>

<body>

      <div class="jumbotron">
        <h2>Hello, Amazon Web Services!</h2>
        <p>버튼을 클릭하면 RDS에서 데이터를 표시합니다</p>
        <form action="connectDB" method="POST">
            <button type="submit" class="btn btn-primary btn-lg">DB 값 취득</button>
        </form>
      </div>

</body>
</html>