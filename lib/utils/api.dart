class Api {
  static String host = "http://192.168.0.102/restapi";

  static String loginRider = "$host/api/login_rider.php";
  static String updateRider = "$host/api/update_rider.php";
  static String riders = "$host/api/riders.php";
  static String updateCreditWalletRider =
      "$host/api/update_credit_wallet_rider.php"; //post wallet and credit
  static String uploadRiderImage = "$host/api/upload_rider_image.php";

  static String loginStore = "$host/api/login_store.php";
  static String stores = "$host/api/stores.php";
  static String uploadStoreImage = "$host/api/upload_store_image.php";
  static String updateStore = "$host/api/update_store.php";
  static String updateStorePassword = "$host/api/update_store_password.php";
  static String updateStoreLatLng = "$host/api/update_store_latlng.php";
  static String updateStoreStatus = "$host/api/update_store_status.php";

  static String withdrawStore = "$host/api/withdraw_stores.php";

  static String orders = "$host/api/orders.php";

  static String orderDetails = "$host/api/order_details.php";

  static String loginCustomer = "$host/api/login_customer.php";
  static String customer = "$host/api/customers.php";
  static String registerCustomer = "$host/api/add_customer.php";

  static String addCustomerAddress = "$host/api/add_address.php";
  static String addresses = "$host/api/addresses.php";
  static String updateAddrStatus = "$host/api/update_addr_status.php";

  static String uploadImage = "$host/api/upload_image.php";
  static String updateCustomer = "$host/api/update_customer.php";

  static String products = "$host/api/products.php"; //get products
  static String updateProduct = "$host/api/update_product.php"; //update product
  static String updateProductStatus =
      "$host/api/update_product_status.php"; //update status product
  static String deleteProduct = "$host/api/delete_product.php";

  static String productImages = "$host/api/product_images.php";
  static String uploadProductImage = "$host/api/upload_product_image.php";

  static String imageUrl = "$host/api/uploads/";
}
