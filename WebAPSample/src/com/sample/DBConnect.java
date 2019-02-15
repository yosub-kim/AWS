package com.sample;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.tomcat.jdbc.pool.DataSource;


/**
 *
 * DB接続を行い、処理結果を返すクラス
 *
 * @author shiho.asa
 * @version 1.0
 *
 */
public class DBConnect {

	// コンストラクタ
	public DBConnect() {
	}

	/**
	 * DBから書籍一覧を取得するメソッド
	 *
	 * @return 書籍の一覧
	 *
	 */
	public List<BookBean> getAllBook() throws NamingException {

		// 戻り値
		List<BookBean> result = new ArrayList<BookBean>();

		// DB接続オブジェクト
		InitialContext context = new InitialContext();
		DataSource ds = (DataSource) context.lookup("java:/comp/env/jdbc/AWS-RDS");

		try (
				// データベースへの接続
				Connection con = ds.getConnection();

				// ステートメントの作成
				Statement st = con.createStatement();

				// SQLの実行
				ResultSet rs = st.executeQuery("select id, name, price, authorname from bookview");
			){

			// データベースの検索結果をBookBeanに格納する
			while (rs.next()) {

				BookBean bb = new BookBean() {
					{
						setId(rs.getString("id"));
						setName(rs.getString("name"));
						setPrice(rs.getInt("price"));
						setAuthorname(rs.getString("authorname"));
					}
				};
				result.add(bb);
			}

		} catch (Exception e) {
			// エラー処理
			e.printStackTrace();
		}

		// データベースの検索結果が格納されたList<BookBean>を返す
		return result;

	}

}
