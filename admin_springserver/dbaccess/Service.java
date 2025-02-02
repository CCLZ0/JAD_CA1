package com.shinepro.admin.dbaccess;

public class Service {
    private int id;
    private int categoryId;
    private String serviceName;
    private String description;
    private double price;
    private String img;

    public Service(int id, int categoryId, String serviceName, String description, double price, String img) {
        this.id = id;
        this.categoryId = categoryId;
        this.serviceName = serviceName;
        this.description = description;
        this.price = price;
        this.img = img;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
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