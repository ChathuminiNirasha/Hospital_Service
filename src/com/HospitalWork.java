package com;

import javax.swing.text.Document;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import com.Hospital;

@Path("/")
public class HospitalWork {
	Hospital hospitalObj = new Hospital();

	@GET
	@Path("/get-hospitals")
	@Produces(MediaType.TEXT_HTML)
	public String readItems() {
		return hospitalObj.readItems();
	}

	@POST
	@Path("/create")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_PLAIN)
	public String insertHospital(
			@FormParam("hospitalID") String hospitalID,
			@FormParam("hospitalName") String hospitalName, 
			@FormParam("hospitalLocation") String hospitalLocation,
			@FormParam("hospitalcontact") String hospitalcontact) {
		String output = hospitalObj.insertHospital(hospitalID, hospitalName, hospitalLocation, hospitalcontact);
		return output;
//		return "insert";
	}
	
	@SuppressWarnings("deprecation")
	@PUT
	@Path("/update")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_PLAIN)
	public String updateHospital(@FormParam("hospitalID") String hospitalID,
			@FormParam("hospitalName") String hospitalName, 
			@FormParam("hospitalLocation") String hospitalLocation,
			@FormParam("hospitalcontact") String hospitalcontact) {
		// Convert the input string to a JSON object
//		JsonObject hospitalObject = new JsonParser().parse(hospitalData).getAsJsonObject();
//		// Read the values from the JSON object
//		String hospitalID = hospitalObject.get("hospitalID").getAsString();
//		String hospitalName = hospitalObject.get("hospitalName").getAsString();
//		String hospitalLocation = hospitalObject.get("hospitalLocation").getAsString();
//		String hospitalcontact = hospitalObject.get("hospitalcontact").getAsString();
//		
//
		String output = hospitalObj.updateHospital(hospitalID, hospitalName, hospitalLocation, hospitalcontact);
		return output;
		
//		return "update";
	}
//
//
	@DELETE
	@Path("/delete")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces(MediaType.TEXT_PLAIN)
	public String deleteHospital(@QueryParam("hospitalID") String hospitalID)
	{
	//Convert the input string to an XML document
//	JsonObject doc = new JsonParser().parse(hospitalData).getAsJsonObject();
//	//Read the value from the element <itemID>
//	String hospitalID = doc.get("hospitalID").getAsString();
		System.out.println(hospitalID);
		String output = hospitalObj.deleteHospital(hospitalID);
		return output;
		
//		return "delete";
	}
}
