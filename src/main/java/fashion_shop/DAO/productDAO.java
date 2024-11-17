package fashion_shop.DAO;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Environment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;

import fashion_shop.entity.Product;
import fashion_shop.entity.ProductCategory;
import fashion_shop.entity.Rating;
import fashion_shop.entity.SizeAndColor;
import fashion_shop.entity.SizeAndColor.PK;
import fashion_shop.model.APIResult;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@Transactional
@Repository
public class productDAO {
	@Autowired
	SessionFactory factory;
	
	
	//Get List Product includes Size, Color and Quantity 
	//( mix between 2 Entity: Product & SizeAndColor)
	public List<Object[]> getLMixProd() {
		Session session = factory.getCurrentSession();
		String hql = "select P.idProduct, P.ProdCategory, P.name, P.price, P.image, S.pk.color, S.pk.size, S.pk.quantity  " +
				" from Product P, SizeAndColor S "
				+ "where P.idProduct = S.pk.productID";
		Query query = session.createQuery(hql);
		List<Object[]> listProd = query.list();
		return listProd;
	}
	
	// Get List Product DOES NOT includes Size, Color and Quantity 
	//( just Entity: Product)
	public List<Product> getLProd() {
		Session session = factory.getCurrentSession();
		String hql = "from Product";
		Query query = session.createQuery(hql);
		List<Product> listProd = query.list();
		return listProd;
	} 
	
	public List<Product> getProductsByCluster(String id, String sessionId) throws IOException, InterruptedException {
	    String url = "http://localhost:8000/get-history-cluster/" + sessionId;
	    OkHttpClient client = new OkHttpClient();
	    Request request = new Request.Builder()
	            .url(url)
	            .build();

	    // Gửi request và nhận phản hồi
	    Response response = client.newCall(request).execute();

	    // Kiểm tra mã trạng thái HTTP của phản hồi
	    if (response.code() == 404) {
	        // API trả về mã 404 (không tìm thấy tài nguyên)
	        System.out.println("API returned 404 for URL: " + url);
	        return new ArrayList<>();  // Trả về danh sách rỗng nếu không tìm thấy dữ liệu
	    }

	    // Kiểm tra các mã lỗi khác (500, 400, v.v.) và xử lý tương ứng
	    if (!response.isSuccessful()) {
	        throw new IOException("Unexpected response code: " + response.code() + " - " + response.message() + " for URL: " + url);
	    }

	    // Đọc dữ liệu JSON từ phản hồi
	    String responseBody = response.body().string();

	    // Kiểm tra xem dữ liệu JSON có hợp lệ không
	    if (responseBody == null || responseBody.isEmpty()) {
	        throw new IOException("Empty response body from API");
	    }

	    // Phân tích JSON với Gson
	    APIResult result = null;
	    try {
	        Gson gson = new Gson();
	        result = gson.fromJson(responseBody, APIResult.class);
	    } catch (JsonSyntaxException e) {
	        throw new IOException("Invalid JSON response: " + responseBody, e);
	    }

	    // Kiểm tra kết quả từ API
	    if (result == null) {
	        throw new IOException("API response does not contain valid data");
	    }
	    System.out.println(result.toString());

	    // Tiếp tục với xử lý dữ liệu trong cơ sở dữ liệu
	    Session session = factory.getCurrentSession();
	    Product currentProduct = (Product) session.get(Product.class, id);
	    String hql = String.format("from Product where id != %s and productCluster = %d and ProdCategory.idCategory = %d",
	            currentProduct.getIdProduct(),
	            result.getCluster(),
	            currentProduct.getProductCategory().getIdCategory());
	    Query query = session.createQuery(hql);
	    List<Product> listProd = query.list();

	    // Sắp xếp các sản phẩm theo điểm đánh giá trung bình
	    listProd.sort(new Comparator<Product>() {
	        @Override
	        public int compare(Product o1, Product o2) {
	            Double avgRating1 = 0.0;
	            if (o1.getRatings().size() != 0) {
	                for (Rating rating : o1.getRatings()) {
	                    avgRating1 += rating.getRating();
	                }
	                avgRating1 /= o1.getRatings().size();
	            }

	            Double avgRating2 = 0.0;
	            if (o2.getRatings().size() != 0) {
	                for (Rating rating : o2.getRatings()) {
	                    avgRating2 += rating.getRating();
	                }
	                avgRating2 /= o2.getRatings().size();
	            }
	            return avgRating1.compareTo(avgRating2);
	        }
	    });

	    return listProd;
	}

	public List<Product> searchProducts(String keyword) {
	    // Mở phiên làm việc Hibernate
	    Session session = factory.getCurrentSession();
	    
	    // Sử dụng HQL để tìm kiếm sản phẩm theo tên. Chú ý sử dụng LIKE để tìm kiếm theo mẫu
	    String hql = "FROM Product P WHERE P.name LIKE :keyword";
	    
	    // Tạo truy vấn và thiết lập tham số "keyword"
	    Query query = session.createQuery(hql);
	    
	    query.setParameter("keyword", "%" + keyword + "%");  // Tìm kiếm với phần từ khóa (tức là tìm tất cả các sản phẩm có tên chứa "keyword")
	    
	    // Thực hiện truy vấn và trả về danh sách sản phẩm
	    List<Product> productList = query.list();
	    
	    return productList;
	}
	
	public List<Product> filterProducts(List<String> priceRanges) {
	    Session session = factory.getCurrentSession();
	    
	    // Xây dựng câu lệnh HQL cơ bản
	    String hql = "FROM Product P WHERE 1=1";  // Câu lệnh cơ bản không có điều kiện
	    
	    // Sử dụng StringBuilder để xây dựng câu lệnh HQL linh động
	    StringBuilder hqlBuilder = new StringBuilder(hql);
	    
	    // Thêm điều kiện lọc theo giá nếu có các khoảng giá được chọn
	    if (priceRanges != null && !priceRanges.isEmpty()) {
	        hqlBuilder.append(" AND (");
	        
	        // Lặp qua tất cả các khoảng giá được chọn và thêm điều kiện vào HQL
	        for (int i = 0; i < priceRanges.size(); i++) {
	            String range = priceRanges.get(i);
	            String[] prices = range.split("-");
	            Double minPrice = Double.parseDouble(prices[0]);
	            Double maxPrice = Double.parseDouble(prices[1]);
	            
	            // Thêm điều kiện cho mỗi khoảng giá
	            if (i > 0) {
	                hqlBuilder.append(" OR ");
	            }
	            hqlBuilder.append("P.price >= :minPrice" + i + " AND P.price <= :maxPrice" + i);
	        }
	        
	        hqlBuilder.append(")");
	    }
	    
	    // Tạo truy vấn từ câu lệnh HQL đã xây dựng
	    Query query = session.createQuery(hqlBuilder.toString());
	    
	    // Thiết lập các tham số cho các khoảng giá
	    if (priceRanges != null && !priceRanges.isEmpty()) {
	        for (int i = 0; i < priceRanges.size(); i++) {
	            String range = priceRanges.get(i);
	            String[] prices = range.split("-");
	            Double minPrice = Double.parseDouble(prices[0]);
	            Double maxPrice = Double.parseDouble(prices[1]);
	            query.setParameter("minPrice" + i, minPrice);
	            query.setParameter("maxPrice" + i, maxPrice);
	        }
	    }
	    
	    // Thực hiện truy vấn và trả về danh sách các sản phẩm thỏa mãn các điều kiện lọc
	    List<Product> filteredProducts = query.list();
	    
	    return filteredProducts;
	}


	
	public List<ProductCategory> getLCat() {
		Session session = factory.getCurrentSession();
		String hql = "from ProductCategory";
		Query query = session.createQuery(hql);
		List<ProductCategory> listCat = query.list();
		return listCat;
	}
	
	public ProductCategory getCat( int id) {
		Session session = factory.getCurrentSession();
		ProductCategory Cat = (ProductCategory) session.get(ProductCategory.class, id);
		return Cat;
	}
	
	public Product getProduct(String idProduct) {
		Session session = factory.getCurrentSession();
		Product pd = (Product) session.get(Product.class, idProduct);
		return pd;
	}
	
	
	
	public List<String> getLColor() {
		List<String> list = new ArrayList<String>();
		
		list.add("White");
		list.add("Black");
		list.add("Brown");
		list.add("Red");
		list.add("Green");
		list.add("Yellow");
		
		return list;
	}
	
	public List<String> getLBrand() {
		List<String> list = new ArrayList<String>();
		list.add("Nike");
		list.add("Louis Vuitton");
		list.add("GUCCI");
		list.add("Chanel");
		list.add("Adidas");
		list.add("Hermes");
		list.add("ZARA");
		list.add("H&M");
		list.add("Cartier");
		list.add("Dior");
		list.add("UNIQLO");
		
		return list;
	}
	
	public boolean saveProduct( Product prod) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		try {
			session.save(prod);
			t.commit();
		} catch(Exception e) {
			t.rollback();
			System.out.println("Insert product Failed");
			return false;
		} finally {
			session.close();
		}
		System.out.println("Insert product Success!");
		return true;
	}
	
	public boolean updateProduct( String prodID,
			String cat,
			String name,
			Float price,
			String image,
			String brand,
			Boolean gender,
			Integer releaseTime,
			String productType,
			String material) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		
		Product prod = (Product) session.get(Product.class, prodID);
		
		prod.setProductCategory(getCat(Integer.parseInt(cat)));
		prod.setName(name);
		prod.setPrice(price);
		prod.setImage(image);
		prod.setBrand(brand);
		prod.setGender(gender);
		prod.setReleaseTime(releaseTime);
		prod.setProductType(productType);
		prod.setMaterial(material);
		
		try {
			session.update(prod);
			t.commit();
		} catch(Exception e) {
			t.rollback();
			System.out.println("Update product Failed");
			return false;
		} finally {
			session.close();
		}
		System.out.println("Update product Success!");
		return true;
	}
	
	public boolean deleteProduct( String prodID ) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		
		Product prod = (Product) session.get(Product.class, prodID);
		
		String hql = "DELETE SizeAndColor where pk.productID = " + prodID;
		
		try {
			Query query = session.createQuery(hql);
			int line = query.executeUpdate();
			System.out.println("There's " + line + " lines executes!");
			session.delete(prod);
			t.commit();
		} catch(Exception e) {
			t.rollback();
			System.out.println("Delete product Failed");
			System.out.println(e);
			return false;
		} finally {
			session.close();
		}
		System.out.println("Delete product Success!");
		return true;
	}
	
	public List<SizeAndColor> getLCS( String prodID) {
		Session session = factory.getCurrentSession();
		String hql = "from SizeAndColor where pk.productID = " + prodID;
		Query query = session.createQuery(hql);
		List<SizeAndColor> list = query.list();
		
		return list;
	}
	
	public SizeAndColor getCS( String ID, String color, String size) {
		Session session = factory.getCurrentSession();
		
		SizeAndColor.PK pk = new SizeAndColor.PK();
		pk.setProductID(ID);
		pk.setColor(color);
		pk.setSize(size);
		
		SizeAndColor cs = (SizeAndColor) session.get(SizeAndColor.class, pk);
		
		return cs;
	}
	
	public boolean saveCS(SizeAndColor cs) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		try {
			session.save(cs);
			t.commit();
		} catch(Exception e) {
			t.rollback();
			System.out.println("Insert cs Failed");
			return false;
		} finally {
			session.close();
		}
		System.out.println("Insert cs Success!");
		return true;
	}
	
	public boolean deleteCS( String id, String color, String size) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		SizeAndColor.PK pk = new SizeAndColor.PK();
		pk.setProductID(id);
		pk.setColor(color);
		pk.setSize(size);
		
		SizeAndColor cs = (SizeAndColor) session.get(SizeAndColor.class, pk);
		
		if(cs ==null) {
			System.out.println("NULL");
		} else {
			System.out.println("NOT NULL");
		}
		
		try {
			session.delete(cs);
			t.commit();
		} catch(Exception e) {
			t.rollback();
			System.out.println("Delete cs Failed");
			System.out.println(e);
			return false;
		} finally {
			session.close();
		}
		System.out.println("Delete cs Success!");
		return true;
	}
	
	public boolean updateCS( String id, String color, String size, Integer quantity) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		SizeAndColor.PK pk = new SizeAndColor.PK();
		pk.setProductID(id);
		pk.setColor(color);
		pk.setSize(size);
		
		SizeAndColor cs = (SizeAndColor) session.get(SizeAndColor.class, pk);
		cs.setQuantity(quantity);
	 
		
		try {
			session.update(cs);
			t.commit();
		} catch(Exception e) {
			t.rollback();
			System.out.println("Update cs Failed");
			System.out.println(e);
			return false;
		} finally {
			session.close();
		}
		System.out.println("Update cs Success!");
		return true;
	}
}
