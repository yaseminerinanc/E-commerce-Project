import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.bookstore.entity.Users;

public class UsersTest {

	public static void main(String[] args) {
		
		Users user=new Users();
		
		user.setEmail("muge@gmail.com");
		user.setFullName("muge");
		user.setPassword("123");
		
		EntityManagerFactory entityManagerFactory =Persistence.createEntityManagerFactory("BookStoreWebsite");
		EntityManager entityManager=entityManagerFactory.createEntityManager();
		
		entityManager.getTransaction().begin();
		
		entityManager.persist(user);
		
		entityManager.getTransaction().commit();
		entityManager.close();
		entityManagerFactory.close();
		
		
		System.out.println("A user has been persisted.");

	}

}
