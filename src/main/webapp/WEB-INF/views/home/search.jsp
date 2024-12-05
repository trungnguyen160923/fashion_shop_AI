<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="https://d-themes.com/html/riode/images/icons/favicon.png">
    <title>Search Results</title>
    <base href="${pageContext.servletContext.contextPath}/">

    <!-- External CSS files -->
    <link href="<c:url value='/resources/home/dist/css/reset.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/home.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/owl.carousel.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/home/dist/css/owl.theme.default.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />

    <!-- Custom Styles for search results -->
    <style>
    
        .hover-p-color {
  -webkit-transition: 0.3s;
  transition: 0.3s;
}

.hover-p-color:hover {
  color: #1e90ff !important;
}

@-webkit-keyframes slideInDown {
  from {
    margin-top: -60px;
  }
  to {
    margin-top: 0;
  }
}

@keyframes slideInDown {
  from {
    margin-top: -60px;
  }
  to {
    margin-top: 0;
  }
}

.row {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-wrap: wrap;
      flex-wrap: wrap;
  margin: -10px;
}

.row .col-1 {
  display: block;
  width: 8.33333%;
  padding: 10px;
}

.row .col-1 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-2 {
  display: block;
  width: 16.66667%;
  padding: 10px;
}

.row .col-2 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-3 {
  display: block;
  width: 25%;
  padding: 10px;
}

.row .col-3 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-4 {
  display: block;
  width: 33.33333%;
  padding: 10px;
}

.row .col-4 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-5 {
  display: block;
  width: 41.66667%;
  padding: 10px;
}

.row .col-5 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-6 {
  display: block;
  width: 50%;
  padding: 10px;
}

.row .col-6 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-7 {
  display: block;
  width: 58.33333%;
  padding: 10px;
}

.row .col-7 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-8 {
  display: block;
  width: 66.66667%;
  padding: 10px;
}

.row .col-8 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-9 {
  display: block;
  width: 75%;
  padding: 10px;
}

.row .col-9 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-10 {
  display: block;
  width: 83.33333%;
  padding: 10px;
}

.row .col-10 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-11 {
  display: block;
  width: 91.66667%;
  padding: 10px;
}

.row .col-11 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.row .col-12 {
  display: block;
  width: 100%;
  padding: 10px;
}

.row .col-12 .col-item {
  -webkit-box-shadow: 0 0 4px -2px;
          box-shadow: 0 0 4px -2px;
}

.container {
  max-width: 1220px;
  margin: 0 auto;
  padding: 0 20px;
}

body {
  overflow-x: hidden;
  background-color: #fff;
}

header .header-top {
  background-color: #F2F3F5;
}

header .header-top .container {
  height: 45px;
}

header .header-top p,
header .header-top a {
  font-size: 12px;
  font-weight: 400;
  line-height: 45px;
  color: #666;
}

header .header-top a:first-child {
  position: relative;
  padding-right: 20px;
}

header .header-top a:first-child::after {
  content: '';
  display: block;
  position: absolute;
  width: 1px;
  height: 25px;
  right: 0;
  top: 50%;
  -webkit-transform: translateY(-50%);
          transform: translateY(-50%);
  background-color: #e1e1e1;
}

header .header-top i {
  font-size: 15px;
  margin: 1px 7px 0 23px;
  -webkit-transform: translateY(1px);
          transform: translateY(1px);
}

header .header-middle {
  background-color: white;
  padding: 32px 0;
}

header .header-middle .header-left .logo {
  width: 154px;
  margin-right: 77px;
}

header .header-middle .header-left .menu li {
  margin-right: 30px;
}

header .header-middle .header-left .menu li:active a {
  color: #1e90ff;
}

header .header-middle .header-left .menu li a {
  font-size: 14px;
  font-weight: 700;
  line-height: 1;
  letter-spacing: -0.1px;
  color: #222;
}

header .header-middle .header-left .menu li a:hover {
  color: #1e90ff;
  -webkit-transition: 0.2s;
  transition: 0.2s;
}

header .header-middle .header-left .menu li.search {
  background-color: #F2F3F5;
  padding: 15px;
  height: 40px;
}

header .header-middle .header-left .menu li.search input {
  width: 200px;
  background-color: #F2F3F5;
  font-size: 12px;
}

header .header-middle .header-left .menu li.search input::-webkit-input-placeholder {
  font-size: 12px;
}

header .header-middle .header-left .menu li.search input:-ms-input-placeholder {
  font-size: 12px;
}

header .header-middle .header-left .menu li.search input::-ms-input-placeholder {
  font-size: 12px;
}

header .header-middle .header-left .menu li.search input::placeholder {
  font-size: 12px;
}

header .header-middle .header-left .menu li.search a:hover {
  color: #1e90ff;
  -webkit-transition: 0.2s;
  transition: 0.2s;
}

header .header-middle .header-right li {
  margin-left: 30px;
}

header .header-middle .header-right li i {
  font-size: 22px;
  -webkit-transform: translateY(1px);
          transform: translateY(1px);
  color: #222;
}

header .header-middle .header-right li i:hover {
  color: #1e90ff;
  -webkit-transition: 0.2s;
  transition: 0.2s;
}

header .header-middle .header-right .cart-group {
  position: relative;
}

header .header-middle .header-right .cart-group::before {
  content: '';
  position: absolute;
  width: 250%;
  height: 200%;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
}

header .header-middle .header-right .cart-group .prod-quantity {
  position: absolute;
  top: -4px;
  right: -8px;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  width: 15px;
  height: 15px;
  background-color: #1e90ff;
  color: white;
  border-radius: 50%;
  font-size: 11px;
  line-height: 0.8;
}

header .header-middle .header-right .cart-group .cart {
  visibility: hidden;
  opacity: 0;
  -webkit-transform: translateY(8px);
          transform: translateY(8px);
  border-radius: 4px;
  position: absolute;
  top: 120%;
  right: 0;
  z-index: 200;
  padding: 30px;
  background-color: white;
  -webkit-box-shadow: 0 5px 30px 2px rgba(0, 0, 0, 0.2);
          box-shadow: 0 5px 30px 2px rgba(0, 0, 0, 0.2);
}

header .header-middle .header-right .cart-group .cart .show-prods {
  overflow: auto;
  height: 200px;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod {
  position: relative;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  width: 270px;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod-image {
  padding: 0;
  width: 80px;
  height: 90px;
  margin-right: 25px;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod-info {
  padding: 0;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod-name {
  display: inline-block;
  font-size: 14px;
  font-weight: 600;
  letter-spacing: -0.35px;
  line-height: 18.76px;
  margin-bottom: 16px;
  margin-right: 10px;
  color: #666;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod p {
  font-size: 16px;
  font-weight: 400;
  letter-spacing: -0.35px;
  line-height: 1;
  margin-right: 10px;
  color: #666;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod p .price {
  font-weight: 600;
  color: #222;
  margin-left: 10px;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod p .quantity {
  margin-right: 10px;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod .btn-remove {
  position: absolute;
  right: 0;
  top: 50%;
  -webkit-transform: translateY(-50%);
          transform: translateY(-50%);
  width: 21px;
  height: 21px;
  background-color: white;
  border: 1px solid #ccc;
  color: #222;
  border-radius: 50%;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center;
  cursor: pointer;
}

header .header-middle .header-right .cart-group .cart .show-prods .prod .btn-remove i {
  font-size: 13px;
  -webkit-transform: translateY(-1px);
          transform: translateY(-1px);
}

header .header-middle .header-right .cart-group .cart .show-prods .prod:not(:first-child) {
  margin-top: 20px;
}

header .header-middle .header-right .cart-group .cart .subtotal {
  margin: 20px 0;
  border-top: 1px solid #edeef0;
  border-bottom: 1px solid #edeef0;
  padding: 17px 0 15px;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: justify;
      -ms-flex-pack: justify;
          justify-content: space-between;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  font-size: 14px;
  font-weight: 400;
}

header .header-middle .header-right .cart-group .cart .subtotal .total-price {
  font-weight: 700;
  font-size: 16px;
}

header .header-middle .header-right .cart-group .cart .subtotal label {
  margin-left: 4px;
  color: #666;
}

header .header-middle .header-right .cart-group .cart .action {
  text-align: center;
}

header .header-middle .header-right .cart-group .cart .btn-view-cart {
  display: inline-block;
  margin-bottom: 20px;
  border-bottom: 2px solid #1e90ff;
  font-size: 14px;
  font-weight: 700;
  letter-spacing: 0.14px;
  line-height: 18px;
  color: #222;
  text-transform: capitalize;
}

header .header-middle .header-right .cart-group .cart .btn-view-cart:hover {
  color: #1e90ff;
}

header .header-middle .header-right .cart-group .cart .btn-check-out {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center;
  width: 100%;
  height: 50px;
  border-radius: 4px;
  background-color: #222;
  color: white;
  font-size: 14px;
  font-weight: 700;
  -webkit-transition: 0.3s;
  transition: 0.3s;
}

header .header-middle .header-right .cart-group .cart .btn-check-out:hover {
  opacity: 0.9;
}

header .header-middle .header-right .cart-group:hover .cart {
  visibility: visible;
  opacity: 1;
  -webkit-transition: 0.3s;
  transition: 0.3s;
  -webkit-transform: translateY(0);
          transform: translateY(0);
}

header .header-middle .header-right .user-area {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  color: #333;
  font-weight: 600;
}

header .header-middle .header-right .user-area .user-name {
  font-size: 14px;
}

header .header-middle .header-right .user-area .user-thumbnail {
  width: 29px;
  height: 29px;
  overflow: hidden;
  margin-left: 8px;
  border-radius: 50%;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center;
  border: 1px solid #ccc;
}

header .header-middle .header-right .user-area:hover {
  color: #1e90ff;
}

header .header-middle.fixed {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  padding: 15px 0 14px;
  z-index: 99999;
  -webkit-box-shadow: 0 4px 5px 0 rgba(0, 0, 0, 0.1);
          box-shadow: 0 4px 5px 0 rgba(0, 0, 0, 0.1);
  -webkit-animation: slideInDown 0.3s ease;
          animation: slideInDown 0.3s ease;
}

header .header-support {
  height: 108px;
  display: none;
}

header .header-support.active {
  display: block;
}

.footer-middle {
  padding: 70px 0 26px;
  border-top: 2px solid #F2F3F5;
  border-bottom: 2px solid #F2F3F5;
}

.footer-middle .title {
  padding: 6px 0;
  margin-bottom: 8px;
  font-size: 18px;
  font-weight: 600;
  letter-spacing: 0.1px;
  line-height: 21.6px;
  color: #222;
}

.footer-middle li,
.footer-middle p {
  margin-bottom: 15px;
  font-size: 13px;
  font-weight: 500;
  line-height: 15.6px;
  color: #666;
  -webkit-transition: 0.3s;
  transition: 0.3s;
}

.footer-middle li:hover {
  cursor: pointer;
  color: #1e90ff;
}

.footer-middle form {
  width: 100%;
  height: 50px;
  margin-bottom: 30px;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
}

.footer-middle form input {
  -webkit-box-flex: 1;
      -ms-flex-positive: 1;
          flex-grow: 1;
  font-size: 12px;
  font-weight: 400;
  line-height: 18px;
  padding: 10px 13px;
  border-radius: 3px 0 0 3px;
  background-color: #F2F3F5;
  color: #666;
}

.footer-middle form input:focus::-webkit-input-placeholder {
  opacity: 0;
}

.footer-middle form input:focus:-ms-input-placeholder {
  opacity: 0;
}

.footer-middle form input:focus::-ms-input-placeholder {
  opacity: 0;
}

.footer-middle form input:focus::placeholder {
  opacity: 0;
}

.footer-middle form button {
  padding: 0 16px;
  border-radius: 5px;
  background-color: #1e90ff;
  color: white;
  font-size: 13px;
  font-weight: 700;
  line-height: 1;
  cursor: pointer;
  text-transform: uppercase;
}

.footer-middle form button i {
  margin-left: 8px;
}

.footer-middle .info {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: justify;
      -ms-flex-pack: justify;
          justify-content: space-between;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
}

.footer-middle .info .medias {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
}

.footer-middle .info .medias a {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  width: 30px;
  height: 30px;
  border: 1px solid #666;
  border-radius: 50%;
  color: #666;
  margin-right: 8px;
  -webkit-transition: 0.3s;
  transition: 0.3s;
}

.footer-middle .info .medias a i {
  font-size: 16px;
}

.footer-middle .info .medias a:hover {
  border-color: #1e90ff;
  background-color: #1e90ff;
}

.footer-middle .info .medias a:hover i {
  color: white;
}

.footer-middle .info img {
  width: 135px;
}

.footer-bottom {
  padding: 35px;
  text-align: center;
  font-size: 13px;
  font-weight: 500;
  color: #666;
}

.main .banner {
  height: 250px;
  background: url("https://d-themes.com/html/riode/images/demos/demo4/page-header.jpg") center center/cover;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
      -ms-flex-direction: column;
          flex-direction: column;
}

.main .banner h1 {
  font-size: 40px;
  font-weight: 600;
  line-height: 45px;
  color: white;
  text-align: center;
}

.main .banner p {
  padding: 14px 0;
  font-size: 16px;
  font-weight: 400;
  line-height: 1.5;
  color: #F2F3F5;
  text-align: center;
}

.main .banner a {
  color: #F2F3F5;
}

.main .banner a:hover {
  color: white;
}

.main .page-content .aside-header {
  height: 90px;
  padding-top: 30px;
}

.main .page-content .aside-header a {
  display: inline-block;
  padding: 10px 15px;
  border: 2px solid #1e90ff;
  border-radius: 3px;
  font-size: 14px;
  font-weight: 700;
  line-height: 16.8px;
  color: #1e90ff;
  -webkit-transition: 0.3s;
  transition: 0.3s;
}

.main .page-content .aside-header a i {
  margin-left: 8px;
}

.main .page-content .aside-header a:hover {
  background-color: #1e90ff;
  color: white;
}

.main .page-content .aside .list {
  border-top: 3px solid #eee;
}

.main .page-content .aside .list h2 {
  padding: 26px 3px;
  font-size: 18px;
  font-weight: 600;
  letter-spacing: -0.54px;
  line-height: 21.6px;
  color: #222;
}

.main .page-content .aside .list li {
  padding: 14px 3px;
  -webkit-transition: 0.3s;
  transition: 0.3s;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
}

.main .page-content .aside .list li input {
  width: 18px;
  height: 18px;
  margin-right: 8px;
}

.main .page-content .aside .list li a, .main .page-content .aside .list li label {
  font-size: 13px;
  font-weight: 400;
  line-height: 16.9px;
  color: #222;
}

.main .page-content .aside .list li:not(:last-child) {
  border-bottom: 1px solid #eee;
}

.main .page-content .aside .list li:hover {
  color: #1e90ff;
}

.main .page-content .aside .list li:hover a, .main .page-content .aside .list li:hover label {
  color: #1e90ff;
}

.main .page-content .main-content .main-header {
  height: 90px;
  padding-top: 30px;
}
        .product {
            position: relative;
            overflow: hidden;
        }

        .product-image {
            position: relative;
        }

        .btn-view {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 16px 0;
            text-align: center;
            color: white;
            background-color: #1e90ff;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: -0.35px;
            line-height: 17px;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s, visibility 0s 0.3s;
        }

        .product:hover .btn-view {
            opacity: 1;
            visibility: visible;
            transition: opacity 0.3s, visibility 0s;
        }

        .btn-add {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 35px;
            height: 35px;
            border: 1px solid #999;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .product:hover .btn-add {
            opacity: 1;
        }

        /* Cấu trúc phần tử sản phẩm */
        .product-content {
            padding: 14px 0 20px;
        }

        .product-category {
            display: block;
            font-size: 10px;
            font-weight: 400;
            line-height: 1;
            margin-bottom: 5px;
            color: rgba(102, 102, 102, 0.6);
        }

        .product-name {
            font-size: 14px;
            font-weight: 400;
            color: #666;
            margin-bottom: 3px;
        }

        .product-price {
            font-size: 16px;
            font-weight: 600;
            line-height: 30px;
            margin-bottom: 3px;
            color: #222;
        }

        .review {
            color: rgba(102, 102, 102, 0.6);
            font-size: 11px;
            font-weight: 400;
            line-height: 1;
            display: flex;
            align-items: center;
        }

        .list-stars {
            display: flex;
            margin-right: 12px;
        }

        .list-stars .active {
            color: #f1c40f;
        }

        .product-image .new {
            position: absolute;
            left: 20px;
            top: 20px;
            display: inline-block;
            margin-bottom: 5px;
            padding: 5px 11px;
            font-size: 11px;
            font-weight: 600;
            line-height: 1;
            color: white;
            background-color: #1e90ff;
            border-radius: 2px;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            z-index: 10;
        }
    </style>
</head>

<body>
    <%@ include file="/WEB-INF/views/header.jsp" %>

    <main class="main">
        <section class="banner">
            <h1>RIODE SHOP</h1>
            <p><a href="home/index.htm"><i class="fa-solid fa-house"></i></a> / Search Results</p>
        </section>

        <div class="container">
            <section class="page-content">
                <div class="row">
                    <aside class="aside col-3">
                        <div class="aside-header">
                            <a href="filterproducts.htm">FILTER <i class="fa-solid fa-filter"></i></a>
                        </div>

                        <div class="list">
                            <h2>All Categories</h2>
                            <ul>
                                <c:forEach var="c" items="${listCat}" begin="0" end="7" step="1">
                                    <li><a href="home/products/${c.idCategory}.htm">${c.nameCategory}</a></li>
                                </c:forEach>
                            </ul>
                        </div>

                        <div class="list">
                            <h2>Size</h2>
                            
         <ul>
                                <li>
                                    <input type="checkbox" name="size" id="sizeXL">
                                    <label for="sizeXL">Extra Large</label>
        
                                </li>
        
                                <li>
                                    <input type="checkbox" name="size" id="sizeL">
                                    <label for="sizeL">Large</label>
                                </li>
        
                                <li>
                                    <input type="checkbox" name="size" id="sizeM">
                                    <label for="sizeM">Medium</label>
                                </li>
        
                                <li>
                                    <input type="checkbox" name="size" id="sizeS">
                                    <label for="sizeS">Small</label>
                                </li>
                            </ul>
                        </div>

                        <div class="list">
                            <h2>Color</h2>
                            <ul>
                                <li><input type="checkbox" name="color" id="black"><label for="black">Black</label></li>
                                <li><input type="checkbox" name="color" id="blue"><label for="blue">Blue</label></li>
                                <li><input type="checkbox" name="color" id="green"><label for="green">Green</label></li>
                                <li><input type="checkbox" name="color" id="white"><label for="white">White</label></li>
                            </ul>
                        </div>
                    </aside>

                    <section class="main-content col-9">
                        <div class="main-header">
                            <h2>Search Results for: "${query}"</h2>
                        </div>

                        <div class="list-products">
                            <div class="row">
                                <c:if test="${empty products}">
                                    <p>No products found for your search.</p>
                                </c:if>

                                <c:if test="${not empty products}">
                                    <c:forEach var="p" items="${products}">
                                        <div class="col-4 product">
                                            <div class="product-image">
                                                <img src="${p.image}" alt="${p.name}">
                                                <div class="new">NEW</div>
                                                <a href="home/detail/${p.idProduct}.htm" class="btn-view">VIEW DETAILS</a>
                                                <a href="#" class="btn-add"><i class="fa-solid fa-bag-shopping"></i></a>
                                            </div>

                                            <div class="product-content">
                                                <a href="home/products/${p.getProductCategory().getIdCategory()}.htm" class="product-category hover-p-color">${p.getProductCategory().getNameCategory()}</a>
                                                <h2><a href="home/detail/${p.idProduct}.htm" class="product-name hover-p-color">${p.name}</a></h2>
                                                <p class="product-price">$${p.price}</p>
                                                <div class="review">
                                                    <ul class="list-stars">
                                                        <li class="active"><i class="fa-solid fa-star"></i></li>
                                                        <li class="active"><i class="fa-solid fa-star"></i></li>
                                                        <li class="active"><i class="fa-solid fa-star"></i></li>
                                                        <li><i class="fa-solid fa-star"></i></li>
                                                        <li><i class="fa-solid fa-star"></i></li>
                                                    </ul>
                                                    (6 Reviews)
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>

                        <div class="tool-box">
                            <p class="showing-products">Showing 12 of 56 Products</p>
                            <div class="pagination">
                                <div class="page-item"><a class="disable" href=""><i class="fa-solid fa-arrow-left"></i> Prev</a></div>
                                <div class="page-item"><a class="active" href="">1</a></div>
                                <div class="page-item"><a href="">2</a></div>
                                <div class="page-item">...</div>
                                <div class="page-item"><a href="">6</a></div>
                                <div class="page-item"><a href="">Next <i class="fa-solid fa-arrow-right"></i></a></div>
                            </div>
                        </div>
                    </section>
                </div>
            </section>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/footer.jsp" %>

    <!-- External JS files -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="<c:url value='/resources/home/dist/js/owl.carousel.js' />"></script>
    <script src="<c:url value='/resources/home/dist/js/home.js' />"></script>
</body>

</html>