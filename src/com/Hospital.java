package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

public class Hospital {
	
	public Connection connect() {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Properties connectionProps = new Properties();
		    connectionProps.put("user", "root");
		    connectionProps.put("password", "");
			con = (Connection) DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/healthcare?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", connectionProps);
			// For testing
			System.out.print("Successfully connected");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	public String insertHospital(String HspID, String name, String location, String contact) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database";
			}
			// create a prepared statement
			String query = "insert into hospital(hsp_ID,name,location,contact)"
					+ " values ( ?,  ?,  ?,  ?)";
			PreparedStatement preparedStmt = con.prepareStatement(query);

			// binding values
			preparedStmt.setString(1, HspID);
//			preparedStmt.setString(2, HspID);
			preparedStmt.setString(2, name);
			preparedStmt.setString(3, location);
			preparedStmt.setString(4, contact);
			
			// execute the statement
			preparedStmt.execute();
			con.close();
			output = "Inserted successfully";
		} catch (Exception e) {
			output = "Error while inserting";
			System.out.println(e.getMessage());
		}
		return output;

	}
	public String readItems() {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for reading.";
			}
			// Prepare the table to be displayed
			output = "<table id=\"table\"><tr><th>Hospital ID</th>"
					+ "<th>Hospital Name</th><th>Hospital Location</th>" + "<th>Hospital contact</th>"
					+ "<th>Update</th><th>Remove</th></tr>";
			String query = "select * from hospital";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			// iterate through the rows in the result set
			while (rs.next()) {
				String hospitalID = rs.getString("hsp_ID");
				String hospitalName = rs.getString("name");
				String hospitalLocation = rs.getString("location");
				String hospitalContact = rs.getString("contact");
				
				// I Added to table
				
				output += "<tr><td>" + hospitalID + "</td>";
				output += "<td>" + hospitalName + "</td>";
				output += "<td>" + hospitalLocation + "</td>";
				output += "<td>" + hospitalContact + "</td>";
				
				//I added some buttons here
				
				output += "<td><input name=\"btnUpdate\" "
						+ " type=\"button\" class=\"btn btn-primary updateBtn\" data-id = '"+hospitalID+"' data-name = '"+hospitalName+"' data-location = '"+hospitalLocation+"' data-contact = '"+hospitalContact+"' value=\"Update\"></td>"
						+ "<td>" + "<input name=\"btnRemove\" "
						+ " type=\"button\" class=\"btn btn-danger deleteBtn\" data-id = '"+hospitalID+"' value=\"Remove\">"
						+ "<input name=\"itemID\" type=\"hidden\" " + " value=\"" + hospitalID + "\">"
						+ "</td></tr>";
			}
			con.close();
			// Complete the table
			output += "</table>";
		} catch (Exception e) {
			output = "Error while reading the items.";
			System.err.println(e.getMessage());
		}
		return output;
	}
	
	public String updateHospital(String ID, String name, String location, String contact) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for updating.";
			}
			// create a prepared statement
			String query = "UPDATE hospital SET name=?,location=?,contact=? WHERE hsp_ID=?";
			PreparedStatement preparedStmt = con.prepareStatement(query);
			// binding values
//			preparedStmt.setString(1, ID);
			preparedStmt.setString(1, name);
			preparedStmt.setString(2, location);
			preparedStmt.setString(3, contact);
			preparedStmt.setString(4, ID);

			// execute the statement
			preparedStmt.execute();
			con.close();
			output = "Updated successfully";
		} catch (Exception e) {
			output = "Error while updating the item.";
			System.err.println(e.getMessage());
		}
		return output;
	}

	public String deleteHospital(String hospitalID) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for deleting.";
			}
			// create a prepared statement
			String query = "delete from hospital where hsp_ID=?";
			PreparedStatement preparedStmt = con.prepareStatement(query);
			// binding values
			preparedStmt.setString(1, hospitalID);
			// execute the statement
			preparedStmt.execute();
			con.close();
			output = "Deleted successfully";
		} catch (Exception e) {
			output = "Error while deleting the item.";
			System.err.println(e.getMessage());
		}
		return output;
	}
}
