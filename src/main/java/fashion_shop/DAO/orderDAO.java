package fashion_shop.DAO;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import fashion_shop.entity.Order;


@Transactional
@Repository
public class orderDAO {

	@Autowired
	SessionFactory factory;
	
	public List<Order> getLOrder() {
		Session session = factory.getCurrentSession();
		String hql = "FROM  Order order by ID desc";
		Query query = session.createQuery(hql);
		List<Order> listOrder = query.list();
		return listOrder;
	}
	
	public Integer insertOrder(Order order) {
		String fnt = "insert Order: ";

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.save(order);
			t.commit();
		} catch (Exception e) {
			System.err.print(fnt + e);
			t.rollback();
			return 0;
		} finally {
			session.close();
		}

		return 1;
	}
}
