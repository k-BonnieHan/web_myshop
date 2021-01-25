package kr.shop.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.shop.order.OrderBean;
import kr.shop.order.OrderDto;

public class ProductMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public ProductMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("ProductMgr err : " + e);
		}
	}
	
	public ArrayList<ProductDto> getProductAll(){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "select * from shop_product order by no desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setNo(rs.getString("no"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getString("price"));
				dto.setDetail(rs.getString("detail"));
				dto.setSdate(rs.getString("sdate"));
				dto.setStock(rs.getString("stock"));
				dto.setImage(rs.getString("image"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	public boolean insertProduct(HttpServletRequest request) {
		boolean b = false;
		try {
			//업로드할 이미지 경로(절대경로)  cos.jar
			String uploadDir = "C:/work/wsou/web_myshop/WebContent/upload";
			
			MultipartRequest multi = new MultipartRequest(request, 
						uploadDir, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
			
			conn = ds.getConnection();
			String sql = "insert into shop_product(name,price,detail,sdate,stock,image) values(?,?,?,now(),?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, multi.getParameter("price"));
			pstmt.setString(3, multi.getParameter("detail"));
			pstmt.setString(4, multi.getParameter("stock"));
			if(multi.getFilesystemName("image") == null) {
				pstmt.setString(5, "ready.gif");  //상품 등록 시 이미지를 선택하지 않은 경우
			}else {
				pstmt.setString(5, multi.getFilesystemName("image"));
			}
			
			if(pstmt.executeUpdate() > 0) b = true;
		} catch (Exception e) {
			System.out.println("insertProduct err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	
	public ProductDto getProduct(String no) {
		ProductDto dto = null;
		try {
			conn = ds.getConnection();
			String sql = "select * from shop_product where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ProductDto();
				dto.setNo(rs.getString("no"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getString("price"));
				dto.setDetail(rs.getString("detail"));
				dto.setSdate(rs.getString("sdate"));
				dto.setStock(rs.getString("stock"));
				dto.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			System.out.println("getProduct err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return dto;
	}
	
	public boolean updateProduct(HttpServletRequest request) {
		boolean b = false;
		try {
			//업로드할 이미지 경로(절대경로)  cos.jar
			String uploadDir = "C:/work/wsou/web_myshop/WebContent/upload";
			
			MultipartRequest multi = new MultipartRequest(request, 
						uploadDir, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
			
			conn = ds.getConnection();
			
			if(multi.getFilesystemName("image") == null) {
				String sql = "update shop_product set name=?,price=?,detail=?,stock=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("price"));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setString(4, multi.getParameter("stock"));
				pstmt.setString(5, multi.getParameter("no"));
			}else {
				String sql = "update shop_product set name=?,price=?,detail=?,stock=?,image=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("price"));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setString(4, multi.getParameter("stock"));
				pstmt.setString(5, multi.getFilesystemName("image"));
				pstmt.setString(6, multi.getParameter("no"));
			}
			
			if(pstmt.executeUpdate() > 0) b = true;
		} catch (Exception e) {
			System.out.println("updateProduct err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	
	public boolean deleteProduct(String no) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "delete from shop_product where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			
			if(pstmt.executeUpdate() > 0) b = true;
		} catch (Exception e) {
			System.out.println("deleteProduct err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	
	//고객이 상품 주문시 주문수량만큼 재고수량에서 빼기
	public void reduceProduct(OrderBean order) {
		try {
			conn = ds.getConnection();
			String sql="update stock_product set stocks=(stocks -?) where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order.getQuantity());
			pstmt.setString(2, order.getProduct_no());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("reduceProduct err: " + e);
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
}




