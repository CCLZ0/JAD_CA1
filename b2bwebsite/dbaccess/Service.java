package com.myshop.b2bwebsite.dbaccess;

public class Service {
    private int id;
    private int categoryId;
    private String serviceName;
    private String description;
    private double price;
    private String img;
    private double averageRating;
    private int bookingCount;

    public Service(int id, int categoryId, String serviceName, String description, double price, String img) {
        this.id = id;
        this.categoryId = categoryId;
        this.serviceName = serviceName;
        this.description = description;
        this.price = price;
        this.img = img;
    }

    public Service() {
	}

	public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }

    public int getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) {
        this.bookingCount = bookingCount;
    }
    
    // Getters and setters for the avg rating and booking count above

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    @Override
    public String toString() {
        return "Service{" +
                "id=" + id +
                ", categoryId=" + categoryId +
                ", serviceName='" + serviceName + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", img='" + img + '\'' +
                '}';
    }
}