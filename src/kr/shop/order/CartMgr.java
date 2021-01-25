package kr.shop.order;

import java.util.Hashtable;

public class CartMgr {
	private Hashtable hCart = new Hashtable();
	
	public void addCart(OrderBean obean) {
		String product_no = obean.getProduct_no();
		int quantity = Integer.parseInt(obean.getQuantity());
		//System.out.println(product_no + " 주문수:" + quantity + " id:" + obean.getId());
		
		if(quantity > 0) {
			//동일 상품 주문인 경우에는 주문 수만 증가
			if(hCart.containsKey(product_no)) {
				OrderBean temp = (OrderBean)hCart.get(product_no);
				quantity += Integer.parseInt(temp.getQuantity());
				temp.setQuantity(Integer.toString(quantity));
				hCart.put(product_no, temp);
				System.out.println("동일 상품 주문인 경우에는 주문 수 : " + quantity);
			}else {  //고객이 새상품을 장바구니에 담기함
				hCart.put(product_no, obean);  // (key, value)
			}
		}
	}
	
	public Hashtable getCartList() {
		return hCart;
	}
	
	public void updateCart(OrderBean obean) {
		String product_no = obean.getProduct_no();
		hCart.put(product_no, obean);
	}
	
	public void deleteCart(OrderBean obean) {
		String product_no = obean.getProduct_no();
		hCart.remove(product_no);
	}
}
