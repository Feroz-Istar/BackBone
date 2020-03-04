import DBUtils.DBUtils;

public class InsertTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String sql = " INSERT INTO public.myuser (name) VALUES ('fff')";
		
		DBUtils.getInstance().insertIntoDB(sql);
		
		//.execut(Thread.currentThread().getStackTrace(), sql);
	}

}
