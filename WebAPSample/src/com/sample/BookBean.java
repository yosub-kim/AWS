package com.sample;

/**
 * 書籍情報を保持するクラス
 *
 * @author shiho.asa
 * @version 1.0
 *
 */
public class BookBean {

    // 書籍ID
	private String id;

	// 書籍名
	private String name;

	// 書籍の価格
    private int price;

    // 著者の名前
    private String authorname;


	/**
	 * 書籍IDの取得
	 *
	 * @return id
	 */
	public String getId() {
		return id;
	}

	/**
	 * 書籍IDの設定
	 * @param id 書籍ID
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * 書籍名の取得
	 * @return name
	 */
	public String getName() {
		return name;
	}

	/**
	 * 書籍名の設定
	 * @param name 書籍名
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 書籍の価格の取得
	 * @return price
	 */
	public int getPrice() {
		return price;
	}

	/**
	 * 書籍の価格の設定
	 * @param price 書籍の価格
	 */
	public void setPrice(int price) {
		this.price = price;
	}
	/**
	 * 著者の名前の取得
	 * @return authorname
	 */
	public String getAuthorname() {
		return authorname;
	}
	/**
	 * 著者の名前の設定
	 * @param authorname 著者の名前
	 */
	public void setAuthorname(String authorname) {
		this.authorname = authorname;
	}

}
