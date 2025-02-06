package models;

public class Booking {
    private int id;
    private String serviceName;
    private String bookingDate;
    private String remarks;
    private String statusName;
    private int statusId;
    private int feedbackId;
    
    public Booking(int id, String serviceName, String bookingDate, String remarks, String statusName,  int statusId, int feedbackId) {
        this.id = id;
        this.serviceName = serviceName;
        this.bookingDate = bookingDate;
        this.remarks = remarks;
        this.statusName = statusName;
        this.statusId = statusId;
        this.feedbackId = feedbackId;
    }
    
    public Booking() {
    	
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }
}