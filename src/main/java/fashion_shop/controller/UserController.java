package fashion_shop.controller;

import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import fashion_shop.entity.Account;
import fashion_shop.entity.Cart;
import fashion_shop.entity.Order;

import fashion_shop.entity.Role;
import fashion_shop.service.DBService;
import fashion_shop.DAO.accountDAO;
import fashion_shop.DAO.orderDAO;

@Transactional
@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
	SessionFactory factory;

	@Autowired
	accountDAO accountDAO;
	
	@Autowired
	ServletContext context;
	
	@Autowired
	orderDAO orderDAO;
	
	// Register GET
		@RequestMapping(value = "register", method = RequestMethod.GET)
		public String register(ModelMap model) {
			model.addAttribute("user", new Account());
			return "user/register";
		}
	
	// Register POST
	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String register(ModelMap model, @ModelAttribute("user") Account user, BindingResult errors
			,@RequestParam("passwordagain") String passwordagain,
			@RequestParam("photo")MultipartFile photo) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		List<Account> l = accountDAO.getLUser();
		if (user.getUser_name().trim().length() == 0) {
			errors.rejectValue("user_name", "user", "Yêu cầu nhập không để trống tài khoản");
		} else {
			for (Account a : l) {
				if (a.getUser_name().equalsIgnoreCase(user.getUser_name())) {
					errors.rejectValue("user_name", "user", "Tên tài khoản đã tồn tại!");
				}
			}
		}
		
//		if (photo.isEmpty()) {
//			errors.rejectValue("photo", "Không để file trống!");
//		}
//		else {
		if (!photo.isEmpty()) {
			try {
				String photoPath = context.getRealPath("/files/" + photo.getOriginalFilename());
				photo.transferTo(new File(photoPath));
				user.setImage(photoPath);
//				model.addAttribute("photo", photoPath);
//				System.out.println(photo.getOriginalFilename());
			}
			catch (Exception e) {
				// TODO: handle exception
				errors.rejectValue("photo", "Lỗi lưu file!");
			}
		}
		if (user.getBirthday() == null) {
	        errors.rejectValue("birthday", "user", "Ngày sinh không được để trống.");
	    } else {
	        Calendar cal = Calendar.getInstance();
	        cal.setTime(new Date()); 
	        int currentYear = cal.get(Calendar.YEAR);

	        cal.setTime(user.getBirthday());
	        int birthYear = cal.get(Calendar.YEAR);

	        int age = currentYear - birthYear;

	        if (age < 16) {
	            errors.rejectValue("birthday", "user", "Yêu cầu người dùng phải trên 16 tuổi.");
	        }
	    }
	    
		if (user.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "user", "Yêu cầu không để trống mật khẩu");
		} else {
			if (!user.getPassword().matches("^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$")) {
				errors.rejectValue("password", "user",
						"Nhập trên 8 kí tự trong đó có chữ hoa, thường và kí tự đặc biệt.");
			}
		}
		if (user.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "user", "Yêu cầu không để trống mật khẩu");
		} else {
			if (!user.getPassword().matches("^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$")) {
				errors.rejectValue("password", "user",
						"Nhập trên 8 kí tự trong đó có chữ hoa, thường và kí tự đặc biệt.");
			}
		}

		if (user.getFullname().trim().length() == 0) {
		    errors.rejectValue("fullname", "user", "Yêu cầu không để trống họ tên");
		} else if (user.getFullname().matches(".*\\d.*")) {
		    errors.rejectValue("fullname", "user", "Họ tên không được có chữ số");
		}

		String regex = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$";
		Pattern pattern = Pattern.compile(regex);
		if (user.getEmail().trim().length() == 0) {
			errors.rejectValue("email", "user", "Email không được bỏ trống.");
		} else {
			Matcher matcher = pattern.matcher(user.getEmail().trim());
			if (!matcher.matches()) {
				errors.rejectValue("email", "user", "Email không đúng định dạng");
			}
		}
		
		// String regexNumber = "/^0[0-9]{8}$/";
		String regexNumber = "0\\d{9}";
		Pattern patternNumber = Pattern.compile(regexNumber);

		if (user.getPhone().trim().length() == 0) {
			errors.rejectValue("phone", "user", "Số điện thoại không được bỏ trống.");
		} else {
			Matcher matcher1 = patternNumber.matcher(user.getPhone().trim());
			if (!matcher1.matches())
				errors.rejectValue("phone", "user", "Yêu cầu nhập đúng định dạng số điện thoại");
		}
		
		if (user.getAddress().trim().length() == 0) {
			errors.rejectValue("address", "user", "địa chỉ không được bỏ trống.");
		}

		if (passwordagain.trim().length() == 0) {
			model.addAttribute("passwordagain", "Vui lòng không để trống mật khẩu");
			return "user/register";
		}
		if (!passwordagain.equals(user.getPassword())) {
			model.addAttribute("passwordagain", "Vui lòng nhập trùng với mật khẩu");
			return "user/register";
		}
		Role r = (Role) session.get(Role.class, 2);
		user.setrole(r);
		System.out.print( user);
		try {
			if (errors.hasErrors()) {
				model.addAttribute("messageRegister", "Đăng ký thất bại");
			} else {
				session.save(user);
				t.commit();
				model.addAttribute("messageRegister", "Đăng ký thành công!");
			}
		} catch (Exception e) {
			t.rollback();
			System.out.println( "////////////////");
			System.out.print( e);
			model.addAttribute("messageRegister", "Đăng ký thất bại!");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return "user/register";
	}

	
	
	
	// Login
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(ModelMap model) {
		model.addAttribute("user", new Account());
		return "user/login";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(ModelMap model, HttpSession httpSession, @ModelAttribute("user") Account user,
			BindingResult errors) throws InterruptedException {
		Account temp = new Account();
		Account acc = new Account();
		DBService db = new DBService(factory);
		List<Account> listUser = accountDAO.getLUser();
		
		for (int i = 0; i < listUser.size(); i++) {
			if (listUser.get(i).getUser_name().equals(user.getUser_name())) {
				acc = new Account();
				acc = listUser.get(i);
				temp = listUser.get(i);
				break;
			}
		}

		if (user.getUser_name().trim().length() == 0) {
			errors.rejectValue("user_name", "user", "Yêu cầu không để trống tài khoản");
		}

		if (user.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "user", "Yêu cầu không để trống mật khẩu");
		}
		
//		test tên tài khoản đã tồn tại trong db chưa nhờ vào hashcode
		
		if (acc.getUser_name() != temp.getUser_name()) {
			model.addAttribute("message", "Tên tài khoản hoặc mật khẩu không đúng!");
		} else if (user.getPassword().equals(acc.getPassword())) {
			Thread.sleep(1000);
			// chưa vào được admin (getrole đang là role)
			boolean isAdmin = (boolean) acc.getrole().getIdRole().equals((Object) 1);
			httpSession.setAttribute("acc", acc);
			if (isAdmin == true) {
				return "redirect:/admin/adminHome.htm";
			} else {
				List<Cart> cartItems = db.getCartItemsByUsername(acc.getUser_name());
				String fromPage = (String) httpSession.getAttribute("fromPage");
				System.out.println(cartItems);
				httpSession.setAttribute("carts", cartItems);
				// session để lưu user là customer và quay lại home
				model.addAttribute("session", httpSession.getAttribute("acc"));
				if (fromPage == "cart") {
					return "redirect:/cart/checkout.htm";
				} else {					
					return "redirect:/home/index.htm";
				}
			}
		} else
			model.addAttribute("message", "Tên tài khoản hoặc mật khẩu không đúng!");
		return "user/login";
	}

	@Autowired
	JavaMailSender mailer;

	// Quên mật khẩu
	@RequestMapping(value = "forgotpassword", method = RequestMethod.GET)
	public String forgotpassword(ModelMap model) {
		model.addAttribute("user", new Account());
		return "user/forgotPassword";
	}

	// Gửi mail để lấy lại mật khẩu
	@RequestMapping(value = "forgotpassword", method = RequestMethod.POST)
	public String forgotpassword(ModelMap model, @ModelAttribute("user") Account user, BindingResult errors,
			@RequestParam("user_name") String user_name) {

		if (user.getUser_name().trim().length() == 0) {
			errors.rejectValue("user_name", "user", "Yêu cầu không để trống tài khoản");
			return "user/forgotPassword";
		}
		
		Account acc = new Account();
		List<Account> listUser = accountDAO.getLUser();
		for (int i = 0; i < listUser.size(); i++) {
			if (listUser.get(i).getUser_name().equals(user.getUser_name())) {
				acc = listUser.get(i);
				break;
			}
		}
		
		if (acc.getUser_name() == null) {
			errors.rejectValue("user_name", "user", "Tên tài khoản không đúng!");
			return "user/forgotPassword";
		}

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		Random rand = new Random();
		int rand_int1 = rand.nextInt(100000);

		String newPassword = Integer.toString(rand_int1);
		try {
			acc.setPassword(newPassword);
			String from = "n21dccn081@student.ptithcm.edu.vn";
			String to = acc.getEmail();
			String body = "Đây là mật khẩu mới của bạn: " + newPassword;
			String subject = "Quên mật khẩu";
			try {
				MimeMessage mail= mailer.createMimeMessage();
				MimeMessageHelper heper= new MimeMessageHelper(mail,true,"UTF-8");
				heper.setFrom(from, from);
				heper.setTo(to);
				heper.setReplyTo(from);
				heper.setSubject(subject);
				heper.setText(body,true);
				mailer.send(mail);
			}catch(Exception ex) {
				throw new RuntimeException(ex);
			}
           model.addAttribute("message", "Gửi email thành công !");
           t.commit();
		} catch (Exception e) {
			model.addAttribute("message", "Gửi email thất bại !");
			t.rollback();
			throw new RuntimeException(e);
		} finally {
			session.close();
		}
		return "user/forgotPassword";
	}

	// Đổi mật khẩu
	@RequestMapping(value = "changepassword", method = RequestMethod.GET)
	public String changepassword() {
		return "user/changePassword";
	}
	
	@RequestMapping(value = { "changepassword" },method = RequestMethod.POST)
	public String change_password(ModelMap model ,HttpServletRequest request,
			@RequestParam("oldPassword") String oldPassword, @RequestParam("newPassword") String newPassword,
			@RequestParam("newPasswordAgain") String newPasswordAgain) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		HttpSession httpSession = request.getSession();
		Account user = (Account) httpSession.getAttribute("acc");


		if (!user.getPassword().equals(oldPassword)) {
			model.addAttribute("message1", "Mật khẩu cũ không chính xác!");
		}
		if (oldPassword.length() == 0) {
			model.addAttribute("message1", "Mật khẩu không được để trống");			
		}
		
		if (newPassword.length() == 0) {
			model.addAttribute("message2", "Mật khẩu không được để trống");
		}

		if (newPasswordAgain.length() == 0) {
			model.addAttribute("message3", "Mật khẩu không được để trống");
		}
//				errors.rejectValue("newPasswordAgain", "user", "Mật khẩu không được để trống");
		else if (!newPassword.matches("^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$")
				|| !newPasswordAgain.matches("^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$"))
			model.addAttribute("message", "Mật khẩu mới cần trên 8 kí tự trong đó có chữ Hoa thường và ký tự đặc biệt");
		else if (!newPassword.equals(newPasswordAgain)) {
			System.out.println("2");
			model.addAttribute("message", "Mật khẩu mới không trùng nhau !");
		} else if (newPassword.equals(oldPassword)) {
			System.out.println("3");
			model.addAttribute("message", "Mật khẩu mới không được trùng với mật khẩu cũ !");
		}
		
		else {
			try
			{
				user.setPassword(newPassword);
				session.update(user);
				t.commit();
				model.addAttribute("message", "Thay đổi mật khẩu thành công!");
				httpSession.setAttribute("user", user);
			} catch (Exception e) {
				model.addAttribute("message", "Thay đổi mật khẩu thất bại!");
				t.rollback();
			} finally {
				session.close();
			}
		}
		return "user/changePassword";
	}
	
	//View của user home
	@RequestMapping(value = { "userHome" }, method = RequestMethod.GET)
	public String viewUserHome(ModelMap model, HttpServletRequest request) {
		HttpSession httpSession = request.getSession();
		Account user = (Account) httpSession.getAttribute("user");
		httpSession.setAttribute("user", user);
		model.addAttribute("user", user);
		return "user/userHome";
	}
	
	@RequestMapping(value="logout") 
	public String logOut(HttpServletRequest req) {
		HttpSession s = req.getSession();
		s.removeAttribute("acc");
		s.removeAttribute("carts");
		return "redirect:/home/index.htm";
	}
	
	//Change info
	@RequestMapping(value = { "changeInfor" }, method = RequestMethod.GET)
	public String changeInfo(ModelMap model, HttpServletRequest request) {
		HttpSession httpSession = request.getSession();
		Account user = (Account) httpSession.getAttribute("user");
		httpSession.setAttribute("user", user);
		model.addAttribute("user", user);
		return "user/changeInfo";
	}
	
	@RequestMapping(value = { "changeInfor" }, method = RequestMethod.POST)
	public String changeInfo(
	        ModelMap model,
	        @RequestParam("username") String username,
	        @RequestParam("name") String name,
	        @RequestParam("birthday") @DateTimeFormat(pattern = "yyyy-MM-dd") Date birthday,
	        @RequestParam("phone") String phone,
	        @RequestParam("address") String address,
	        @RequestParam("gender") boolean gender,
	        HttpSession session) {

	    boolean hasErrors = false;

	    // Kiểm tra họ tên
	    if (name == null || name.trim().isEmpty()) {
	        model.addAttribute("nameError", "Họ tên không được để trống.");
	        hasErrors = true;
	    } else if (name.matches(".*\\d.*")) {
	        model.addAttribute("nameError", "Họ tên không được chứa chữ số.");
	        hasErrors = true;
	    }

	    // Kiểm tra tuổi
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    int currentYear = cal.get(Calendar.YEAR);

	    cal.setTime(birthday);
	    int birthYear = cal.get(Calendar.YEAR);
	    int age = currentYear - birthYear;

	    if (age < 16) {
	        model.addAttribute("birthdayError", "Người dùng phải trên 16 tuổi.");
	        hasErrors = true;
	    }

	    // Kiểm tra số điện thoại
	    String regexNumber = "0\\d{9}";
	    Pattern patternNumber = Pattern.compile(regexNumber);

	    if (phone == null || phone.trim().isEmpty()) {
	        model.addAttribute("phoneError", "Số điện thoại không được để trống.");
	        hasErrors = true;
	    } else if (!patternNumber.matcher(phone).matches()) {
	        model.addAttribute("phoneError", "Số điện thoại không hợp lệ.");
	        hasErrors = true;
	    }

	    // Kiểm tra địa chỉ
	    if (address == null || address.trim().isEmpty()) {
	        model.addAttribute("addressError", "Địa chỉ không được để trống.");
	        hasErrors = true;
	    }

	    // Nếu có lỗi, quay lại form
	    if (hasErrors) {
	        model.addAttribute("username", username);
	        model.addAttribute("name", name);
	        model.addAttribute("birthday", birthday);
	        model.addAttribute("phone", phone);
	        model.addAttribute("address", address);
	        model.addAttribute("gender", gender);
	        return "user/changeInfo"; 
	    }

	    // Nếu không có lỗi, cập nhật thông tin
	    accountDAO.updateUser(username, name, birthday, phone, address, gender);
	    System.out.println(username + " " +  name + " " + birthday + " " + phone+ " " +  address+ " " + gender);
	    Account acc = accountDAO.getUser(username);
	    session.setAttribute("acc", acc);

	    return "redirect:/user/userHome.htm";
	}
	@RequestMapping("purchaseOrder")	
	public String purchaseOrder(ModelMap model,
			HttpServletRequest req,
			@RequestParam(value = "status", required = false) Integer status) {
		HttpSession s = req.getSession();
		Account account = (Account) s.getAttribute("acc");
		
		if (account == null) {
			s.setAttribute("fromPage", "home/purchaseOrder.htm");			
			return "redirect:/user/login.htm";
		}
		if (status == null) {
	        status = 0; // Mặc định "Chờ xác nhận"
	    }

	    // Lấy danh sách đơn hàng theo trạng thái
	    List<Order> listOrders = orderDAO.getOrdersByStatusAndUsername(status, account.getUser_name());

	    model.addAttribute("orders", listOrders);
	    System.out.println(listOrders);
	    model.addAttribute("currentStatus", status);
		return "user/historyOrder";
	}
	
	@RequestMapping(value = { "purchaseOrder/{orderID}" }, method = RequestMethod.GET)
	public String adminBillInfo(ModelMap model, @PathVariable("orderID") Integer orderID) {
		Order od = orderDAO.getOrderById(orderID);
		Account acc = accountDAO.getUser(od.getCusUsername());
		model.addAttribute("order", od);
		model.addAttribute("accUser", acc);
		return "user/detailHistoryOrder";
	}
	@RequestMapping(value = "handleOrder", method = RequestMethod.POST)
	public String approveOrder(@RequestParam("orderId") int orderId, @RequestParam("action") String action) {
	    Order order = orderDAO.getOrderById(orderId);
	    
	    if ("cancelOrder".equals(action)) {
	        order.setStatus(-1);  // Trạng thái chuẩn bị
	    }
	    return "redirect:/user/purchaseOrder.htm";
	}
}
