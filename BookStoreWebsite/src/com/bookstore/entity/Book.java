package com.bookstore.entity;
// Generated Jun 1, 2021, 2:58:15 PM by Hibernate Tools 5.2.12.Final

import java.util.Base64;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;


@Entity
@Table(name = "book", catalog = "bookstoredb", uniqueConstraints = @UniqueConstraint(columnNames = "title"))


@NamedQueries({
	@NamedQuery(name="Book.findAll", 		query="Select u from Book u "),
	@NamedQuery(name="Book.findCountAll", 	query="Select Count(u) FROM Book u "),
	@NamedQuery(name="Book.findByTitle", 	query="Select u FROM Book u where u.title=:title "),
	@NamedQuery(name="Book.findByCategory", query="Select b FROM Book b WHERE b.category.categoryId= :catId "),
	@NamedQuery(name="Book.listNew", 		query="Select u from Book u order by u.publishDate desc"),
	@NamedQuery(name="Book.search", 		query="Select u from Book u  where u.title LIKE '%' || :keyword || '%' "
			+ "OR u.author LIKE '%' || :keyword || '%' OR u.description LIKE '%' || :keyword || '%' "),
	@NamedQuery(name="Book.countByCategory", query="Select COUNT (b) FROM Book b WHERE b.category.categoryId= :catId ")
})
public class Book implements java.io.Serializable {

	private Integer bookId;
	private Category category;
	private String title;
	private String author;
	private String description;
	private String isbn;
	private byte[] image;
	private String base64Image;
	private float price;
	private Date publishDate;
	private Date lastUpdated;
	private Set<Review> reviews = new HashSet<Review>(0);
	private Set<OrderDetail> orderDetails = new HashSet<OrderDetail>(0);
	

	public Book() {
	}
	
	

	public Book(Category category,String title, String author, String description, String isbn, byte[] image, float price,
			Date publishDate, Date lastUpdated) {
		this.title = title;
		this.author = author;
		this.description = description;
		this.isbn = isbn;
		this.image = image;
		this.price = price;
		this.publishDate = publishDate;
		this.lastUpdated = lastUpdated;
		this.category = category;
	}

	public Book(Category category,String title, String author, String description, String isbn, byte[] image, float price,
			Date publishDate, Date lastUpdated, String categoryId, Set<Review> reviews, Set<OrderDetail> orderDetails) {
		this.title = title;
		this.author = author;
		this.description = description;
		this.isbn = isbn;
		this.image = image;
		this.price = price;
		this.publishDate = publishDate;
		this.lastUpdated = lastUpdated;
		this.reviews = reviews;
		this.orderDetails = orderDetails;
		this.category = category;
	}

	public Book(Integer bookId2) {
		
		this.bookId=bookId2;
	}



	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "book_id", unique = true, nullable = false)
	public Integer getBookId() {
		return this.bookId;
	}

	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}

	@Column(name = "title", unique = true, nullable = false, length = 128)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "author", nullable = false, length = 64)
	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	@Column(name = "description", nullable = false, length = 16777215)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "isbn", nullable = false, length = 15)
	public String getIsbn() {
		return this.isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	@Column(name = "image", nullable = false)
	public byte[] getImage() {
		return this.image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	@Column(name = "price", nullable = false, precision = 12, scale = 0)
	public float getPrice() {
		return this.price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "publish_date", nullable = false, length = 10)
	public Date getPublishDate() {
		return this.publishDate;
	}

	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "last_updated", nullable = false, length = 19)
	public Date getLastUpdated() {
		return this.lastUpdated;
	}

	public void setLastUpdated(Date lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id", nullable=false)
	public Category getCategory() {
		return this.category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "book")
	public Set<Review> getReviews() {
		return this.reviews;
	}

	public void setReviews(Set<Review> reviews) {
		this.reviews = reviews;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "book")
	public Set<OrderDetail> getOrderDetails() {
		return this.orderDetails;
	}

	public void setOrderDetails(Set<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
	
	@Transient
	public String getBase64Image() {
		this.base64Image= Base64.getEncoder().encodeToString(this.image);
		return this.base64Image;
	}
	
	@Transient
	public void setBase64Image(String base64Image) {
		this.base64Image=base64Image;
		
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bookId == null) ? 0 : bookId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		if (bookId == null) {
			if (other.bookId != null)
				return false;
		} else if (!bookId.equals(other.bookId))
			return false;
		return true;
	}
	
	
	

}
