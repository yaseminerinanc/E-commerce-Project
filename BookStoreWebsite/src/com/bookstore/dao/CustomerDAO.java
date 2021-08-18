package com.bookstore.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bookstore.entity.Category;
import com.bookstore.entity.Customer;

public class CustomerDAO extends JpaDAO<Customer>  implements GenericDAO<Customer> {

	
	@Override
	public Customer create(Customer customer) {
			
		customer.setRegisterDate(new Date());
		return super.create(customer);
	}

	@Override
	public Customer get(Object id) {
	
		return super.find(Customer.class, id);
	}

	@Override
	public void delete(Object id) {
		super.delete(Customer.class, id);
	}

	@Override
	public List<Customer> listAll() {
		
		return super.findWithNamedQuery("Customer.findAll");
	}
	
	
	@Override
	public Customer update(Customer customer) {
		
		customer.setRegisterDate(new Date());
		return super.update(customer);
	}

	@Override
	public long count() {
		
		return 0;
	}
	
	
	public Customer findByEmail (String email) {
		
		List<Customer> result= super.findWithNamedQuery("Customer.findByEmail", "email", email);
		
		if(!result.isEmpty()) {
			
			return result.get(0);
		}
		
		return null;
	}

	public Customer checkedLogin(String email, String password) {
		
		Map<String, Object> parameters = new HashMap<> ();
		parameters.put("email", email);
		parameters.put("pass", password);
		
		List<Customer> result= super.findWithNamedQuery("Customer.checkLogin", parameters);
		
		if(!result.isEmpty()){
			
			return result.get(0);
		}
		return null;
		
	}

}
