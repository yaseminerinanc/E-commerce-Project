package com.bookstore.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.entity.Book;
import com.bookstore.entity.BookOrder;
import com.bookstore.entity.Customer;
import com.bookstore.entity.OrderDetail;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

public class PaymentServices {
	
	private static final String CLIENT_ID = "AeTgBZofcIPLH2f1RKVNAJmh5OSRnHAIqJq_s4G3pfmuFgHLiMOWLh8PB7EN7ioowtESoNZKkLcK60Dw";
	private static final String CLIENT_SECRET = "ELGqz8DyAZgDhE-hJ2o6eYNn4YJHH2UJkqiOdcU-dziYSuyYMoEHr5hGYjHUJ1M_F05VKv7If2QC_CzA";
	private String mode="sandbox";
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public PaymentServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
	}
	
	public void authorizePayment(BookOrder order) throws ServletException, IOException {
		
		//get payer info
		Payer payer =getPayerInformation(order);
		
		//get redirect URLs
		 RedirectUrls redirectUrls = getRedirectURLs();
		
		//get amount details
		 Amount amount = getAmountDetails(order);
	
		//get transaction details
		 
		 List<Transaction> transaction=getTransactionInformation(order);
		//shipping address receipient info
		//request payment, get approval link redirect to Paypals payment page
		 
		 Payment requestPayment=new Payment();
		 requestPayment.setPayer(payer);
		 requestPayment.setRedirectUrls(redirectUrls);
		 requestPayment.setTransactions(transaction);
		 
		 System.out.println("-------REQUEST PAYMENT-------");
		 System.out.println(requestPayment);
		 
		 APIContext apiContext =new APIContext(CLIENT_ID,CLIENT_SECRET,mode);
		
		 
		 try {
			 Payment authorized =requestPayment.create(apiContext);
			 System.out.println("-------AUTHORIZED PAYMENT-------");
			 System.out.println(authorized);
			 
			 String approvalURL =getApprovalURL(authorized);
			 
			 response.sendRedirect(approvalURL);
			 
		 }	catch(PayPalRESTException e ){
			 
			 e.printStackTrace();
			 throw new ServletException("Error in authorizing payment.");
		 }
	
	}
	
	private String getApprovalURL(Payment authorized) {
	
		String approvalURL=null;
		List<Links> links= authorized.getLinks();
		
		for(Links link :links) {
			
			if(link.getRel().equalsIgnoreCase("approval_url")) {
				
				approvalURL=link.getHref();
				break;
			}
		}
		
		return approvalURL;
	}

	private List<Transaction> getTransactionInformation(BookOrder order) {
		
		Transaction transaction = new Transaction();
		transaction.setDescription("Book ordered on Evergreen Books");
		Amount amount = getAmountDetails(order);
		transaction.setAmount(amount);
		
		ItemList itemList =new ItemList();
		ShippingAddress shippingAddress=getRecipientInformation(order);
		itemList.setShippingAddress(shippingAddress);
		
		List<Item> paypalItems=new ArrayList<>();
		Iterator<OrderDetail> iterator=order.getOrderDetails().iterator();
		
		while(iterator.hasNext()) {
			OrderDetail orderDetail =iterator.next();
			Book book =orderDetail.getBook();
			Integer quantity=orderDetail.getQuantity();
			
			Item paypalItem =new Item();
			paypalItem.setCurrency("USD");
			paypalItem.setName(book.getTitle())
					  .setQuantity(String.valueOf(quantity))
			          .setPrice(String.format("%.2f",book.getPrice()));
			
			paypalItems.add(paypalItem);
			
			
		}
		itemList.setItems(paypalItems);
		transaction.setItemList(itemList);
		
		List<Transaction> listTransaction =new ArrayList<>();
		listTransaction.add(transaction);
		
		return listTransaction;
		
		
	}
	
	public Payer getPayerInformation (BookOrder order) {
		
		 Payer payer = new Payer();
		 payer.setPaymentMethod("paypal");
		 
		 PayerInfo payerInfo= new PayerInfo();
		 
		 Customer customer=order.getCustomer();
		 
		 payerInfo.setFirstName(customer.getFirstname());
		 payerInfo.setLastName(customer.getLastname());
		 payerInfo.setEmail(customer.getCustomerEmail());
		 payer.setPayerInfo(payerInfo);
		 
		 return payer;
	}
	
	public RedirectUrls getRedirectURLs() {
		
		 String requestURL = request.getRequestURL().toString();
		 String requestURI= request.getRequestURI();
		 String baseURL=requestURL.replace(requestURI, "").concat(request.getContextPath());
		 
		 
		 RedirectUrls redirectUrls = new RedirectUrls();
		 String cancelUrl = baseURL.concat("/viewcart");
		 String returnUrl= baseURL.concat("/reviewpayment");
		 
		 System.out.println("CancelURL" + cancelUrl);
		 System.out.println("ReturnURL" + returnUrl);
		 
		 redirectUrls.setCancelUrl(cancelUrl);
		 redirectUrls.setReturnUrl(returnUrl);
		 
		 return redirectUrls;
		
	}
	
	private Amount getAmountDetails(BookOrder order) {
		
		 Details details=new Details();
		 details.setShipping(String.format("%.2f",order.getShippingFee()));
		 details.setTax(String.format("%.2f",order.getTax()));
		 details.setSubtotal(String.format("%.2f",order.getSubtotal()));
		 
		 Amount amount =new Amount();
		 amount.setCurrency("USD");
		 amount.setDetails(details);
		 amount.setTotal(String.format("%.2f",order.getOrderTotal()));
		 
		 return amount;
		
	}
	
	private ShippingAddress getRecipientInformation(BookOrder order) {
		
		ShippingAddress adres= new ShippingAddress();
		String recipientName= order.getRecipientName() + " " +order.getRecipientLastname();
		adres.setRecipientName(recipientName)
			  .setPhone(order.getRecipientPhone())
			  .setLine1(order.getAddressLine1())
			  .setLine2(order.getAddressLine2())
			  .setCity(order.getCity())
			  .setCountryCode(order.getCountry());
		
		return adres;
		
		
	}

	public void reviewPayment() throws ServletException {
		
		String paymentId=request.getParameter("paymentId");
		String payerId=request.getParameter("PayerID");
		
		if(paymentId==null || payerId== null) {
			
			throw new ServletException("Error in displaying payment review");
		}
		
		APIContext apiContext =new APIContext(CLIENT_ID,CLIENT_SECRET,mode);
		try {
			Payment payment= Payment.get(apiContext, paymentId);
			
			PayerInfo payerInfo=payment.getPayer().getPayerInfo();
			Transaction transaction=payment.getTransactions().get(0);
			ShippingAddress shippingAddress=transaction.getItemList().getShippingAddress();
			
			request.setAttribute("payer", payerInfo);
			request.setAttribute("recipient", shippingAddress);
			request.setAttribute("transaction", transaction);
			
			String reviewPage="frontend/reviewpayment.jsp?paymentId=" + paymentId + "&PayerID=" + payerId ;
			request.getRequestDispatcher(reviewPage).forward(request, response);
			
		} catch (PayPalRESTException | IOException e) {
			
			e.printStackTrace();
			throw new ServletException("Error in getting payment detail from PayPal");
		}
	}

	public Payment executePayment() throws PayPalRESTException {
		
		String paymentId=request.getParameter("paymentId");
		String payerId=request.getParameter("PayerID");
		
		PaymentExecution paymentExecution = new PaymentExecution();
		paymentExecution.setPayerId(payerId);
		
		Payment payment = new Payment().setId(paymentId);
		APIContext apiContext= new APIContext(CLIENT_ID,CLIENT_SECRET,mode);
		return payment.execute(apiContext, paymentExecution);
		
	}
	
}
