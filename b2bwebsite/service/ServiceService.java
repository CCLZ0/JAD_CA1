package com.myshop.b2bwebsite.service;

import org.springframework.stereotype.Service;

import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Service
public class ServiceService {
    private final String BASE_URL = "http://localhost:8081/service";

    public com.myshop.b2bwebsite.dbaccess.Service getService(int id) {
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(BASE_URL + "/getService/" + id, com.myshop.b2bwebsite.dbaccess.Service.class);
    }

    public List<com.myshop.b2bwebsite.dbaccess.Service> getAllServices() {
        RestTemplate restTemplate = new RestTemplate();
        com.myshop.b2bwebsite.dbaccess.Service[] services = restTemplate.getForObject(BASE_URL + "/getAllServices", com.myshop.b2bwebsite.dbaccess.Service[].class);
        return Arrays.asList(services);
    }

    public boolean addService(com.myshop.b2bwebsite.dbaccess.Service service) {
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.postForObject(BASE_URL + "/addService", service, Boolean.class);
    }

    public boolean updateService(int id, com.myshop.b2bwebsite.dbaccess.Service service) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.put(BASE_URL + "/updateService/" + id, service);
        return true; // Assuming the update is successful
    }

    public boolean deleteService(int id) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.delete(BASE_URL + "/deleteService/" + id);
        return true; // Assuming the deletion is successful
    }

    public List<Map<String, Object>> getAverageRating() {
        RestTemplate restTemplate = new RestTemplate();
        Map<String, Object>[] ratings = restTemplate.getForObject(BASE_URL + "/getAverageRating", Map[].class);
        return Arrays.asList(ratings);
    }

    public List<Map<String, Object>> getBookingCount() {
        RestTemplate restTemplate = new RestTemplate();
        Map<String, Object>[] bookings = restTemplate.getForObject(BASE_URL + "/getBookingCount", Map[].class);
        return Arrays.asList(bookings);
    }

    public List<com.myshop.b2bwebsite.dbaccess.Service> getServicesByCategory(int categoryId) {
        RestTemplate restTemplate = new RestTemplate();
        com.myshop.b2bwebsite.dbaccess.Service[] services = restTemplate.getForObject(BASE_URL + "/getServicesByCategory/" + categoryId, com.myshop.b2bwebsite.dbaccess.Service[].class);
        return Arrays.asList(services);
    }
}