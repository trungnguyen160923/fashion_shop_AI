package fashion_shop.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import fashion_shop.DAO.orderDAO;
import fashion_shop.DAO.productDAO;
import fashion_shop.bean.CartItem;
import fashion_shop.entity.Cart;
import fashion_shop.entity.Account;
import fashion_shop.entity.Order;
import fashion_shop.entity.OrderDetail;
import fashion_shop.entity.Product;
import fashion_shop.entity.SizeAndColor;
import fashion_shop.service.DBService;

@Transactional
@Controller
@RequestMapping("/cart/")
public class CartController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	productDAO productDAO;
	
	@Autowired
	orderDAO orderDAO;

	List<Cart> cartItems = new ArrayList<Cart>();

	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String addCart(@ModelAttribute("cartItem") CartItem cartItem) {

		if (cartItem != null) {						
			Product product = new Product();
			product.setIdProduct(cartItem.getIdProduct());
			product.setName(cartItem.getName());
			//product.setColor(cartItem.getColor());
			//product.setSize(cartItem.getSize());
			product.setPrice(cartItem.getPrice());
			//product.setQuantity(cartItem.getQuantity());
			product.setImage(cartItem.getImage());

			Cart cart = new Cart();
			//cart.setPhone(cartItem.getUserPhone());
			cart.setProduct(product);

			DBService db = new DBService(factory);
			Cart existedCartItem = db.getCartItemByPhoneAndProduct(cartItem.getUserPhone(), cartItem.getIdProduct());

			if (existedCartItem != null) {
				cart.setId(existedCartItem.getId());
				cart.setQuantity(existedCartItem.getQuantity() + cartItem.getQuantity());
				db.updateCart(cart);
			} else {				
				cart.setQuantity(cartItem.getQuantity());				
				db.insertCart(cart);
			}
		}

		return "redirect:/home/detail/" + cartItem.getIdProduct() + ".htm";
	}
	
	@RequestMapping(value = "addToCart/{productID}", method = RequestMethod.POST)
	public String addToCart(@ModelAttribute("cartItem") CartItem cartItem,
			HttpSession httpSession,
			@PathVariable("productID") String productID
			, HttpServletRequest req) {
		HttpSession s = req.getSession();
		Account account = (Account) s.getAttribute("acc");
		
		if (account == null) {
			s.setAttribute("fromPage", "addToCart/"+productID);			
			return "redirect:/user/login.htm";
		}
		
		if (cartItem != null) {						
			Product product = productDAO.getProduct(productID);
			
			SizeAndColor sizeAndColor = new SizeAndColor();
			SizeAndColor.PK pk = new SizeAndColor.PK();
			pk.setSize(cartItem.getSize()); // Gán kích thước
			pk.setColor(cartItem.getColor()); // Gán màu sắc

			sizeAndColor.setPk(pk);

			// Gán các thuộc tính khác
			sizeAndColor.setQuantity(cartItem.getQuantity());
			
			ArrayList<SizeAndColor> sizeAndColors = new ArrayList<SizeAndColor>();
			sizeAndColors.add(sizeAndColor);
			
			product.setSizeAndColors(sizeAndColors);

			Cart cart = new Cart();
			cart.setProduct(product);
			cart.setQuantity(sizeAndColor.getQuantity());
			cart.setUsername(account.getUser_name());

			DBService db = new DBService(factory);
			Cart existedCartItem = db.getCartItemByUsernameAndProduct(account.getUser_name(), productID);
			
			if (existedCartItem != null) {
				cart.setId(existedCartItem.getId());
				cart.setQuantity(existedCartItem.getQuantity() + sizeAndColor.getQuantity());
				db.updateCart(cart);
			} else {				
				db.insertCart(cart);
			}
			List<Cart> cartItems = db.getCartItemsByUsername(account.getUser_name());
			httpSession.setAttribute("carts", cartItems);
		}

		return "redirect:/home/detail/" + productID + ".htm";
	}
	

	@RequestMapping("checkout")
	public String checkout(ModelMap model, HttpServletRequest req) {
		HttpSession s = req.getSession();
		Account account = (Account) s.getAttribute("acc");

		if (account == null) {
			s.setAttribute("fromPage", "cart");			
			return "redirect:/user/login.htm";
		}

		DBService db = new DBService(factory);		
//		List<Cart> cartItems = db.getCartItemsByPhone(account.getPhone());
		List<Cart> cartItems = db.getCartItemsByUsername(account.getUser_name());	
		if (cartItems.size() == 0) {
			model.addAttribute("emptyCart", 1);	
			return "cart/checkOut";
		}

		List<Product> products = new ArrayList<Product>();

		for (Cart item : cartItems) {
			Product product = db.getProductById(item.getProduct().getIdProduct());
			if (product != null) {
				products.add(product);
			}
		}

		model.addAttribute("products", products);
		model.addAttribute("carts", cartItems);
		return "cart/checkOut";
	}
	
	@RequestMapping(value="orderComplete", method=RequestMethod.GET)
	public String orderComplete(@ModelAttribute("order") Order order,
	                            @ModelAttribute("shippingMethod") String shippingMethod,
	                            @ModelAttribute("paymentMethod") String paymentMethod,
	                            @ModelAttribute("acc") Account account,
	                            @ModelAttribute("shippingValue") Double shippingValue,
	                            ModelMap model) {
	    // Các giá trị từ RedirectAttributes đã được thêm tự động vào model
	    model.addAttribute("order", order);
	    model.addAttribute("shippingMethod", shippingMethod);
	    model.addAttribute("paymentMethod", paymentMethod);
	    model.addAttribute("acc", account);
	    model.addAttribute("shippingValue", shippingValue);
	    return "cart/orderComplete";
	}

	@RequestMapping(value = "orderComplete", method = RequestMethod.POST)
	public String orderCompletePOST(
	        @RequestParam(value = "selectedProducts", required = false) List<Integer> selectedProducts,
	        @RequestParam(value = "names", required = false) List<String> namePros,
	        @RequestParam(value = "quantities", required = false) List<Integer> quantities,
	        @RequestParam(value = "prices", required = false) List<Float> prices,
	        @RequestParam(value = "totalValue", required = false) Double totalValue,
	        @RequestParam(value = "ship", required = false) Integer shipCost,
	        @RequestParam(value = "payment", required = false) String paymentMethod,
	        RedirectAttributes redirectAttributes,
	        HttpServletRequest req) {

	    HttpSession s = req.getSession();
	    Account account = (Account) s.getAttribute("acc");

	    if (account == null) {
	        s.setAttribute("fromPage", "cart");
	        return "redirect:/user/login.htm";
	    }

	    Order order = new Order();
	    order.setId_order(10);
	    order.setCusUsername(account.getUser_name());
	    order.setPhone(account.getPhone());
	    order.setCusAddress(account.getAddress());
	    order.setCusEmail(account.getAddress());
	    order.setOrder_date(new java.sql.Date(new Date().getTime()));
	    order.setTotalPrice(totalValue);
	    order.setStatus(-1); // Trạng thái chờ xác nhận

	    // Order Detail
	    List<OrderDetail> orderDetails = new ArrayList<>();
	    if (selectedProducts != null) {
	        for (int i = 0; i < selectedProducts.size(); i++) {
	            OrderDetail orderDetail = new OrderDetail();
	            
	            // Tạo đối tượng Product
	            Product product = new Product();
	            product.setIdProduct(String.valueOf(selectedProducts.get(i)));
	            product.setName(namePros.get(i));
	            
	            // Gán thông tin vào OrderDetail
	            orderDetail.setProd(product);
	            orderDetail.setQuantity(quantities.get(i));
	            orderDetail.setPrice(prices.get(i));
	            
	            // Gán Order vào OrderDetail
	            orderDetail.setOrder(order);

	            // Thêm OrderDetail vào danh sách
	            orderDetails.add(orderDetail);
	        }
	    }
	    order.setDetails(orderDetails);

	    // lưu vào CSDL
	    int status = orderDAO.insertOrder(order);
	    if (status == 1) {
	        String shipStr;
	        if (shipCost == 0) {
	            shipStr = "Free Shipping ($0)";
	        } else if (shipCost == 1) {
	            shipStr = "Flat rate ($1)";
	        } else if (shipCost == 3) {
	            shipStr = "Local pickup ($3)";
	        } else {
	            shipStr = "Unknown shipping method";
	        }

	        // Truyền dữ liệu qua RedirectAttributes
	        redirectAttributes.addFlashAttribute("shippingValue", Double.valueOf(shipCost));
	        redirectAttributes.addFlashAttribute("shippingMethod", shipStr);
	        redirectAttributes.addFlashAttribute("paymentMethod", paymentMethod);
	        redirectAttributes.addFlashAttribute("order", order);
	        redirectAttributes.addFlashAttribute("acc", account);

	        return "redirect:/cart/orderComplete.htm";
	    } else {
	        return "redirect:/cart/checkout.htm";
	    }
	}


}
