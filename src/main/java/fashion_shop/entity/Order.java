package fashion_shop.entity;

import java.sql.Date;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "Orders")
public class Order {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Integer id_order;
	
	@Column(name = "OrderDate")
	private Date order_date;
	
	@OneToMany(mappedBy = "order", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private Collection<OrderDetail> details;

	
	@Column(name="CusUsername")
	private String cusUsername;
	
	@Column(name = "Phone")
	private String phone;
	
	@Column(name = "CusAddress")
	private String cusAddress;
	
	@Column(name = "CusEmail")
	private String cusEmail;
	
	@Column(name = "TotalPrice")
	private Double totalPrice;
	
	@Column(name = "Status")
	private Integer status;
	
	public String getCusUsername() {
		return this.cusUsername;
	}
	public void setCusUsername(String cusUsername) {
		this.cusUsername = cusUsername;
	}
	
	public String getPhone() {
		return this.phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getCusAddress() {
		return this.cusAddress;
	}
	public void setCusAddress(String cusAddress) {
		this.cusAddress = cusAddress;
	}
	
	public String getCusEmail() {
		return this.cusEmail;
	}
	public void setCusEmail(String cusEmail) {
		this.cusEmail = cusEmail;
	}
	
	public Double getTotalPrice() {
		return this.totalPrice;
	}
	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	public Integer getStatus() {
		return this.status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getId_order() {
		return id_order;
	}

	public void setId_order(Integer id_order) {
		this.id_order = id_order;
	}

	public Collection<OrderDetail> getDetails() {
		return details;
	}

	public void setDetails(Collection<OrderDetail> detail) {
		this.details = detail;
	}


	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
}
	