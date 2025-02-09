package com.shinepro.admin.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.shinepro.admin.dbaccess.Service;
import com.shinepro.admin.dbaccess.ServiceDAO;

@RestController
@RequestMapping("/service") //Link: http://localhost:8081/admin/service/<path>
public class ServiceController {

	@RequestMapping(method = RequestMethod.GET, path = "/getService/{id}")
	public Service getService(@PathVariable("id") int id) {
		Service service = null;
		try {
			ServiceDAO db = new ServiceDAO();
			service = db.getServiceById(id);
		} catch (Exception e) {
			System.out.println("Error: " + e);
		}
		return service;
	}

	@RequestMapping(method = RequestMethod.GET, path = "/getAllServices")
	public List<Service> getAllServices() {
		List<Service> services = null;
		try {
			ServiceDAO db = new ServiceDAO();
			services = db.getAllServices();
		} catch (SQLException e) {
			System.out.println("Error retrieving all services: " + e);
		}
		return services;
	}

	@RequestMapping(method = RequestMethod.POST, path = "/addService")
	public boolean addService(@RequestBody Service service) {
		boolean result = false;
		try {
			if (service.getImg() != null && !service.getImg().startsWith("../img/")) { //Set the image path with ../img/
                service.setImg("../img/" + service.getImg());
            }
			ServiceDAO db = new ServiceDAO();
			result = db.addService(service);
		} catch (SQLException e) {
			System.out.println("Error adding service: " + e);
		}
		return result;
	}

	@RequestMapping(method = RequestMethod.PUT, path = "/updateService/{id}")
    public boolean updateService(@PathVariable("id") int id, @RequestBody Service service) {
        boolean result = false;
        try {
            if (service.getImg() != null && !service.getImg().startsWith("../img/")) { //Set the image path with ../img/
                service.setImg("../img/" + service.getImg());
            }
            ServiceDAO db = new ServiceDAO();
            service.setId(id); // Ensure the service object has the correct ID
            result = db.updateService(service);
        } catch (SQLException e) {
            System.out.println("Error updating service: " + e);
        }
        return result;
    }
	
	@RequestMapping(method = RequestMethod.DELETE, path = "/deleteService/{id}")
	public boolean deleteService(@PathVariable("id") int id) {
		boolean result = false;
		try {
			ServiceDAO db = new ServiceDAO();
			result = db.deleteService(id);
		} catch (SQLException e) {
			System.out.println("Error deleting service: " + e);
		}
		return result;
	}

	@RequestMapping(method = RequestMethod.GET, path = "/getAverageRating")
	public List<Map<String, Object>> getAverageRating() {
		List<Map<String, Object>> ratings = null;
		try {
			ServiceDAO db = new ServiceDAO();
			ratings = db.getAverageRating();
		} catch (SQLException e) {
			System.out.println("Error retrieving average ratings: " + e);
		}
		return ratings;
	}

	@RequestMapping(method = RequestMethod.GET, path = "/getBookingCount")
	public List<Map<String, Object>> getBookingCount() {
		List<Map<String, Object>> bookings = null;
		try {
			ServiceDAO db = new ServiceDAO();
			bookings = db.getBookingCount();
		} catch (SQLException e) {
			System.out.println("Error retrieving booking counts: " + e);
		}
		return bookings;
	}

	@RequestMapping(method = RequestMethod.GET, path = "/getServicesByCategory/{categoryId}")
    public List<Service> getServicesByCategory(@PathVariable("categoryId") int categoryId) {
        List<Service> services = null;
        try {
            ServiceDAO db = new ServiceDAO();
            services = db.getServicesByCategory(categoryId);
        } catch (SQLException e) {
            System.out.println("Error retrieving services by category: " + e);
        }
        return services;
    }
}