package com.myshop.b2bwebsite.controller;

import com.myshop.b2bwebsite.dbaccess.Service;

import com.myshop.b2bwebsite.service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@RestController
public class ServiceControllerClient {

	@Autowired
	private ServiceService serviceService;

	@GetMapping("/b2b/service/{id}")
	public Service getService(@PathVariable int id) {
		return serviceService.getService(id);
	}

	@GetMapping("/b2b/services")
	public List<Service> getAllServices() {
		return serviceService.getAllServices();
	}

	@GetMapping("/b2b/services/category/{categoryId}")
	public ModelAndView getServicesByCategory(@PathVariable int categoryId) {
    	List<Service> services = serviceService.getServicesByCategory(categoryId);
    	ModelAndView modelAndView = new ModelAndView("index"); // Ensure this matches your JSP page name
    	modelAndView.addObject("services", services);
    	return modelAndView;
	}

	@PostMapping("/b2b/service")
	public ModelAndView addService(@RequestParam("categoryId") int categoryId,
			@RequestParam("serviceName") String serviceName, @RequestParam("description") String description,
			@RequestParam("price") double price, @RequestParam("img") String img) {
		Service service = new Service();
		service.setCategoryId(categoryId);
		service.setServiceName(serviceName);
		service.setDescription(description);
		service.setPrice(price);
		service.setImg(img);
		serviceService.addService(service);
		return new ModelAndView("redirect:/index");
	}

	@PutMapping("/b2b/service/{id}")
    public ModelAndView updateService(@PathVariable int id,
                                      @RequestParam("categoryId") int categoryId,
                                      @RequestParam("serviceName") String serviceName,
                                      @RequestParam("description") String description,
                                      @RequestParam("price") double price,
                                      @RequestParam("img") String img) {
        Service service = serviceService.getService(id);
        service.setCategoryId(categoryId);
        service.setServiceName(serviceName);
        service.setDescription(description);
        service.setPrice(price);
        service.setImg(img);
        serviceService.updateService(id, service);
        return new ModelAndView("redirect:/index");
    }
	@DeleteMapping("/b2b/service/{id}")
	public boolean deleteService(@PathVariable int id) {
		return serviceService.deleteService(id);
	}

	@GetMapping("/b2b/service/averageRating")
	public List<Map<String, Object>> getAverageRating() {
		return serviceService.getAverageRating();
	}

	@GetMapping("/b2b/service/bookingCount")
	public List<Map<String, Object>> getBookingCount() {
		return serviceService.getBookingCount();
	}
}