package fashion_shop.controller;
import java.io.IOException;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import fashion_shop.entity.Account;
import fashion_shop.entity.History;
import fashion_shop.entity.Product;
import fashion_shop.entity.ProductCategory;
import fashion_shop.entity.SatisfyProduct;
import fashion_shop.entity.SatisfyProductKey;
import fashion_shop.DAO.HistoryDAO;
import fashion_shop.DAO.productDAO;

@Transactional
@Controller
@RequestMapping(value = { "/home/", "/" })
public class HomeController {
	
	@Autowired
	SessionFactory factory;
	
	@Autowired
	productDAO productDAL;
	
	@Autowired
	HistoryDAO historyDAO;
	
	
	@RequestMapping("index")	
	public String index(ModelMap model) {
		model.addAttribute("prods", productDAL.getLProd());
		return "home/index";
	}
	
	// Show all products
	@RequestMapping(value = { "products" })
	public String view_product(ModelMap model) {
		
		List<Product> list = productDAL.getLProd();
		int size = productDAL.getLProd().size();
		List<ProductCategory> listCate = productDAL.getLCat();
		
		model.addAttribute("listCat", listCate);
		model.addAttribute("prods", list);
		model.addAttribute("prodsSize", size);
		
		model.addAttribute("catON", "false");
		
		return "home/products";
	}
	
	// Show products by cat
	@RequestMapping(value = { "products/{idCategory}" })
	public String view_product(ModelMap model, @PathVariable("idCategory") String idCategory) {
		
		List<Product> list = productDAL.getLProd();
		int size = productDAL.getLProd().size();
		List<ProductCategory> listCate = productDAL.getLCat();
		
		model.addAttribute("prods", list);
		model.addAttribute("prodsSize", size);
		model.addAttribute("listCat", listCate);
		
		model.addAttribute("catON", "true");
		model.addAttribute("catID", idCategory);
		return "home/products";
	}	
	
	
	@RequestMapping(value = { "detail/{idProduct}" },
			method = RequestMethod.GET)
	public String view_product_detail(ModelMap model, 
			@PathVariable("idProduct") String id, 
			HttpSession session) throws IOException, InterruptedException  {
		System.out.println("viewdetail1");
		
		// Get account in http session
		Account account = (Account) session.getAttribute("acc");
		String username = account == null ? "" : account.getUser_name();
		// Add new row into Evaluation table in SQL
		History history = historyDAO.saveHistory(new History(0, username, new Date(), session.getId(), id, null));
		// Pass history data row to jsp
		model.addAttribute("history", history);
		
		Product currentProduct = productDAL.getProduct(id);
		List<Product> relatedProduct = productDAL.getProductsByCluster(id, session.getId());
		model.addAttribute("product", currentProduct);
		model.addAttribute("relatedProducts", relatedProduct);
		return "home/detail";
	}
    
	 // Phương thức tìm kiếm sản phẩm
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String searchProducts(@RequestParam("query") String query, ModelMap model) {
	    // Kiểm tra xem query có giá trị không
	    System.out.println("Search query: " + query); // Debug thông qua console
	    
	    // Gọi phương thức tìm kiếm từ DAO
	    List<Product> searchResults = productDAL.searchProducts(query);
	    
	    // Kiểm tra số lượng sản phẩm tìm thấy
	    System.out.println("Number of products found: " + searchResults.size());
	    
	    // Truyền kết quả vào model
	    model.addAttribute("products", searchResults); 
	    model.addAttribute("query", query);  // Thêm từ khóa tìm kiếm vào model để hiển thị lại trong giao diện
	    
	    // Trả về trang sản phẩm
	    return "home/search";
	}

	
	@RequestMapping(value = { "detail/{idProduct}" },
			method = RequestMethod.GET, 
			params = "history")
	public String view_product_detail(ModelMap model, 
			@PathVariable("idProduct") String id, 
			HttpSession session, 
			@RequestParam("history") int historyId) throws IOException, InterruptedException  {
		System.out.println("viewdetail2");
		
		// Get account in http session
		Account account = (Account) session.getAttribute("acc");
		String username = account == null ? "" : account.getUser_name();
		// Add new row into Evaluation table in SQL
		History history = historyDAO.saveHistory(new History(0, username, new Date(), session.getId(), id, null));
		// Pass history data row to jsp
		model.addAttribute("history", history);
		
		SatisfyProduct sp = new SatisfyProduct(new SatisfyProductKey(id, historyId), historyDAO.getHistory(historyId), productDAL.getProduct(id));
		historyDAO.updateSatisfyProduct(sp);
		
		Product currentProduct = productDAL.getProduct(id);
		List<Product> relatedProduct = productDAL.getProductsByCluster(id, session.getId());
		model.addAttribute("product", currentProduct);
		model.addAttribute("relatedProducts", relatedProduct);
		
		return "home/detail";
	}
}