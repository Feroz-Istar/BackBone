package rest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/message")

public class TestRest {
	 @GET
	    public String getMsg()
	    {
	         return "Hello World !! - Jersey 2";
	    }
}
