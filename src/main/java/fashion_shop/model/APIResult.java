package fashion_shop.model;

import java.io.Serializable;

import java.io.Serializable;
import java.util.List;

import fashion_shop.entity.Product;

public class APIResult implements Serializable {

    private static final long serialVersionUID = 1L;

    private int code;
    private int cluster;
    private String status;  // Trường để chứa trạng thái của API (ví dụ: success, error)
    private List<Product> data;  // Danh sách các sản phẩm liên quan

    // Constructor
    public APIResult(int code, int cluster, String status, List<Product> data) {
        this.code = code;
        this.cluster = cluster;
        this.status = status;
        this.data = data;
    }

    public APIResult() {
    }

    // Getter và Setter
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public int getCluster() {
        return cluster;
    }

    public void setCluster(int cluster) {
        this.cluster = cluster;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<Product> getData() {
        return data;
    }

    public void setData(List<Product> data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "APIResult [code=" + code + ", cluster=" + cluster + ", status=" + status + ", data=" + data + "]";
    }
}
