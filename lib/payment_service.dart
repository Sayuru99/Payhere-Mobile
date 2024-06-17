class PaymentService {
  static Map<String, dynamic> createPaymentObject() {
    return {
      "sandbox": true,
      "merchant_id": "1220986",
      "merchant_secret": "MTIyMTYzODM4MTE2MjYyNjY4NjgxOTUxMzQ0MjQ2MjU3NzQ4NDYz",
      "notify_url": "http://sample.com/notify",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "amount": "50.00",
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };
  }
}
