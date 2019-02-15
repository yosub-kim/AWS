<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<html lang="ja">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>成功</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">

    <!-- Bootstrap theme -->
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
  </head>

 </head>

<body>

    <div class="jumbotron">
        <h3>AWS의 RDS에 등록되어있는 내용입니</h3>
    </div>

    <table class="table table-striped table-hover table-bordered ">
        <thead>
            <tr>
                <th>도서 번</th>
                <th>서적</th>
                <th>가격 (엔)</th>
                <th>저자</th>
            </tr>
        </thead>

        <tbody>
        <c:forEach var="book" items="${bookbean}">
          <tr>
              <td>${book.id}</td>
              <td>${book.name}</td>
              <td>${book.price}</td>
              <td>${book.authorname}</td>
          </tr>
      </c:forEach>
        </tbody>

    </table>

</body>
</html>